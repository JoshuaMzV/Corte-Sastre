--
-- PostgreSQL database dump
--

\restrict 0mFf1YBcaGrqGMG63f8bH5Ye1KOk2OAAJBRvV4snO28MFchSVxfRiqMZjcTzl5J

-- Dumped from database version 16.15
-- Dumped by pg_dump version 16.15

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: logs_inmutables; Type: TABLE DATA; Schema: auditoria_core; Owner: postgres_admin
--

INSERT INTO auditoria_core.logs_inmutables VALUES (1, '2026-09-16 22:48:43.473436+00', 'sistema_instalacion', 'GENESIS_INIT', 'database.corte_y_sastre_db', '{"mensaje": "Base de datos inicializada con éxito", "version": "1.0.0"}', '127.0.0.1', '0000000000000000000000000000000000000000000000000000000000000000', 'f1b42f6442af4e86ba02168c8bb070030ed4373d5faf79b96bf1f073cf525469');
INSERT INTO auditoria_core.logs_inmutables VALUES (2, '2026-09-16 23:04:34.597141+00', 'HANDHELD-TIENDA-ZONA10', 'INGESTA_PEDIDO_BUFFER', 'mongo.pedidos_ingesta', '{"cliente": "Corporacion Hotelera Maya", "buffer_id": "6aab2082ed52c557164973e2", "cantidad_prendas": 1}', '172.23.0.1', 'f1b42f6442af4e86ba02168c8bb070030ed4373d5faf79b96bf1f073cf525469', 'ad98d825aadc61105c4d9ecd0eaf9c6965704315a1bfe1991238d5a4afc456b3');
INSERT INTO auditoria_core.logs_inmutables VALUES (3, '2026-09-16 23:04:36.767476+00', 'worker_despacho_auto', 'DESPACHO_CREADO_BODEGA', 'bodega_wms.ordenes_despacho', '{"items": [{"sku": "CYS-OXF-BLA-M", "cantidad": 5}], "cliente": "Corporacion Hotelera Maya", "orden_bodega_id": 1, "pedido_buffer_id": "6aab2082ed52c557164973e2"}', '127.0.0.1', 'ad98d825aadc61105c4d9ecd0eaf9c6965704315a1bfe1991238d5a4afc456b3', 'efea724e5fc7f21e0b44ad137d1bc2c0080aaeba5fae5ee886475af13822a3fc');
INSERT INTO auditoria_core.logs_inmutables VALUES (4, '2026-09-17 01:05:14.216652+00', 'HANDHELD-ZONA10-CORPO', 'INGESTA_PEDIDO_BUFFER', 'mongo.pedidos_ingesta', '{"cliente": "Corporación Textil del Sur", "buffer_id": "6aab3ccab6a95af42dbcc5c7", "cantidad_prendas": 1}', '192.168.11.62', 'efea724e5fc7f21e0b44ad137d1bc2c0080aaeba5fae5ee886475af13822a3fc', 'd77fb769eb065916c40fa4292163dbe8703bdb8dc7f82c9837b59e5c55cb8c42');
INSERT INTO auditoria_core.logs_inmutables VALUES (5, '2026-09-17 01:05:16.153566+00', 'worker_despacho_auto', 'DESPACHO_CREADO_BODEGA', 'bodega_wms.ordenes_despacho', '{"items": [{"sku": "CYS-OXF-BLA-M", "cantidad": 1}], "cliente": "Corporación Textil del Sur", "orden_bodega_id": 2, "pedido_buffer_id": "6aab3ccab6a95af42dbcc5c7"}', '127.0.0.1', 'd77fb769eb065916c40fa4292163dbe8703bdb8dc7f82c9837b59e5c55cb8c42', '43d82458424ad75cc73096a68c80716a3ebf132acaa529641efb572e8f067781');
INSERT INTO auditoria_core.logs_inmutables VALUES (6, '2026-09-17 01:54:02.386962+00', 'HANDHELD-IPHONE-01', 'INGESTA_PEDIDO_BUFFER', 'mongo.pedidos_ingesta', '{"cliente": "Prueba Movil Flag ETL", "flag_etl": "ETL_POS_Z10_INCREMENTAL", "buffer_id": "6aab483a2b1adf97088143a5", "sucursal_id": "SUC-ZONA10", "cantidad_prendas": 1}', '192.168.11.62', '43d82458424ad75cc73096a68c80716a3ebf132acaa529641efb572e8f067781', 'e3b8a4b514c0601761575226089beb13b9f165cc19d257b426c369ba19d21ecb');
INSERT INTO auditoria_core.logs_inmutables VALUES (7, '2026-09-17 01:54:02.414645+00', 'worker_despacho_auto', 'DESPACHO_CREADO_BODEGA', 'bodega_wms.ordenes_despacho', '{"items": [{"sku": "CYS-OXF-BLA-M", "cantidad": 2}], "cliente": "Prueba Movil Flag ETL", "orden_bodega_id": 3, "pedido_buffer_id": "6aab483a2b1adf97088143a5"}', '127.0.0.1', 'e3b8a4b514c0601761575226089beb13b9f165cc19d257b426c369ba19d21ecb', '3560745393db79eb9f374b6c73d3980076ff2f137d8ce05a5719b60aa7af55ed');
INSERT INTO auditoria_core.logs_inmutables VALUES (8, '2026-09-17 03:06:30.04972+00', 'Carlos Repartidor Express', 'CAMBIO_ESTADO_LOGISTICA', 'bodega_wms.ordenes_despacho', '{"operador": "Carlos Repartidor Express", "orden_id": 3, "codigo_estado": 2, "estado_nombre": "Recolectado"}', '192.168.11.62', '3560745393db79eb9f374b6c73d3980076ff2f137d8ce05a5719b60aa7af55ed', 'f2ef045e27e8d8838209e70329f2f04544474738a2547748f253cf19b58eb921');
INSERT INTO auditoria_core.logs_inmutables VALUES (9, '2026-09-17 03:06:37.152722+00', 'Esteban Salic - Repartidor', 'CAMBIO_ESTADO_LOGISTICA', 'bodega_wms.ordenes_despacho', '{"operador": "Esteban Salic - Repartidor", "orden_id": 3, "codigo_estado": 4, "estado_nombre": "En ruta"}', '192.168.11.62', 'f2ef045e27e8d8838209e70329f2f04544474738a2547748f253cf19b58eb921', 'a45c48215b220f4f085c216052984285eebf01a429cecb28e67fd27a5fbdfd14');
INSERT INTO auditoria_core.logs_inmutables VALUES (10, '2026-09-17 03:10:08.594681+00', 'Esteban Salic - Repartidor', 'CAMBIO_ESTADO_LOGISTICA', 'bodega_wms.ordenes_despacho', '{"operador": "Esteban Salic - Repartidor", "orden_id": 3, "codigo_estado": 2, "estado_nombre": "Recolectado"}', '192.168.11.62', 'a45c48215b220f4f085c216052984285eebf01a429cecb28e67fd27a5fbdfd14', 'f6ea5200283434e5bd82e118c9f50f816203558ba01eb8b1d398007bc9d96999');
INSERT INTO auditoria_core.logs_inmutables VALUES (11, '2026-09-17 03:10:10.477742+00', 'Esteban Salic - Repartidor', 'CAMBIO_ESTADO_LOGISTICA', 'bodega_wms.ordenes_despacho', '{"operador": "Esteban Salic - Repartidor", "orden_id": 3, "codigo_estado": 5, "estado_nombre": "Entregado"}', '192.168.11.62', 'f6ea5200283434e5bd82e118c9f50f816203558ba01eb8b1d398007bc9d96999', '3b389883efbda81e3c7e7d9a88434c1c50db6dc4aa934e372cbc6703c32519d6');
INSERT INTO auditoria_core.logs_inmutables VALUES (12, '2026-09-17 03:10:11.949978+00', 'Esteban Salic - Repartidor', 'CAMBIO_ESTADO_LOGISTICA', 'bodega_wms.ordenes_despacho', '{"operador": "Esteban Salic - Repartidor", "orden_id": 3, "codigo_estado": 1, "estado_nombre": "Solicitado"}', '192.168.11.62', '3b389883efbda81e3c7e7d9a88434c1c50db6dc4aa934e372cbc6703c32519d6', '5adeb23cf1bee84bd3931187ef50602c43424633d7a6c6625a0d9020cc0e9021');
INSERT INTO auditoria_core.logs_inmutables VALUES (13, '2026-09-17 03:10:42.331511+00', 'worker_despacho_auto', 'DESPACHO_CREADO_BODEGA', 'bodega_wms.ordenes_despacho', '{"items": [{"sku": "CYS-OXF-BLA-M", "cantidad": 1}], "cliente": "Corporación Hotelera Maya", "orden_bodega_id": 4, "pedido_buffer_id": "6aab5a3288992bb7e1a3657b"}', '127.0.0.1', '5adeb23cf1bee84bd3931187ef50602c43424633d7a6c6625a0d9020cc0e9021', '18077c3eee1357fa76d37b2757d00f43a74c8b8db266df7c730abb63641f18d5');
INSERT INTO auditoria_core.logs_inmutables VALUES (14, '2026-09-17 03:10:42.330865+00', 'HANDHELD-MOBILE-01', 'INGESTA_PEDIDO_BUFFER', 'mongo.pedidos_ingesta', '{"cliente": "Corporación Hotelera Maya", "flag_etl": "ETL_WMS_MASTER_SYNC", "buffer_id": "6aab5a3288992bb7e1a3657b", "sucursal_id": "BOD-CENTRAL-01", "cantidad_prendas": 1}', '192.168.11.62', '18077c3eee1357fa76d37b2757d00f43a74c8b8db266df7c730abb63641f18d5', '2fc6d3e56d473712dffad0b2a846cf8c4dd55ed8b5c57244e1f63eb444f699bd');
INSERT INTO auditoria_core.logs_inmutables VALUES (15, '2026-09-17 03:18:30.000099+00', 'HANDHELD-MOBILE-01', 'INGESTA_PEDIDO_BUFFER', 'mongo.pedidos_ingesta', '{"cliente": "Corporación Hotelera Maya", "flag_etl": "ETL_WMS_MASTER_SYNC", "buffer_id": "6aab5c0588992bb7e1a3657c", "sucursal_id": "BOD-CENTRAL-01", "cantidad_prendas": 1}', '192.168.11.62', '2fc6d3e56d473712dffad0b2a846cf8c4dd55ed8b5c57244e1f63eb444f699bd', 'e21e96044629585643c5fb6e4c0856935358b6ab29798f3d25677c59a131375f');
INSERT INTO auditoria_core.logs_inmutables VALUES (16, '2026-09-17 03:18:31.266739+00', 'worker_despacho_auto', 'DESPACHO_CREADO_BODEGA', 'bodega_wms.ordenes_despacho', '{"items": [{"sku": "CYS-OXF-BLA-M", "cantidad": 1}], "cliente": "Corporación Hotelera Maya", "orden_bodega_id": 5, "pedido_buffer_id": "6aab5c0588992bb7e1a3657c"}', '127.0.0.1', 'e21e96044629585643c5fb6e4c0856935358b6ab29798f3d25677c59a131375f', 'a7733238f73800ee749432b21fcfb2f88a846d96c749400a2a993e2d0a3e8b66');
INSERT INTO auditoria_core.logs_inmutables VALUES (17, '2026-09-17 03:18:53.136966+00', 'HANDHELD-MOBILE-01', 'CAMBIO_ESTADO_LOGISTICA', 'bodega_wms.ordenes_despacho', '{"operador": "HANDHELD-MOBILE-01", "orden_id": 5, "codigo_estado": 7, "estado_nombre": "Anulado"}', '192.168.11.62', 'a7733238f73800ee749432b21fcfb2f88a846d96c749400a2a993e2d0a3e8b66', 'db8792fe14fad4d54208212ca06f28fe56afce038ebf6c43419dc784bd783d99');
INSERT INTO auditoria_core.logs_inmutables VALUES (18, '2026-09-17 03:30:28.944516+00', 'Cajera Mostrador - Tienda Física [Tienda Física / Caja | Tarjeta POS | Q 350.00]', 'CAMBIO_ESTADO_LOGISTICA', 'bodega_wms.ordenes_despacho', '{"operador": "Cajera Mostrador - Tienda Física [Tienda Física / Caja | Tarjeta POS | Q 350.00]", "orden_id": 5, "codigo_estado": 25, "estado_nombre": "COD pagado"}', '192.168.11.62', 'db8792fe14fad4d54208212ca06f28fe56afce038ebf6c43419dc784bd783d99', 'e4ecb10665aa1026fb112b257d193b0b4047aedd4212be9e1d9f47951690784d');
INSERT INTO auditoria_core.logs_inmutables VALUES (19, '2026-09-17 03:33:33.840081+00', 'HANDHELD-MOBILE-01', 'INGESTA_PEDIDO_BUFFER', 'mongo.pedidos_ingesta', '{"cliente": "Corporación Hotelera Maya", "flag_etl": "ETL_WMS_MASTER_SYNC", "buffer_id": "6aab5f8d88992bb7e1a3657d", "sucursal_id": "BOD-CENTRAL-01", "cantidad_prendas": 1}', '192.168.11.62', 'e4ecb10665aa1026fb112b257d193b0b4047aedd4212be9e1d9f47951690784d', '266fa7f5bfb34ff82af746a8af73e09d3e4cae18690da898974f36ab9dc0e881');
INSERT INTO auditoria_core.logs_inmutables VALUES (20, '2026-09-17 03:33:36.043322+00', 'worker_despacho_auto', 'DESPACHO_CREADO_BODEGA', 'bodega_wms.ordenes_despacho', '{"items": [{"sku": "CYS-OXF-BLA-M", "cantidad": 1}], "cliente": "Corporación Hotelera Maya", "orden_bodega_id": 6, "pedido_buffer_id": "6aab5f8d88992bb7e1a3657d"}', '127.0.0.1', '266fa7f5bfb34ff82af746a8af73e09d3e4cae18690da898974f36ab9dc0e881', '5c97185dd84d9f3eafc688441a7ae9ca632aa8299ac31b4b0e2367fc0055ed90');
INSERT INTO auditoria_core.logs_inmutables VALUES (21, '2026-09-17 03:33:48.128545+00', 'Cajera Mostrador - Tienda Física [Tienda Física / Caja | Transferencia | Q 350.00]', 'CAMBIO_ESTADO_LOGISTICA', 'bodega_wms.ordenes_despacho', '{"operador": "Cajera Mostrador - Tienda Física [Tienda Física / Caja | Transferencia | Q 350.00]", "orden_id": 6, "codigo_estado": 25, "estado_nombre": "COD pagado"}', '192.168.11.62', '5c97185dd84d9f3eafc688441a7ae9ca632aa8299ac31b4b0e2367fc0055ed90', 'f9b1e91c54210b3e4478ac3bc11d3f511bf9bd803dadf9848f3e0addda10c64a');
INSERT INTO auditoria_core.logs_inmutables VALUES (22, '2026-09-17 03:33:53.991464+00', 'Cajera Mostrador - Tienda Física [Tienda Física / Caja | Efectivo (Cash) | Q 350.00]', 'CAMBIO_ESTADO_LOGISTICA', 'bodega_wms.ordenes_despacho', '{"operador": "Cajera Mostrador - Tienda Física [Tienda Física / Caja | Efectivo (Cash) | Q 350.00]", "orden_id": 4, "codigo_estado": 25, "estado_nombre": "COD pagado"}', '192.168.11.62', 'f9b1e91c54210b3e4478ac3bc11d3f511bf9bd803dadf9848f3e0addda10c64a', '3cd81bc4c1d4844c04da7fb1389b6f699474941a3bd86e41bb0cc312dc0aca43');
INSERT INTO auditoria_core.logs_inmutables VALUES (23, '2026-09-17 04:32:10.106801+00', 'SECURITY_GUARD', 'INTENTO_ACCESO_DENEGADO_ACL', 'bodega_wms.ordenes_despacho', '{"motivo": "Acceso Denegado por ACL (ISO 27001 Control A.9): El empleado Elías Marquirez (Jefe de Bodega Central) no tiene autorización en la sede [SUC-MIRAFLORES]", "orden_id": 1, "sucursal_id": "SUC-MIRAFLORES", "worker_code": "103", "codigo_estado": 2}', '192.168.11.62', '3cd81bc4c1d4844c04da7fb1389b6f699474941a3bd86e41bb0cc312dc0aca43', 'bfd6e4804209f264b5491319eed7e252890d96626384c01d6c7d8c6efbb03d56');
INSERT INTO auditoria_core.logs_inmutables VALUES (24, '2026-09-17 04:37:47.716665+00', 'Esteban Salic (EMP-101)', 'INGESTA_PEDIDO_BUFFER', 'mongo.pedidos_ingesta', '{"cliente": "Don Fernando Paiz", "flag_etl": "ETL_POS_Z10_INCREMENTAL", "buffer_id": "6aab6e9b712e1791ba5d5b94", "sucursal_id": "SUC-ZONA10", "worker_code": "101", "cantidad_prendas": 1}', '192.168.11.62', 'bfd6e4804209f264b5491319eed7e252890d96626384c01d6c7d8c6efbb03d56', 'af3484f463e0757f7f851f7aef55e91a4946ccf34d8cc3e4397117737cbee5e6');
INSERT INTO auditoria_core.logs_inmutables VALUES (25, '2026-09-17 04:37:47.736186+00', 'worker_despacho_auto', 'DESPACHO_CREADO_BODEGA', 'bodega_wms.ordenes_despacho', '{"items": [{"sku": "CYS-OXF-BLA-M", "cantidad": 2}], "cliente": "Don Fernando Paiz", "orden_bodega_id": 7, "pedido_buffer_id": "6aab6e9b712e1791ba5d5b94"}', '127.0.0.1', 'af3484f463e0757f7f851f7aef55e91a4946ccf34d8cc3e4397117737cbee5e6', 'c16801c6a1420aa0110e75123f5ddbc94fe7603f4912edff247a335e2356f5e1');
INSERT INTO auditoria_core.logs_inmutables VALUES (26, '2026-09-17 04:37:51.739663+00', 'Joshua Méndez (EMP-102)', 'CAMBIO_ESTADO_LOGISTICA', 'bodega_wms.ordenes_despacho', '{"operador": "Joshua Méndez (EMP-102)", "orden_id": 7, "sucursal_id": "SUC-ZONA10", "worker_code": "102", "codigo_estado": 25, "estado_nombre": "COD pagado"}', '192.168.11.62', 'c16801c6a1420aa0110e75123f5ddbc94fe7603f4912edff247a335e2356f5e1', '013e71434ce9b7f8139aef09e8210e832633ae6591cc18b8788f595180e7f3ed');
INSERT INTO auditoria_core.logs_inmutables VALUES (27, '2026-09-17 04:38:14.255696+00', 'Joshua Méndez (EMP-102)', 'CAMBIO_ESTADO_LOGISTICA', 'bodega_wms.ordenes_despacho', '{"operador": "Joshua Méndez (EMP-102)", "orden_id": 3, "sucursal_id": "BOD-CENTRAL-01", "worker_code": "102", "codigo_estado": 25, "estado_nombre": "COD pagado"}', '192.168.11.62', '013e71434ce9b7f8139aef09e8210e832633ae6591cc18b8788f595180e7f3ed', 'e24703764d83be23bd6ebc5cf2a790966397a4fc8b27500cf63753c23b4291a3');
INSERT INTO auditoria_core.logs_inmutables VALUES (28, '2026-09-17 04:38:40.808029+00', 'Joshua Méndez (EMP-102)', 'CAMBIO_ESTADO_LOGISTICA', 'bodega_wms.ordenes_despacho', '{"operador": "Joshua Méndez (EMP-102)", "orden_id": 2, "sucursal_id": "BOD-CENTRAL-01", "worker_code": "102", "codigo_estado": 25, "estado_nombre": "COD pagado"}', '192.168.11.62', 'e24703764d83be23bd6ebc5cf2a790966397a4fc8b27500cf63753c23b4291a3', 'd5140bd8f2729424d9b260b8c26dc0f526b90f7fc8a2054065235ec9d36d4207');
INSERT INTO auditoria_core.logs_inmutables VALUES (29, '2026-09-17 04:51:42.986575+00', 'Joshua Méndez', 'SOLICITUD_2FA_TELEGRAM', 'auth.two_factor', '{"operador": "Joshua Méndez", "worker_code": "8840219", "telegram_sent": false}', '192.168.11.62', 'd5140bd8f2729424d9b260b8c26dc0f526b90f7fc8a2054065235ec9d36d4207', '89109cf63749896bc7912694264698486bf1fb45a71a98c7fa48cfb5c72af6d2');
INSERT INTO auditoria_core.logs_inmutables VALUES (30, '2026-09-17 04:51:43.003386+00', 'Joshua Méndez', 'FALLO_2FA_TELEGRAM', 'auth.two_factor', '{"intento_otp": "000000", "worker_code": "8840219"}', '192.168.11.62', '89109cf63749896bc7912694264698486bf1fb45a71a98c7fa48cfb5c72af6d2', '1d7b4ba0420789f1a1bf22239c9e5eb4333580cb285ba2ec2d6176787c6217f9');
INSERT INTO auditoria_core.logs_inmutables VALUES (31, '2026-09-17 04:51:43.013631+00', 'Joshua Méndez', 'AUTENTICACION_2FA_TELEGRAM_EXITOSA', 'auth.two_factor', '{"metodo": "TELEGRAM_OTP_6_DIGITS", "operador": "Joshua Méndez", "worker_code": "8840219"}', '192.168.11.62', '1d7b4ba0420789f1a1bf22239c9e5eb4333580cb285ba2ec2d6176787c6217f9', '85e6233f45d45f943260e68963f2740bda677b9a24696101ad2804dcf33ae2d9');
INSERT INTO auditoria_core.logs_inmutables VALUES (32, '2026-09-17 04:51:43.023221+00', 'Esteban Salic', 'AUTENTICACION_2FA_TELEGRAM_EXITOSA', 'auth.two_factor', '{"metodo": "TELEGRAM_OTP_6_DIGITS", "operador": "Esteban Salic", "worker_code": "99283104"}', '192.168.11.62', '85e6233f45d45f943260e68963f2740bda677b9a24696101ad2804dcf33ae2d9', 'd774aec7dcce5ef61798a0c388fab4f86d77c6922facfad78e42137023080e29');
INSERT INTO auditoria_core.logs_inmutables VALUES (33, '2026-09-17 04:51:50.332605+00', 'Joshua Méndez', 'SOLICITUD_2FA_TELEGRAM', 'auth.two_factor', '{"operador": "Joshua Méndez", "worker_code": "8840219", "telegram_sent": false}', '192.168.11.62', 'd774aec7dcce5ef61798a0c388fab4f86d77c6922facfad78e42137023080e29', '7549156f646fe3ddd3991ef760a93c1527e70afc6050c1c4de355a80b2491b1f');
INSERT INTO auditoria_core.logs_inmutables VALUES (34, '2026-09-17 04:51:50.354823+00', 'Joshua Méndez', 'FALLO_2FA_TELEGRAM', 'auth.two_factor', '{"intento_otp": "000000", "worker_code": "8840219"}', '192.168.11.62', '7549156f646fe3ddd3991ef760a93c1527e70afc6050c1c4de355a80b2491b1f', 'af804297702e6e83a1e8e09d12aaecfbfd312156bc8caf98344234bacc11ca85');
INSERT INTO auditoria_core.logs_inmutables VALUES (35, '2026-09-17 04:51:50.360909+00', 'Joshua Méndez', 'AUTENTICACION_2FA_TELEGRAM_EXITOSA', 'auth.two_factor', '{"metodo": "TELEGRAM_OTP_6_DIGITS", "operador": "Joshua Méndez", "worker_code": "8840219"}', '192.168.11.62', 'af804297702e6e83a1e8e09d12aaecfbfd312156bc8caf98344234bacc11ca85', '7a857bac741041320dfa68affba41ea4910ca80b57852e3021e20b0a63540eb0');
INSERT INTO auditoria_core.logs_inmutables VALUES (36, '2026-09-17 04:51:50.368032+00', 'Esteban Salic', 'AUTENTICACION_2FA_TELEGRAM_EXITOSA', 'auth.two_factor', '{"metodo": "TELEGRAM_OTP_6_DIGITS", "operador": "Esteban Salic", "worker_code": "99283104"}', '192.168.11.62', '7a857bac741041320dfa68affba41ea4910ca80b57852e3021e20b0a63540eb0', 'a9d45847f15867a78144b0ef1ae019b94bee75cc388d310c1ec906bc7d71c8b8');
INSERT INTO auditoria_core.logs_inmutables VALUES (37, '2026-09-17 04:51:54.104214+00', 'SECURITY_GUARD', 'INTENTO_ACCESO_DENEGADO_ACL', 'bodega_wms.ordenes_despacho', '{"motivo": "Acceso Denegado por ACL (ISO 27001 Control A.9): El empleado Elías Marquirez (Jefe de Bodega Central) no tiene autorización en la sede [SUC-MIRAFLORES]", "orden_id": 1, "sucursal_id": "SUC-MIRAFLORES", "worker_code": "103", "codigo_estado": 2}', '192.168.11.62', 'a9d45847f15867a78144b0ef1ae019b94bee75cc388d310c1ec906bc7d71c8b8', '1462677a2408e618ebd4cba180d0038397a60397b87c3a2b0d2da80761acb4c4');
INSERT INTO auditoria_core.logs_inmutables VALUES (38, '2026-09-17 04:52:37.749884+00', 'Esteban Salic', 'SOLICITUD_2FA_TELEGRAM', 'auth.two_factor', '{"operador": "Esteban Salic", "worker_code": "101", "telegram_sent": false}', '192.168.11.62', '1462677a2408e618ebd4cba180d0038397a60397b87c3a2b0d2da80761acb4c4', 'd5b1e4d0b3e3803b5d40bf5048138aabe52629eb7033eb8458be8f2cef226d4d');
INSERT INTO auditoria_core.logs_inmutables VALUES (39, '2026-09-17 04:52:44.039952+00', 'Esteban Salic', 'AUTENTICACION_2FA_TELEGRAM_EXITOSA', 'auth.two_factor', '{"metodo": "TELEGRAM_OTP_6_DIGITS", "operador": "Esteban Salic", "worker_code": "101"}', '192.168.11.62', 'd5b1e4d0b3e3803b5d40bf5048138aabe52629eb7033eb8458be8f2cef226d4d', 'ad24045fb27d6e07576631b6899d8152b6245ce7f630eefb3d70dd50ebef9a63');
INSERT INTO auditoria_core.logs_inmutables VALUES (40, '2026-09-17 04:59:32.398075+00', 'Joshua Méndez', 'SOLICITUD_2FA_TELEGRAM', 'auth.two_factor', '{"operador": "Joshua Méndez", "worker_code": "8840219", "telegram_sent": true}', '192.168.11.62', 'ad24045fb27d6e07576631b6899d8152b6245ce7f630eefb3d70dd50ebef9a63', '09dd03b6b3caa015dae71947240fb542db95f9cb66f8380a388d7ebde13909bc');
INSERT INTO auditoria_core.logs_inmutables VALUES (41, '2026-09-17 05:00:06.774067+00', 'Esteban Salic', 'SOLICITUD_2FA_TELEGRAM', 'auth.two_factor', '{"operador": "Esteban Salic", "worker_code": "101", "telegram_sent": false}', '192.168.11.62', '09dd03b6b3caa015dae71947240fb542db95f9cb66f8380a388d7ebde13909bc', '50033aba89f55d359320c087acbb86f9baca605ba10a7869c9fb6b7c8be83104');
INSERT INTO auditoria_core.logs_inmutables VALUES (42, '2026-09-17 05:00:37.469106+00', 'Esteban Salic', 'SOLICITUD_2FA_TELEGRAM', 'auth.two_factor', '{"operador": "Esteban Salic", "worker_code": "101", "telegram_sent": true}', '192.168.11.62', '50033aba89f55d359320c087acbb86f9baca605ba10a7869c9fb6b7c8be83104', '56edc75362e66fc08389292b80ee409a5bd8168df75fce46dd7e37b896770cef');
INSERT INTO auditoria_core.logs_inmutables VALUES (43, '2026-09-17 05:00:52.934902+00', 'Esteban Salic', 'AUTENTICACION_2FA_TELEGRAM_EXITOSA', 'auth.two_factor', '{"metodo": "TELEGRAM_OTP_6_DIGITS", "operador": "Esteban Salic", "worker_code": "101"}', '192.168.11.62', '56edc75362e66fc08389292b80ee409a5bd8168df75fce46dd7e37b896770cef', '6a8eb7666b0602e9489b241fb8e9b0f40b3f6e2bd6736dac5f873e7865add5c2');
INSERT INTO auditoria_core.logs_inmutables VALUES (44, '2026-09-17 05:02:19.079536+00', 'Joshua Méndez', 'SOLICITUD_2FA_TELEGRAM', 'auth.two_factor', '{"operador": "Joshua Méndez", "worker_code": "8840219", "telegram_sent": true}', '192.168.11.62', '6a8eb7666b0602e9489b241fb8e9b0f40b3f6e2bd6736dac5f873e7865add5c2', 'f5298b5fabd7f41612ac6088979fb24ebedd68ff804a1d47248c6bab8c5a09a4');
INSERT INTO auditoria_core.logs_inmutables VALUES (45, '2026-09-17 05:02:33.575133+00', 'Esteban Salic', 'SOLICITUD_2FA_TELEGRAM', 'auth.two_factor', '{"operador": "Esteban Salic", "worker_code": "101", "telegram_sent": true}', '192.168.11.62', 'f5298b5fabd7f41612ac6088979fb24ebedd68ff804a1d47248c6bab8c5a09a4', '5831a86b8da28d2f24764d40244fbbc3f8cb1ef735c8137a61ea77764929e9e2');
INSERT INTO auditoria_core.logs_inmutables VALUES (46, '2026-09-17 05:02:44.719511+00', 'Esteban Salic', 'AUTENTICACION_2FA_TELEGRAM_EXITOSA', 'auth.two_factor', '{"metodo": "TELEGRAM_OTP_6_DIGITS", "operador": "Esteban Salic", "worker_code": "101"}', '192.168.11.62', '5831a86b8da28d2f24764d40244fbbc3f8cb1ef735c8137a61ea77764929e9e2', '1b4830454f273c781e7f5445f3d7f4a1c3748c9da80551229d2b69b0528ba325');
INSERT INTO auditoria_core.logs_inmutables VALUES (47, '2026-09-17 06:26:44.905902+00', 'Joshua Méndez (Auditor)', 'IMPORTACION_CATALOGO_CROWN_JEWELS', 'mercancia_vault.camisas_catalogo', '{"lote": "COLECCION_2026_COMPLETA", "telas": 10, "proveedores": 8, "skus_nuevos": 20}', '192.168.11.64', '1b4830454f273c781e7f5445f3d7f4a1c3748c9da80551229d2b69b0528ba325', '91321d6c77f77083a6f8020a155cbe2fe3bccf1c9e1af968952e333e5a1784bb');
INSERT INTO auditoria_core.logs_inmutables VALUES (48, '2026-09-17 06:26:44.909919+00', 'Elías Marquirez (Jefe Bodega)', 'REABASTECIMIENTO_INVENTARIO_GENERAL', 'bodega_wms.stock_inventario', '{"prendas_totales": 1820, "pasillos_abastecidos": ["EST-A", "EST-B", "EST-C", "EST-D"]}', '192.168.11.64', '91321d6c77f77083a6f8020a155cbe2fe3bccf1c9e1af968952e333e5a1784bb', '3ed942ad067397ec8a507b87730c25292de6527f17a88e427cccf8fa92d4f1bf');
INSERT INTO auditoria_core.logs_inmutables VALUES (49, '2026-09-17 06:26:44.910141+00', 'Carlos Repartidor', 'LIQUIDACION_RUTAS_COD', 'bodega_wms.ordenes_despacho', '{"zona": "Metropolitana Z10-Z14-Z16", "estado_final": "CONCILIADO", "rutas_liquidadas": 12}', '192.168.11.64', '3ed942ad067397ec8a507b87730c25292de6527f17a88e427cccf8fa92d4f1bf', '094346dc4f7a89e010e65a055cd8fdab8e445422a80c72e4e6eb58cb79fc38c5');
INSERT INTO auditoria_core.logs_inmutables VALUES (50, '2026-09-24 05:58:51.293476+00', 'Esteban Salic', 'SOLICITUD_2FA_TELEGRAM', 'auth.two_factor', '{"operador": "Esteban Salic", "worker_code": "101", "telegram_sent": true}', '186.151.64.227', '094346dc4f7a89e010e65a055cd8fdab8e445422a80c72e4e6eb58cb79fc38c5', '27c2a035fe166922900cc856afd30a39ddf6e77412d71e824cb0a05d672c5bc6');
INSERT INTO auditoria_core.logs_inmutables VALUES (51, '2026-09-24 05:59:05.531796+00', 'Esteban Salic', 'AUTENTICACION_2FA_TELEGRAM_EXITOSA', 'auth.two_factor', '{"metodo": "TELEGRAM_OTP_6_DIGITS", "operador": "Esteban Salic", "worker_code": "101"}', '186.151.64.227', '27c2a035fe166922900cc856afd30a39ddf6e77412d71e824cb0a05d672c5bc6', '5ccae81e40a47764d9a0f6a9f1858685c4ba85cab96ffa9102bcc5dce2ff8452');
INSERT INTO auditoria_core.logs_inmutables VALUES (52, '2026-09-24 06:00:25.023117+00', 'Esteban Salic', 'SOLICITUD_2FA_TELEGRAM', 'auth.two_factor', '{"operador": "Esteban Salic", "worker_code": "101", "telegram_sent": true}', '186.151.64.227', '5ccae81e40a47764d9a0f6a9f1858685c4ba85cab96ffa9102bcc5dce2ff8452', '8f8bdf25b548de09e892e1159076352162cefb8987e62607cea0f0dbbc9c1306');
INSERT INTO auditoria_core.logs_inmutables VALUES (53, '2026-09-24 06:00:30.899596+00', 'Esteban Salic', 'AUTENTICACION_2FA_TELEGRAM_EXITOSA', 'auth.two_factor', '{"metodo": "TELEGRAM_OTP_6_DIGITS", "operador": "Esteban Salic", "worker_code": "101"}', '186.151.64.227', '8f8bdf25b548de09e892e1159076352162cefb8987e62607cea0f0dbbc9c1306', '51478eed18475164b314f0429255ccac25680ebdb5e46da82515ca1d6f371736');
INSERT INTO auditoria_core.logs_inmutables VALUES (54, '2026-09-24 06:07:29.060034+00', 'Esteban Salic', 'SOLICITUD_2FA_TELEGRAM', 'auth.two_factor', '{"operador": "Esteban Salic", "worker_code": "101", "telegram_sent": true}', '186.151.64.227', '51478eed18475164b314f0429255ccac25680ebdb5e46da82515ca1d6f371736', '14dc90232f9ed0903efcfe58b9b994bcc0cdaf6a9610164a410c19a2282b44fd');
INSERT INTO auditoria_core.logs_inmutables VALUES (55, '2026-09-24 06:07:44.193721+00', 'Esteban Salic', 'AUTENTICACION_2FA_TELEGRAM_EXITOSA', 'auth.two_factor', '{"metodo": "TELEGRAM_OTP_6_DIGITS", "operador": "Esteban Salic", "worker_code": "101"}', '186.151.64.227', '14dc90232f9ed0903efcfe58b9b994bcc0cdaf6a9610164a410c19a2282b44fd', '76b5e3ef31d9e9d44372e44e8496c4c465fed99d55e17226da12c35885aa48b3');
INSERT INTO auditoria_core.logs_inmutables VALUES (56, '2026-09-24 06:34:30.716964+00', 'Esteban Salic', 'SOLICITUD_2FA_TELEGRAM', 'auth.two_factor', '{"operador": "Esteban Salic", "worker_code": "101", "telegram_sent": true}', '186.151.64.227', '76b5e3ef31d9e9d44372e44e8496c4c465fed99d55e17226da12c35885aa48b3', 'e842793bb01181479dfe1e575d5898b533b693ba174ee7050479b867cb48506c');
INSERT INTO auditoria_core.logs_inmutables VALUES (57, '2026-09-24 06:34:40.667057+00', 'Esteban Salic', 'AUTENTICACION_2FA_TELEGRAM_EXITOSA', 'auth.two_factor', '{"metodo": "TELEGRAM_OTP_6_DIGITS", "operador": "Esteban Salic", "worker_code": "101"}', '186.151.64.227', 'e842793bb01181479dfe1e575d5898b533b693ba174ee7050479b867cb48506c', 'f73c77ea5daee19d3a6c38db39693f0e6467b620fb2a6bb92b5b00c4e265649a');
INSERT INTO auditoria_core.logs_inmutables VALUES (58, '2026-09-26 05:56:13.938981+00', 'Esteban Salic', 'SOLICITUD_2FA_TELEGRAM', 'auth.two_factor', '{"operador": "Esteban Salic", "worker_code": "101", "telegram_sent": true}', '170.150.31.54', 'f73c77ea5daee19d3a6c38db39693f0e6467b620fb2a6bb92b5b00c4e265649a', 'c776e03c1da22c3b630cb86b466f8f90443ebb97207a1f0acedf617f070099de');
INSERT INTO auditoria_core.logs_inmutables VALUES (59, '2026-09-26 16:02:37.044876+00', 'Esteban Salic', 'SOLICITUD_2FA_TELEGRAM', 'auth.two_factor', '{"operador": "Esteban Salic", "worker_code": "101", "telegram_sent": true}', '2803:c800:40cd:99ca:1:0:5a78:6a8a', 'c776e03c1da22c3b630cb86b466f8f90443ebb97207a1f0acedf617f070099de', '892d37bf9bfc7d2efbe1bc1fb6ca063af05ed8e44c0b0ba4d9c038cc1a041c5d');
INSERT INTO auditoria_core.logs_inmutables VALUES (60, '2026-09-26 16:03:05.973549+00', 'Esteban Salic', 'AUTENTICACION_2FA_TELEGRAM_EXITOSA', 'auth.two_factor', '{"metodo": "TELEGRAM_OTP_6_DIGITS", "operador": "Esteban Salic", "worker_code": "101"}', '2803:c800:40cd:99ca:1:0:5a78:6a8a', '892d37bf9bfc7d2efbe1bc1fb6ca063af05ed8e44c0b0ba4d9c038cc1a041c5d', '1fdb1e792aa0d5306e4c84d8e6feb98148cc04bc58719e937b46fc72ea6ed2e0');
INSERT INTO auditoria_core.logs_inmutables VALUES (61, '2026-09-26 16:07:22.600432+00', 'Esteban Salic', 'SOLICITUD_2FA_TELEGRAM', 'auth.two_factor', '{"operador": "Esteban Salic", "worker_code": "101", "telegram_sent": true}', '2803:c800:40cd:99ca:1:0:5a78:6a8a', '1fdb1e792aa0d5306e4c84d8e6feb98148cc04bc58719e937b46fc72ea6ed2e0', '630b46645b8e21439859c167d4282833bd1af967079fd3d60f13679d2ad82ef3');
INSERT INTO auditoria_core.logs_inmutables VALUES (62, '2026-09-26 16:07:40.162174+00', 'Esteban Salic', 'FALLO_2FA_TELEGRAM', 'auth.two_factor', '{"intento_otp": "253542", "worker_code": "101"}', '2803:c800:40cd:99ca:1:0:5a78:6a8a', '630b46645b8e21439859c167d4282833bd1af967079fd3d60f13679d2ad82ef3', 'aa927959a625b977c8ded8fce010cca3a376932d10394f1b0878a4ebff30a512');
INSERT INTO auditoria_core.logs_inmutables VALUES (63, '2026-09-26 16:07:47.441409+00', 'Esteban Salic', 'AUTENTICACION_2FA_TELEGRAM_EXITOSA', 'auth.two_factor', '{"metodo": "TELEGRAM_OTP_6_DIGITS", "operador": "Esteban Salic", "worker_code": "101"}', '2803:c800:40cd:99ca:1:0:5a78:6a8a', 'aa927959a625b977c8ded8fce010cca3a376932d10394f1b0878a4ebff30a512', '6ca0bf90445906a5b33632ba732c4999724dd61130297dd609ded02ca264ce91');
INSERT INTO auditoria_core.logs_inmutables VALUES (64, '2026-09-26 23:53:29.929657+00', 'Esteban Salic', 'SOLICITUD_2FA_TELEGRAM', 'auth.two_factor', '{"operador": "Esteban Salic", "worker_code": "101", "telegram_sent": true}', '2803:c800:40cd:99ca:94b0:3da2:c602:d402', '6ca0bf90445906a5b33632ba732c4999724dd61130297dd609ded02ca264ce91', 'e4eecfd73308826fa0c55a3eef00553044ef970ff595ceda73c75ad6e1530a1c');
INSERT INTO auditoria_core.logs_inmutables VALUES (65, '2026-09-26 23:53:57.825408+00', 'Esteban Salic', 'AUTENTICACION_2FA_TELEGRAM_EXITOSA', 'auth.two_factor', '{"metodo": "TELEGRAM_OTP_6_DIGITS", "operador": "Esteban Salic", "worker_code": "101"}', '2803:c800:40cd:99ca:94b0:3da2:c602:d402', 'e4eecfd73308826fa0c55a3eef00553044ef970ff595ceda73c75ad6e1530a1c', '215746f2d5dc9d92061ab4efea62f773070a4b02ecb63f467580e2dd540603b2');
INSERT INTO auditoria_core.logs_inmutables VALUES (66, '2026-10-03 23:29:54.25513+00', 'Esteban Salic', 'SOLICITUD_2FA_TELEGRAM', 'auth.two_factor', '{"operador": "Esteban Salic", "worker_code": "101", "telegram_sent": true}', '2800:98:1080:ec9d:b5a6:867e:bdb6:6f74', '215746f2d5dc9d92061ab4efea62f773070a4b02ecb63f467580e2dd540603b2', '487afb6bb78fa84dae38629f18fa215f4b89a655160830d60b14ddaa8b9c7ca0');
INSERT INTO auditoria_core.logs_inmutables VALUES (67, '2026-10-03 23:30:14.382894+00', 'Esteban Salic', 'AUTENTICACION_2FA_TELEGRAM_EXITOSA', 'auth.two_factor', '{"metodo": "TELEGRAM_OTP_6_DIGITS", "operador": "Esteban Salic", "worker_code": "101"}', '2800:98:1080:ec9d:b5a6:867e:bdb6:6f74', '487afb6bb78fa84dae38629f18fa215f4b89a655160830d60b14ddaa8b9c7ca0', '82110ac6dfdb74668fe2d4430f4d23d8f07c6ecc2e17da6bd4bd249ecff78a0c');
INSERT INTO auditoria_core.logs_inmutables VALUES (68, '2026-10-08 17:53:52.010254+00', 'Joshua Méndez', 'SOLICITUD_2FA_TELEGRAM', 'auth.two_factor', '{"operador": "Joshua Méndez", "worker_code": "8840219", "telegram_sent": true}', '181.209.195.131', '82110ac6dfdb74668fe2d4430f4d23d8f07c6ecc2e17da6bd4bd249ecff78a0c', '7177cb70f7ca52d2c13f74039141133e5d974d96b4ea2f2ca2fcb3149606af65');
INSERT INTO auditoria_core.logs_inmutables VALUES (69, '2026-10-08 17:54:07.373365+00', 'Joshua Méndez', 'AUTENTICACION_2FA_TELEGRAM_EXITOSA', 'auth.two_factor', '{"metodo": "TELEGRAM_OTP_6_DIGITS", "operador": "Joshua Méndez", "worker_code": "8840219"}', '181.209.195.131', '7177cb70f7ca52d2c13f74039141133e5d974d96b4ea2f2ca2fcb3149606af65', 'c97a9c95f04ac2d203d5d950cbe4caeeedad2fee5f52576b821fb122a9148c13');


