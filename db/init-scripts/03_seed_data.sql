-- ============================================================================
-- 03_seed_data.sql
-- ============================================================================

-- 1. PROVEEDORES TEXTILES
INSERT INTO mercancia_vault.proveedores (razon_social, nit_cifrado, telefono_contacto, contacto_email)
VALUES 
('Textiles de Alta Gama S.A.', 'NIT-8839201-9', '+502 2333-1122', 'ventas@textilesaltagama.com'),
('Importadora Hilaturas del Norte', 'NIT-1994021-3', '+502 5555-8899', 'pedidos@hilaturasnorte.com');

-- 2. TELAS MAESTRAS
INSERT INTO mercancia_vault.telas (codigo_tela, nombre, composicion, proveedor_id, costo_metro_usd)
VALUES 
('TELA-OXF-01', 'Algodón Oxford Pinpoint', '100% Algodón Mercerizado', 1, 4.50),
('TELA-LIN-02', 'Lino Belga Puro', '100% Lino Natural', 1, 9.20),
('TELA-POP-03', 'Popelina Pima Stretch', '97% Algodón Pima, 3% Spandex', 2, 6.00);

-- 3. CATÁLOGO MAESTRO DE CAMISAS (NICHO DE NEGOCIO CORTE & SASTRE)
INSERT INTO mercancia_vault.camisas_catalogo (sku, nombre, modelo, talla, color, tela_id, costo_produccion_usd, precio_venta_mayorista, precio_venta_publico)
VALUES 
('CYS-OXF-BLA-M', 'Camisa Oxford Slim Fit Blanca', 'Oxford Clásica', 'M', 'Blanco', 1, 14.50, 28.00, 45.00),
('CYS-OXF-BLA-L', 'Camisa Oxford Slim Fit Blanca', 'Oxford Clásica', 'L', 'Blanco', 1, 14.50, 28.00, 45.00),
('CYS-OXF-AZU-M', 'Camisa Oxford Celeste Ejecutivo', 'Oxford Clásica', 'M', 'Celeste', 1, 14.50, 28.00, 45.00),
('CYS-LIN-BEI-L', 'Guayabera Lino Presidencial', 'Guayabera Formal', 'L', 'Beige', 2, 26.00, 52.00, 85.00),
('CYS-POP-NEG-M', 'Camisa Popelina Negra Stretch', 'Ejecutiva Moderna', 'M', 'Negro', 3, 18.00, 35.00, 55.00);

-- 4. ESTANTERÍAS DE BODEGA
INSERT INTO bodega_wms.estanterias (codigo_ubicacion, zona, capacidad_maxima)
VALUES 
('EST-A-01', 'Zona A - Camisas Formales', 500),
('EST-A-02', 'Zona A - Camisas Formales', 500),
('EST-B-01', 'Zona B - Guayaberas y Lino', 300);

-- 5. STOCK INICIAL EN BODEGA
INSERT INTO bodega_wms.stock_inventario (sku, ubicacion_id, cantidad_disponible, cantidad_reservada)
VALUES 
('CYS-OXF-BLA-M', 1, 120, 0),
('CYS-OXF-BLA-L', 1, 95, 0),
('CYS-OXF-AZU-M', 2, 80, 0),
('CYS-LIN-BEI-L', 3, 40, 0),
('CYS-POP-NEG-M', 2, 60, 0);

-- 6. REGISTRO GÉNESIS EN EL LIBRO DE AUDITORÍA
SELECT auditoria_core.registrar_evento(
    'sistema_instalacion', 
    'GENESIS_INIT', 
    'database.corte_y_sastre_db', 
    '{"mensaje": "Base de datos inicializada con éxito", "version": "1.0.0"}'::jsonb, 
    '127.0.0.1'
);
