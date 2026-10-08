-- ============================================================================
-- PROYECTO: CORTE & SASTRE - UNIVERSIDAD MARIANO GÁLVEZ
-- CURSO: SEGURIDAD Y AUDITORÍA DE SISTEMAS
-- 01_init_schemas_and_roles.sql
-- ============================================================================

-- 1. EXTENSIONES DE SEGURIDAD CRIPTOGRÁFICA
CREATE EXTENSION IF NOT EXISTS pgcrypto;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 2. CREACIÓN DE ESQUEMAS SEGREGADOS (Zero Trust Data Tiering)
-- Esquema 1: Identidad y Control de Acceso (IAM + ACL)
CREATE SCHEMA IF NOT EXISTS seguridad_iam;

-- Esquema 2: Bóveda de Mercancía (Crown Jewels: Telas, Costos, Fichas de Diseño)
CREATE SCHEMA IF NOT EXISTS mercancia_vault;

-- Esquema 3: Bodega Operativa (WMS: Stock físico, Embalaje, Despacho de camisas)
CREATE SCHEMA IF NOT EXISTS bodega_wms;

-- Esquema 4: Auditoría Forense Inmutable (Hash Chaining SHA-256)
CREATE SCHEMA IF NOT EXISTS auditoria_core;

-- 3. CREACIÓN DE USUARIO DE APLICACIÓN CON PRINCIPIO DE MENOR PRIVILEGIO (RBAC)
DO $$
BEGIN
   IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'app_backend_user') THEN
      CREATE ROLE app_backend_user WITH LOGIN PASSWORD 'BackendServicePassword2026!';
   END IF;
END
$$;

-- Permisos básicos de conexión y uso
GRANT USAGE ON SCHEMA seguridad_iam TO app_backend_user;
GRANT USAGE ON SCHEMA bodega_wms TO app_backend_user;
GRANT USAGE ON SCHEMA mercancia_vault TO app_backend_user;
GRANT USAGE ON SCHEMA auditoria_core TO app_backend_user;