--
-- Data for Name: estanterias; Type: TABLE DATA; Schema: bodega_wms; Owner: postgres_admin
--

INSERT INTO bodega_wms.estanterias VALUES (1, 'EST-A-01', 'Zona A - Camisas Formales', 500);
INSERT INTO bodega_wms.estanterias VALUES (2, 'EST-A-02', 'Zona A - Camisas Formales', 500);
INSERT INTO bodega_wms.estanterias VALUES (3, 'EST-B-01', 'Zona B - Guayaberas y Lino', 300);
INSERT INTO bodega_wms.estanterias VALUES (11, 'EST-B-03', 'Zona B - Guayaberas y Lino Belga', 350);
INSERT INTO bodega_wms.estanterias VALUES (12, 'EST-C-01', 'Zona C - Bóveda Edición Limitada Giza', 200);
INSERT INTO bodega_wms.estanterias VALUES (13, 'EST-C-02', 'Zona C - Twill y Seda Diplomática', 250);
INSERT INTO bodega_wms.estanterias VALUES (14, 'EST-D-01', 'Zona D - Despacho Express y Cross-Docking', 600);
INSERT INTO bodega_wms.estanterias VALUES (15, 'EST-A-03', 'Zona A - Camisas Formales Oxford', 500);
INSERT INTO bodega_wms.estanterias VALUES (16, 'EST-A-04', 'Zona A - Camisas Formales Oxford', 500);
INSERT INTO bodega_wms.estanterias VALUES (17, 'EST-B-02', 'Zona B - Guayaberas y Lino Belga', 350);


