-- ============================================================================
-- 02_init_tables.sql
-- ============================================================================

-- ----------------------------------------------------------------------------
-- ESQUEMA 0: IDENTIDAD Y CONTROL DE ACCESO (IAM + ACL)
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS seguridad_iam.empleados_acl (
    id SERIAL PRIMARY KEY,
    codigo_empleado VARCHAR(50) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    rol VARCHAR(80) NOT NULL,
    sedes_autorizadas TEXT[] NOT NULL,
    pin_hash VARCHAR(100) NOT NULL,
    estado VARCHAR(20) DEFAULT 'ACTIVO',
    creado_en TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- ----------------------------------------------------------------------------
-- ESQUEMA 1: MERCANCÍA (EL NICHO DEL NEGOCIO - MÁXIMA CONFIDENCIALIDAD)
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS mercancia_vault.proveedores (
    id SERIAL PRIMARY KEY,
    razon_social VARCHAR(150) NOT NULL,
    nit_cifrado VARCHAR(255) NOT NULL,
    telefono_contacto VARCHAR(50),
    contacto_email VARCHAR(100),
    acuerdo_confidencialidad_activo BOOLEAN DEFAULT TRUE,
    creado_en TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS mercancia_vault.telas (
    id SERIAL PRIMARY KEY,
    codigo_tela VARCHAR(50) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    composicion VARCHAR(150) NOT NULL, -- ej: 100% Algodón Egipcio, Popelina Pima
    proveedor_id INT REFERENCES mercancia_vault.proveedores(id),
    costo_metro_usd NUMERIC(10, 2) NOT NULL, -- Dato sensible
    ancho_metros NUMERIC(5, 2) DEFAULT 1.50
);

CREATE TABLE IF NOT EXISTS mercancia_vault.camisas_catalogo (
    id SERIAL PRIMARY KEY,
    sku VARCHAR(60) UNIQUE NOT NULL, -- ej: CYS-OXF-BLA-L
    nombre VARCHAR(150) NOT NULL,
    modelo VARCHAR(50) NOT NULL, -- ej: Oxford Slim Fit, Guayabera Lino
    talla VARCHAR(10) NOT NULL,  -- S, M, L, XL
    color VARCHAR(40) NOT NULL,
    tela_id INT REFERENCES mercancia_vault.telas(id),
    costo_produccion_usd NUMERIC(10, 2) NOT NULL, -- Crown Jewel: Costo real
    precio_venta_mayorista NUMERIC(10, 2) NOT NULL,
    precio_venta_publico NUMERIC(10, 2) NOT NULL,
    activo BOOLEAN DEFAULT TRUE,
    creado_en TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- ----------------------------------------------------------------------------
-- ESQUEMA 2: BODEGA (OPERACIONES LOGÍSTICAS WMS)
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS bodega_wms.estanterias (
    id SERIAL PRIMARY KEY,
    codigo_ubicacion VARCHAR(30) UNIQUE NOT NULL, -- ej: PASILLO-A-EST-03
    zona VARCHAR(50) NOT NULL,
    capacidad_maxima INT NOT NULL
);

CREATE TABLE IF NOT EXISTS bodega_wms.stock_inventario (
    id SERIAL PRIMARY KEY,
    sku VARCHAR(60) NOT NULL REFERENCES mercancia_vault.camisas_catalogo(sku),
    ubicacion_id INT REFERENCES bodega_wms.estanterias(id),
    cantidad_disponible INT NOT NULL CHECK (cantidad_disponible >= 0),
    cantidad_reservada INT NOT NULL DEFAULT 0 CHECK (cantidad_reservada >= 0),
    ultima_actualizacion TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS bodega_wms.ordenes_despacho (
    id SERIAL PRIMARY KEY,
    tracking_uuid UUID DEFAULT gen_random_uuid() UNIQUE,
    id_pedido_origen VARCHAR(100) NOT NULL, -- ID que provino de MongoDB Buffer
    cliente_nombre VARCHAR(150) NOT NULL,
    cliente_direccion TEXT NOT NULL,
    estado VARCHAR(50) NOT NULL DEFAULT 'Solicitado',
    codigo_estado INT NOT NULL DEFAULT 1,
    estado_nombre VARCHAR(80) NOT NULL DEFAULT 'Solicitado',
    operador_asignado VARCHAR(100),
    creado_en TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    despachado_en TIMESTAMP WITH TIME ZONE
);

CREATE TABLE IF NOT EXISTS bodega_wms.ordenes_detalle (
    id SERIAL PRIMARY KEY,
    orden_id INT REFERENCES bodega_wms.ordenes_despacho(id) ON DELETE CASCADE,
    sku VARCHAR(60) NOT NULL REFERENCES mercancia_vault.camisas_catalogo(sku),
    cantidad INT NOT NULL CHECK (cantidad > 0)
);

-- ----------------------------------------------------------------------------
-- ESQUEMA 3: AUDITORÍA FORENSE INMUTABLE (HASH CHAINING SHA-256)
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS auditoria_core.logs_inmutables (
    id BIGSERIAL PRIMARY KEY,
    timestamp_utc TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    actor_identidad VARCHAR(100) NOT NULL, -- ej: 'handheld_vendedor_01', 'sistema_etl'
    accion VARCHAR(50) NOT NULL,          -- 'INGESTA_PEDIDO', 'MODIFICACION_STOCK', 'CONSULTA_COSTO'
    recurso VARCHAR(100) NOT NULL,        -- 'mercancia_vault.camisas_catalogo', 'bodega_wms.stock'
    detalle_json JSONB NOT NULL,
    ip_origen VARCHAR(45) NOT NULL,
    hash_previo VARCHAR(64) NOT NULL,
    hash_actual VARCHAR(64) NOT NULL
);

-- FUNCIÓN PARA REGISTRAR EVENTO AUDITADO GARANTIZANDO HASH CHAINING
CREATE OR REPLACE FUNCTION auditoria_core.registrar_evento(
    p_actor VARCHAR(100),
    p_accion VARCHAR(50),
    p_recurso VARCHAR(100),
    p_detalle JSONB,
    p_ip VARCHAR(45)
) RETURNS BIGINT AS $$
DECLARE
    v_ultimo_hash VARCHAR(64);
    v_nuevo_hash VARCHAR(64);
    v_id BIGINT;
    v_timestamp TIMESTAMP WITH TIME ZONE;
BEGIN
    v_timestamp := clock_timestamp();

    -- Obtener el hash del último bloque registrado
    SELECT hash_actual INTO v_ultimo_hash 
    FROM auditoria_core.logs_inmutables 
    ORDER BY id DESC LIMIT 1;

    -- Si es el primer registro, usar Hash Génesis
    IF v_ultimo_hash IS NULL THEN
        v_ultimo_hash := '0000000000000000000000000000000000000000000000000000000000000000';
    END IF;

    -- Calcular SHA-256(timestamp || actor || accion || recurso || detalle || ip || ultimo_hash)
    v_nuevo_hash := encode(digest(
        v_timestamp::TEXT || p_actor || p_accion || p_recurso || p_detalle::TEXT || p_ip || v_ultimo_hash, 
        'sha256'
    ), 'hex');

    INSERT INTO auditoria_core.logs_inmutables (
        timestamp_utc, actor_identidad, accion, recurso, detalle_json, ip_origen, hash_previo, hash_actual
    ) VALUES (
        v_timestamp, p_actor, p_accion, p_recurso, p_detalle, p_ip, v_ultimo_hash, v_nuevo_hash
    ) RETURNING id INTO v_id;

    RETURN v_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- FUNCIÓN DE AUDITORÍA: VERIFICA SI ALGUIEN MODIFICÓ UN LOG MANUALMENTE
CREATE OR REPLACE FUNCTION auditoria_core.verificar_integridad()
RETURNS TABLE (es_valido BOOLEAN, registros_auditados BIGINT, error_en_id BIGINT) AS $$
DECLARE
    r RECORD;
    v_hash_esperado VARCHAR(64);
    v_hash_previo_acumulado VARCHAR(64) := '0000000000000000000000000000000000000000000000000000000000000000';
    v_conteo BIGINT := 0;
BEGIN
    FOR r IN SELECT * FROM auditoria_core.logs_inmutables ORDER BY id ASC LOOP
        v_conteo := v_conteo + 1;

        -- Verificar que el hash_previo coincide con el anterior
        IF r.hash_previo <> v_hash_previo_acumulado THEN
            RETURN QUERY SELECT FALSE, v_conteo, r.id;
            RETURN;
        END IF;

        -- Recalcular el hash del bloque actual
        v_hash_esperado := encode(digest(
            r.timestamp_utc::TEXT || r.actor_identidad || r.accion || r.recurso || r.detalle_json::TEXT || r.ip_origen || r.hash_previo,
            'sha256'
        ), 'hex');

        IF r.hash_actual <> v_hash_esperado THEN
            RETURN QUERY SELECT FALSE, v_conteo, r.id;
            RETURN;
        END IF;

        v_hash_previo_acumulado := r.hash_actual;
    END LOOP;

    RETURN QUERY SELECT TRUE, v_conteo, NULL::BIGINT;
END;
$$ LANGUAGE plpgsql;

-- TRIGGER DE INMUTABILIDAD WORM (BLOQUEO ESTRICTO DE UPDATE Y DELETE)
CREATE OR REPLACE FUNCTION auditoria_core.bloquear_alteracion_worm()
RETURNS TRIGGER AS $$
BEGIN
    RAISE EXCEPTION '[SEGURIDAD CRÍTICA] Violación de Inmutabilidad WORM: Los registros de auditoría no pueden ser modificados ni eliminados.';
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS tg_bloqueo_modificacion_worm ON auditoria_core.logs_inmutables;
CREATE TRIGGER tg_bloqueo_modificacion_worm
BEFORE UPDATE OR DELETE ON auditoria_core.logs_inmutables
FOR EACH ROW EXECUTE FUNCTION auditoria_core.bloquear_alteracion_worm();

-- ASIGNAR PERMISOS AL USUARIO DE LA APLICACIÓN
GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA seguridad_iam TO app_backend_user;
GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA bodega_wms TO app_backend_user;
GRANT SELECT ON ALL TABLES IN SCHEMA mercancia_vault TO app_backend_user;
GRANT SELECT, INSERT ON auditoria_core.logs_inmutables TO app_backend_user;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA seguridad_iam TO app_backend_user;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA bodega_wms TO app_backend_user;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA auditoria_core TO app_backend_user;
GRANT EXECUTE ON FUNCTION auditoria_core.registrar_evento TO app_backend_user;
GRANT EXECUTE ON FUNCTION auditoria_core.verificar_integridad TO app_backend_user;