--
-- Data for Name: ordenes_despacho; Type: TABLE DATA; Schema: bodega_wms; Owner: postgres_admin
--

INSERT INTO bodega_wms.ordenes_despacho VALUES (1, 'c4934e52-408e-4b86-ac50-f9f0c9279980', '6aab2082ed52c557164973e2', 'Corporacion Hotelera Maya', 'Avenida Reforma 12-45 Zona 10', 'PENDIENTE_PICKING', NULL, '2026-09-16 23:04:36.759078+00', NULL, 1, 'Solicitado');
INSERT INTO bodega_wms.ordenes_despacho VALUES (5, 'cf32f617-cbc1-4aef-bd52-676da802606e', '6aab5c0588992bb7e1a3657c', 'Corporación Hotelera Maya', 'Avenida Reforma 12-45 Zona 10', 'COD pagado', 'Cajera Mostrador - Tienda Física [Tienda Física / Caja | Tarjeta POS | Q 350.00]', '2026-09-17 03:18:31.25509+00', NULL, 25, 'COD pagado');
INSERT INTO bodega_wms.ordenes_despacho VALUES (6, '02b208a0-04c7-4d1c-936f-812a9509c75d', '6aab5f8d88992bb7e1a3657d', 'Corporación Hotelera Maya', 'Avenida Reforma 12-45 Zona 10', 'COD pagado', 'Cajera Mostrador - Tienda Física [Tienda Física / Caja | Transferencia | Q 350.00]', '2026-09-17 03:33:36.032445+00', NULL, 25, 'COD pagado');
INSERT INTO bodega_wms.ordenes_despacho VALUES (4, 'f5879a29-6215-44c9-aa4a-5db295733aa7', '6aab5a3288992bb7e1a3657b', 'Corporación Hotelera Maya', 'Avenida Reforma 12-45 Zona 10', 'COD pagado', 'Cajera Mostrador - Tienda Física [Tienda Física / Caja | Efectivo (Cash) | Q 350.00]', '2026-09-17 03:10:42.315289+00', NULL, 25, 'COD pagado');
INSERT INTO bodega_wms.ordenes_despacho VALUES (7, 'f5d4b817-595a-45dc-a1ee-c9399176a273', '6aab6e9b712e1791ba5d5b94', 'Don Fernando Paiz', 'Boulevard Los Próceres 15-40 Zona 10', 'COD pagado', 'Joshua Méndez (EMP-102)', '2026-09-17 04:37:47.724427+00', NULL, 25, 'COD pagado');
INSERT INTO bodega_wms.ordenes_despacho VALUES (3, '969c7d95-5bee-427a-9dbd-39c826ee3240', '6aab483a2b1adf97088143a5', 'Prueba Movil Flag ETL', '6ta Avenida Zona 10', 'COD pagado', 'Joshua Méndez (EMP-102)', '2026-09-17 01:54:02.398775+00', NULL, 25, 'COD pagado');
INSERT INTO bodega_wms.ordenes_despacho VALUES (2, '6ad2dca4-797e-4a7a-8061-4ef253a90f87', '6aab3ccab6a95af42dbcc5c7', 'Corporación Textil del Sur', 'Calzada Roosevelt 14-80 Zona 11', 'COD pagado', 'Joshua Méndez (EMP-102)', '2026-09-17 01:05:16.147441+00', NULL, 25, 'COD pagado');
INSERT INTO bodega_wms.ordenes_despacho VALUES (8, '18404c9e-4867-4f9d-842c-fa75bab458f2', '6aab700688992bb7e1a36585', 'Embajada de la República de Francia', '5ta Avenida 8-59 Zona 14', 'Solicitado', 'Joshua Méndez (EMP-102)', '2026-09-17 04:26:44.193652+00', NULL, 1, 'Solicitado');
INSERT INTO bodega_wms.ordenes_despacho VALUES (9, '76d9bf3d-e729-44e4-b4be-6b48f06d172d', '6aab701188992bb7e1a36590', 'Universidad Mariano Gálvez - Decanatura', '3a Avenida 9-00 Zona 2, Campus Central', 'Entregado', 'Carlos Repartidor (EMP-201)', '2026-09-16 00:26:44.193652+00', NULL, 5, 'Entregado');
INSERT INTO bodega_wms.ordenes_despacho VALUES (10, 'c1ef70f9-4d51-497d-a1e2-e74625c5e480', '6aab700588992bb7e1a36584', 'Banco Industrial - Banca Privada', 'Vía 5 5-34 Zona 4, Torre 1', 'Recolectado', 'Elías Marquirez (EMP-103)', '2026-09-17 01:26:44.193652+00', NULL, 2, 'Recolectado');
INSERT INTO bodega_wms.ordenes_despacho VALUES (11, '9d744b1f-cbf9-4552-a0fb-c392fa6aa2cf', '6aab701288992bb7e1a36591', 'Lic. Rodrigo Castillo (Bespoke)', 'Condominio La Cañada, Zona 14', 'COD pagado', 'Joshua Méndez (EMP-102)', '2026-09-17 00:26:44.193652+00', NULL, 25, 'COD pagado');
INSERT INTO bodega_wms.ordenes_despacho VALUES (12, '4450bbac-0e03-4a27-af03-086d059638a6', '6aab700888992bb7e1a36587', 'Consorcio Textil San Francisco', 'Calzada Roosevelt 22-43 Zona 11', 'Devuelto', 'Carlos Repartidor (EMP-201)', '2026-09-15 18:26:44.193652+00', NULL, 14, 'Devuelto');
INSERT INTO bodega_wms.ordenes_despacho VALUES (13, 'aa1e5740-1133-4faf-b034-c27932cadfb9', '6aab701088992bb7e1a36589', 'Grupo Solid Guatemala', 'Kilómetro 14.5 Carretera a El Salvador', 'COD pagado', 'Joshua Méndez (EMP-102)', '2026-09-16 12:26:44.193652+00', NULL, 25, 'COD pagado');
INSERT INTO bodega_wms.ordenes_despacho VALUES (14, '69269ad9-5fd8-429e-9f66-25b19d238aa0', '6aab700988992bb7e1a36588', 'Despacho Contable Alvarado & Co.', 'Avenida Las Américas 18-20 Zona 13', 'Anulado', 'Esteban Salic (EMP-101)', '2026-09-15 04:26:44.193652+00', NULL, 7, 'Anulado');
INSERT INTO bodega_wms.ordenes_despacho VALUES (15, '320534a9-cff5-4953-a059-16d8e8ff8fc3', '6aab700188992bb7e1a36580', 'Bufete Jurídico Méndez & Asociados', 'Diagonal 6 10-01 Zona 10, Edificio Las Margaritas', 'Entregado', 'Carlos Repartidor (EMP-201)', '2026-09-15 06:26:44.193652+00', NULL, 5, 'Entregado');
INSERT INTO bodega_wms.ordenes_despacho VALUES (16, '679dcaa6-9559-4f97-9d59-4f8dfe2df20f', '6aab700488992bb7e1a36583', 'Hotel Casa Santo Domingo', '3a Calle Oriente No. 28, Antigua Guatemala', 'Entregado en Express Center', 'Esteban Salic (EMP-101)', '2026-09-16 06:26:44.193652+00', NULL, 22, 'Entregado en Express Center');
INSERT INTO bodega_wms.ordenes_despacho VALUES (17, '832b1ad0-d1b7-4872-ae71-89794efcb400', '6aab700788992bb7e1a36586', 'Boutique Sartorial Paseo Cayalá', 'Paseo Cayalá Local 104, Zona 16', 'Incidencia en ruta', 'Carlos Repartidor (EMP-201)', '2026-09-16 16:26:44.193652+00', NULL, 45, 'Incidencia en ruta');
INSERT INTO bodega_wms.ordenes_despacho VALUES (18, '94b19bf1-b169-4055-b0ed-ae4e3f1c4fc5', '6aab700388992bb7e1a36582', 'Corporación Multi Inversiones (CMI)', '7ma Avenida 5-10 Zona 9', 'Recibido en Express Center', 'Elías Marquirez (EMP-103)', '2026-09-16 22:26:44.193652+00', NULL, 21, 'Recibido en Express Center');
INSERT INTO bodega_wms.ordenes_despacho VALUES (19, '0a2ffd4b-0c8a-4db3-b339-478d32e5a932', '6aab700288992bb7e1a36581', 'Club Rotario Guatemala Sur', '12 Calle 1-25 Zona 10', 'En ruta', 'Carlos Repartidor (EMP-201)', '2026-09-16 18:26:44.193652+00', NULL, 4, 'En ruta');


--
-- Data for Name: proveedores; Type: TABLE DATA; Schema: mercancia_vault; Owner: postgres_admin
--

INSERT INTO mercancia_vault.proveedores VALUES (1, 'Textiles de Alta Gama S.A.', 'NIT-8839201-9', '+502 2333-1122', 'ventas@textilesaltagama.com', true, '2026-09-16 22:48:43.451906+00');
INSERT INTO mercancia_vault.proveedores VALUES (2, 'Importadora Hilaturas del Norte', 'NIT-1994021-3', '+502 5555-8899', 'pedidos@hilaturasnorte.com', true, '2026-09-16 22:48:43.451906+00');
INSERT INTO mercancia_vault.proveedores VALUES (9, 'Hilados Belgas de Flandes', 'NIT-6629104-5', '+32 9 224-6011', 'sales@flanderslinen.be', true, '2026-09-17 05:29:23.286572+00');
INSERT INTO mercancia_vault.proveedores VALUES (10, 'Tessitura Monti & Figli SpA', 'NIT-9918234-1', '+39 0422 8471', 'export@montifigli.it', true, '2026-09-17 05:29:23.286572+00');
INSERT INTO mercancia_vault.proveedores VALUES (11, 'Botones & Avíos de Centroamérica', 'NIT-3349102-8', '+502 2471-9900', 'ventas@botonescentroamerica.gt', true, '2026-09-17 05:29:23.286572+00');
INSERT INTO mercancia_vault.proveedores VALUES (12, 'Fabricato Textil Colombia S.A.S.', 'NIT-8909001-2', '+57 4 444-5500', 'contacto@fabricato.com.co', true, '2026-09-17 05:29:23.286572+00');
INSERT INTO mercancia_vault.proveedores VALUES (13, 'Algodonera del Sur S.A.', 'NIT-7728190-4', '+51 1 445-8822', 'corporativo@algodonerasur.pe', true, '2026-09-17 05:29:23.286572+00');
INSERT INTO mercancia_vault.proveedores VALUES (14, 'Confecciones & Hilaturas Mayas S.A.', 'NIT-5510293-7', '+502 7765-1200', 'pedidos@hilaturasmayas.com', true, '2026-09-17 05:29:23.286572+00');


--
-- Data for Name: telas; Type: TABLE DATA; Schema: mercancia_vault; Owner: postgres_admin
--

INSERT INTO mercancia_vault.telas VALUES (1, 'TELA-OXF-01', 'Algodón Oxford Pinpoint', '100% Algodón Mercerizado', 1, 4.50, 1.50);
INSERT INTO mercancia_vault.telas VALUES (2, 'TELA-LIN-02', 'Lino Belga Puro', '100% Lino Natural', 1, 9.20, 1.50);
INSERT INTO mercancia_vault.telas VALUES (3, 'TELA-POP-03', 'Popelina Pima Stretch', '97% Algodón Pima, 3% Spandex', 2, 6.00, 1.50);
INSERT INTO mercancia_vault.telas VALUES (11, 'TELA-LIN-08', 'Lino Rústico Lavado a la Piedra', '100% Lino Europeo Desfibrado', 1, 10.50, 1.55);
INSERT INTO mercancia_vault.telas VALUES (12, 'TELA-CHB-06', 'Chambray Índigo Ultra-Soft', '100% Algodón Peinado Ring-Spun', 1, 5.20, 1.50);
INSERT INTO mercancia_vault.telas VALUES (13, 'TELA-EGI-04', 'Algodón Egipcio Giza 45', '100% Algodón de Fibra Extra Larga', 1, 14.80, 1.50);
INSERT INTO mercancia_vault.telas VALUES (14, 'TELA-DOB-09', 'Dobby Micro-Texturado Royal', '100% Algodón Jacquard de Doble Retorcido', 2, 7.40, 1.50);
INSERT INTO mercancia_vault.telas VALUES (15, 'TELA-FLA-07', 'Franela Fina Cepillada', '100% Algodón Térmico Peinado', 2, 5.80, 1.50);
INSERT INTO mercancia_vault.telas VALUES (16, 'TELA-TWI-05', 'Twill Imperial Algodón-Seda', '70% Algodón Mercerizado, 30% Seda Pura', 2, 11.50, 1.45);
INSERT INTO mercancia_vault.telas VALUES (17, 'TELA-STR-10', 'Popelina Stretch Executive Dry', '93% Algodón Pima, 7% Elastano Dupont', 1, 6.90, 1.50);


--
-- Data for Name: camisas_catalogo; Type: TABLE DATA; Schema: mercancia_vault; Owner: postgres_admin
--

INSERT INTO mercancia_vault.camisas_catalogo VALUES (1, 'CYS-OXF-BLA-M', 'Camisa Oxford Slim Fit Blanca', 'Oxford Clásica', 'M', 'Blanco', 1, 14.50, 28.00, 45.00, true, '2026-09-16 22:48:43.461205+00');
INSERT INTO mercancia_vault.camisas_catalogo VALUES (2, 'CYS-OXF-BLA-L', 'Camisa Oxford Slim Fit Blanca', 'Oxford Clásica', 'L', 'Blanco', 1, 14.50, 28.00, 45.00, true, '2026-09-16 22:48:43.461205+00');
INSERT INTO mercancia_vault.camisas_catalogo VALUES (3, 'CYS-OXF-AZU-M', 'Camisa Oxford Celeste Ejecutivo', 'Oxford Clásica', 'M', 'Celeste', 1, 14.50, 28.00, 45.00, true, '2026-09-16 22:48:43.461205+00');
INSERT INTO mercancia_vault.camisas_catalogo VALUES (4, 'CYS-LIN-BEI-L', 'Guayabera Lino Presidencial', 'Guayabera Formal', 'L', 'Beige', 2, 26.00, 52.00, 85.00, true, '2026-09-16 22:48:43.461205+00');
INSERT INTO mercancia_vault.camisas_catalogo VALUES (5, 'CYS-POP-NEG-M', 'Camisa Popelina Negra Stretch', 'Ejecutiva Moderna', 'M', 'Negro', 3, 18.00, 35.00, 55.00, true, '2026-09-16 22:48:43.461205+00');
INSERT INTO mercancia_vault.camisas_catalogo VALUES (26, 'CYS-DOB-BLA-L', 'Camisa Dobby Micro-Rombo Blanco Textura', 'Presidencial Formal', 'L', 'Blanco Estructurado', 1, 21.00, 42.00, 68.00, true, '2026-09-17 05:29:23.596848+00');
INSERT INTO mercancia_vault.camisas_catalogo VALUES (27, 'CYS-EGI-BLA-M', 'Camisa Algodón Egipcio Giza Edición Limitada', 'Haute Couture', 'M', 'Blanco Nieve', 1, 38.00, 75.00, 130.00, true, '2026-09-17 05:29:23.596848+00');
INSERT INTO mercancia_vault.camisas_catalogo VALUES (28, 'CYS-OXF-ROS-M', 'Camisa Oxford Rosa Salmón Ejecutivo', 'Oxford Clásica', 'M', 'Rosa Salmón', 1, 14.50, 28.00, 45.00, true, '2026-09-17 05:29:23.596848+00');
INSERT INTO mercancia_vault.camisas_catalogo VALUES (29, 'CYS-LIN-BLA-XL', 'Guayabera Lino Presidencial Blanco Puro', 'Guayabera Formal', 'XL', 'Blanco Puro', 2, 27.00, 54.00, 88.00, true, '2026-09-17 05:29:23.596848+00');
INSERT INTO mercancia_vault.camisas_catalogo VALUES (30, 'CYS-POP-VIN-M', 'Camisa Popelina Stretch Borgoña Vino Tinto', 'Ejecutiva Moderna', 'M', 'Vino Tinto', 3, 18.50, 36.00, 58.00, true, '2026-09-17 05:29:23.596848+00');
INSERT INTO mercancia_vault.camisas_catalogo VALUES (31, 'CYS-OXF-RAY-M', 'Camisa Oxford Rayas Diplomáticas Azules', 'Oxford Business', 'M', 'Rayas Azul/Blanco', 1, 15.00, 30.00, 48.00, true, '2026-09-17 05:29:23.596848+00');
INSERT INTO mercancia_vault.camisas_catalogo VALUES (32, 'CYS-POP-BLA-L', 'Camisa Popelina Blanca Cuello Francés', 'Clásica Etiqueta', 'L', 'Blanco Óptico', 3, 17.00, 34.00, 52.00, true, '2026-09-17 05:29:23.596848+00');
INSERT INTO mercancia_vault.camisas_catalogo VALUES (33, 'CYS-OXF-ROS-L', 'Camisa Oxford Rosa Salmón Ejecutivo', 'Oxford Clásica', 'L', 'Rosa Salmón', 1, 14.50, 28.00, 45.00, true, '2026-09-17 05:29:23.596848+00');
INSERT INTO mercancia_vault.camisas_catalogo VALUES (34, 'CYS-LIN-BLA-M', 'Guayabera Lino Presidencial Blanco Puro', 'Guayabera Formal', 'M', 'Blanco Puro', 2, 26.00, 52.00, 85.00, true, '2026-09-17 05:29:23.596848+00');
INSERT INTO mercancia_vault.camisas_catalogo VALUES (35, 'CYS-OXF-RAY-L', 'Camisa Oxford Rayas Diplomáticas Azules', 'Oxford Business', 'L', 'Rayas Azul/Blanco', 1, 15.00, 30.00, 48.00, true, '2026-09-17 05:29:23.596848+00');
INSERT INTO mercancia_vault.camisas_catalogo VALUES (36, 'CYS-EGI-BLA-L', 'Camisa Algodón Egipcio Giza Edición Limitada', 'Haute Couture', 'L', 'Blanco Nieve', 1, 38.00, 75.00, 130.00, true, '2026-09-17 05:29:23.596848+00');
INSERT INTO mercancia_vault.camisas_catalogo VALUES (37, 'CYS-LIN-BLA-L', 'Guayabera Lino Presidencial Blanco Puro', 'Guayabera Formal', 'L', 'Blanco Puro', 2, 26.00, 52.00, 85.00, true, '2026-09-17 05:29:23.596848+00');
INSERT INTO mercancia_vault.camisas_catalogo VALUES (38, 'CYS-LIN-NEG-L', 'Guayabera Lino Negro Gala Nocturna', 'Guayabera Gala', 'L', 'Negro', 2, 27.50, 55.00, 90.00, true, '2026-09-17 05:29:23.596848+00');
INSERT INTO mercancia_vault.camisas_catalogo VALUES (39, 'CYS-DOB-BLA-M', 'Camisa Dobby Micro-Rombo Blanco Textura', 'Presidencial Formal', 'M', 'Blanco Estructurado', 1, 21.00, 42.00, 68.00, true, '2026-09-17 05:29:23.596848+00');
INSERT INTO mercancia_vault.camisas_catalogo VALUES (40, 'CYS-CHB-IND-M', 'Camisa Chambray Casual Sartorial', 'Smart Casual', 'M', 'Celeste Índigo', 1, 17.50, 35.00, 58.00, true, '2026-09-17 05:29:23.596848+00');
INSERT INTO mercancia_vault.camisas_catalogo VALUES (41, 'CYS-TWI-AZU-L', 'Camisa Twill Imperial Azul Medianoche', 'Corte Diplomático', 'L', 'Azul Marino', 2, 29.00, 58.00, 95.00, true, '2026-09-17 05:29:23.596848+00');
INSERT INTO mercancia_vault.camisas_catalogo VALUES (42, 'CYS-CHB-IND-L', 'Camisa Chambray Casual Sartorial', 'Smart Casual', 'L', 'Celeste Índigo', 1, 17.50, 35.00, 58.00, true, '2026-09-17 05:29:23.596848+00');
INSERT INTO mercancia_vault.camisas_catalogo VALUES (43, 'CYS-OXF-RAY-XL', 'Camisa Oxford Rayas Diplomáticas Azules', 'Oxford Business', 'XL', 'Rayas Azul/Blanco', 1, 15.50, 31.00, 50.00, true, '2026-09-17 05:29:23.596848+00');
INSERT INTO mercancia_vault.camisas_catalogo VALUES (44, 'CYS-POP-BLA-M', 'Camisa Popelina Blanca Cuello Francés', 'Clásica Etiqueta', 'M', 'Blanco Óptico', 3, 17.00, 34.00, 52.00, true, '2026-09-17 05:29:23.596848+00');
INSERT INTO mercancia_vault.camisas_catalogo VALUES (45, 'CYS-TWI-AZU-M', 'Camisa Twill Imperial Azul Medianoche', 'Corte Diplomático', 'M', 'Azul Marino', 2, 29.00, 58.00, 95.00, true, '2026-09-17 05:29:23.596848+00');


--
-- Data for Name: ordenes_detalle; Type: TABLE DATA; Schema: bodega_wms; Owner: postgres_admin
--

INSERT INTO bodega_wms.ordenes_detalle VALUES (1, 1, 'CYS-OXF-BLA-M', 5);
INSERT INTO bodega_wms.ordenes_detalle VALUES (2, 2, 'CYS-OXF-BLA-M', 1);
INSERT INTO bodega_wms.ordenes_detalle VALUES (3, 3, 'CYS-OXF-BLA-M', 2);
INSERT INTO bodega_wms.ordenes_detalle VALUES (4, 4, 'CYS-OXF-BLA-M', 1);
INSERT INTO bodega_wms.ordenes_detalle VALUES (5, 5, 'CYS-OXF-BLA-M', 1);
INSERT INTO bodega_wms.ordenes_detalle VALUES (6, 6, 'CYS-OXF-BLA-M', 1);
INSERT INTO bodega_wms.ordenes_detalle VALUES (7, 7, 'CYS-OXF-BLA-M', 2);
INSERT INTO bodega_wms.ordenes_detalle VALUES (8, 15, 'CYS-OXF-ROS-M', 3);
INSERT INTO bodega_wms.ordenes_detalle VALUES (9, 19, 'CYS-LIN-BLA-L', 2);
INSERT INTO bodega_wms.ordenes_detalle VALUES (10, 16, 'CYS-EGI-BLA-M', 1);
INSERT INTO bodega_wms.ordenes_detalle VALUES (11, 10, 'CYS-TWI-AZU-L', 4);
INSERT INTO bodega_wms.ordenes_detalle VALUES (12, 13, 'CYS-POP-VIN-M', 2);


--
-- Data for Name: stock_inventario; Type: TABLE DATA; Schema: bodega_wms; Owner: postgres_admin
--

INSERT INTO bodega_wms.stock_inventario VALUES (2, 'CYS-OXF-BLA-L', 1, 95, 0, '2026-09-16 22:48:43.467295+00');
INSERT INTO bodega_wms.stock_inventario VALUES (3, 'CYS-OXF-AZU-M', 2, 80, 0, '2026-09-16 22:48:43.467295+00');
INSERT INTO bodega_wms.stock_inventario VALUES (4, 'CYS-LIN-BEI-L', 3, 40, 0, '2026-09-16 22:48:43.467295+00');
INSERT INTO bodega_wms.stock_inventario VALUES (5, 'CYS-POP-NEG-M', 2, 60, 0, '2026-09-16 22:48:43.467295+00');
INSERT INTO bodega_wms.stock_inventario VALUES (1, 'CYS-OXF-BLA-M', 1, 107, 13, '2026-09-17 04:37:47.724427+00');
INSERT INTO bodega_wms.stock_inventario VALUES (26, 'CYS-DOB-BLA-L', 16, 39, 7, '2026-09-17 06:26:43.881812+00');
INSERT INTO bodega_wms.stock_inventario VALUES (27, 'CYS-EGI-BLA-M', 16, 102, 5, '2026-09-17 06:26:43.881812+00');
INSERT INTO bodega_wms.stock_inventario VALUES (28, 'CYS-OXF-ROS-M', 16, 85, 4, '2026-09-17 06:26:43.881812+00');
INSERT INTO bodega_wms.stock_inventario VALUES (29, 'CYS-LIN-BLA-XL', 16, 40, 3, '2026-09-17 06:26:43.881812+00');
INSERT INTO bodega_wms.stock_inventario VALUES (30, 'CYS-POP-VIN-M', 16, 46, 5, '2026-09-17 06:26:43.881812+00');
INSERT INTO bodega_wms.stock_inventario VALUES (31, 'CYS-OXF-RAY-M', 16, 48, 0, '2026-09-17 06:26:43.881812+00');
INSERT INTO bodega_wms.stock_inventario VALUES (32, 'CYS-POP-BLA-L', 16, 64, 4, '2026-09-17 06:26:43.881812+00');
INSERT INTO bodega_wms.stock_inventario VALUES (33, 'CYS-OXF-ROS-L', 16, 104, 2, '2026-09-17 06:26:43.881812+00');
INSERT INTO bodega_wms.stock_inventario VALUES (34, 'CYS-LIN-BLA-M', 16, 66, 1, '2026-09-17 06:26:43.881812+00');
INSERT INTO bodega_wms.stock_inventario VALUES (35, 'CYS-OXF-RAY-L', 16, 47, 5, '2026-09-17 06:26:43.881812+00');
INSERT INTO bodega_wms.stock_inventario VALUES (36, 'CYS-EGI-BLA-L', 16, 68, 2, '2026-09-17 06:26:43.881812+00');
INSERT INTO bodega_wms.stock_inventario VALUES (37, 'CYS-LIN-BLA-L', 16, 102, 7, '2026-09-17 06:26:43.881812+00');
INSERT INTO bodega_wms.stock_inventario VALUES (38, 'CYS-LIN-NEG-L', 16, 53, 0, '2026-09-17 06:26:43.881812+00');
INSERT INTO bodega_wms.stock_inventario VALUES (39, 'CYS-DOB-BLA-M', 16, 99, 2, '2026-09-17 06:26:43.881812+00');
INSERT INTO bodega_wms.stock_inventario VALUES (40, 'CYS-CHB-IND-M', 16, 101, 0, '2026-09-17 06:26:43.881812+00');
INSERT INTO bodega_wms.stock_inventario VALUES (41, 'CYS-TWI-AZU-L', 16, 114, 7, '2026-09-17 06:26:43.881812+00');
INSERT INTO bodega_wms.stock_inventario VALUES (42, 'CYS-CHB-IND-L', 16, 81, 2, '2026-09-17 06:26:43.881812+00');
INSERT INTO bodega_wms.stock_inventario VALUES (43, 'CYS-OXF-RAY-XL', 16, 47, 2, '2026-09-17 06:26:43.881812+00');
INSERT INTO bodega_wms.stock_inventario VALUES (44, 'CYS-POP-BLA-M', 16, 85, 7, '2026-09-17 06:26:43.881812+00');
INSERT INTO bodega_wms.stock_inventario VALUES (45, 'CYS-TWI-AZU-M', 16, 104, 7, '2026-09-17 06:26:43.881812+00');


--
-- Data for Name: empleados_acl; Type: TABLE DATA; Schema: seguridad_iam; Owner: postgres_admin
--

INSERT INTO seguridad_iam.empleados_acl VALUES (5, '8840219', 'Joshua Méndez', 'Supervisor General (Token Extendido)', '{BOD-CENTRAL-01,SUC-ZONA10,SUC-MIRAFLORES,SUC-CAYALA}', '8840', 'ACTIVO', '2026-09-17 05:20:13.464223+00');
INSERT INTO seguridad_iam.empleados_acl VALUES (2, '102', 'Joshua Méndez', 'Supervisor General & Auditor', '{BOD-CENTRAL-01,SUC-ZONA10,SUC-MIRAFLORES,SUC-CAYALA}', '8840', 'ACTIVO', '2026-09-17 05:20:13.464223+00');
INSERT INTO seguridad_iam.empleados_acl VALUES (3, '103', 'Elías Marquirez', 'Jefe de Bodega Central', '{BOD-CENTRAL-01}', '5678', 'ACTIVO', '2026-09-17 05:20:13.464223+00');
INSERT INTO seguridad_iam.empleados_acl VALUES (1, '101', 'Esteban Salic', 'Vendedor de Piso', '{BOD-CENTRAL-01,SUC-ZONA10}', '4321', 'ACTIVO', '2026-09-17 05:20:13.464223+00');
INSERT INTO seguridad_iam.empleados_acl VALUES (6, '99283104', 'Esteban Salic', 'Vendedor Especialista (Credencial Segura)', '{BOD-CENTRAL-01,SUC-ZONA10}', '4321', 'ACTIVO', '2026-09-17 05:20:13.464223+00');
INSERT INTO seguridad_iam.empleados_acl VALUES (4, '201', 'Carlos Repartidor', 'Repartidor Express (COD)', '{BOD-CENTRAL-01,SUC-ZONA10}', '9900', 'ACTIVO', '2026-09-17 05:20:13.464223+00');


--
-- Name: logs_inmutables_id_seq; Type: SEQUENCE SET; Schema: auditoria_core; Owner: postgres_admin
--

SELECT pg_catalog.setval('auditoria_core.logs_inmutables_id_seq', 69, true);


--
-- Name: estanterias_id_seq; Type: SEQUENCE SET; Schema: bodega_wms; Owner: postgres_admin
--

SELECT pg_catalog.setval('bodega_wms.estanterias_id_seq', 17, true);


--
-- Name: ordenes_despacho_id_seq; Type: SEQUENCE SET; Schema: bodega_wms; Owner: postgres_admin
--

SELECT pg_catalog.setval('bodega_wms.ordenes_despacho_id_seq', 19, true);


--
-- Name: ordenes_detalle_id_seq; Type: SEQUENCE SET; Schema: bodega_wms; Owner: postgres_admin
--

SELECT pg_catalog.setval('bodega_wms.ordenes_detalle_id_seq', 12, true);


--
-- Name: stock_inventario_id_seq; Type: SEQUENCE SET; Schema: bodega_wms; Owner: postgres_admin
--

SELECT pg_catalog.setval('bodega_wms.stock_inventario_id_seq', 45, true);


--
-- Name: camisas_catalogo_id_seq; Type: SEQUENCE SET; Schema: mercancia_vault; Owner: postgres_admin
--

SELECT pg_catalog.setval('mercancia_vault.camisas_catalogo_id_seq', 45, true);


--
-- Name: proveedores_id_seq; Type: SEQUENCE SET; Schema: mercancia_vault; Owner: postgres_admin
--

SELECT pg_catalog.setval('mercancia_vault.proveedores_id_seq', 14, true);


--
-- Name: telas_id_seq; Type: SEQUENCE SET; Schema: mercancia_vault; Owner: postgres_admin
--

SELECT pg_catalog.setval('mercancia_vault.telas_id_seq', 17, true);


--
-- Name: empleados_acl_id_seq; Type: SEQUENCE SET; Schema: seguridad_iam; Owner: postgres_admin
--

SELECT pg_catalog.setval('seguridad_iam.empleados_acl_id_seq', 6, true);


--
-- PostgreSQL database dump complete
--

\unrestrict 0mFf1YBcaGrqGMG63f8bH5Ye1KOk2OAAJBRvV4snO28MFchSVxfRiqMZjcTzl5J

