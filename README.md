# 🛡️ Plataforma de Seguridad y Trazabilidad Textil — "Corte & Sastre"

[![Docker Compose](https://img.shields.io/badge/Docker-Compose-2496ED?logo=docker&logoColor=white)](https://www.docker.com/)
[![PostgreSQL 16](https://img.shields.io/badge/PostgreSQL-16-336791?logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![MongoDB 7.0](https://img.shields.io/badge/MongoDB-7.0-47A248?logo=mongodb&logoColor=white)](https://www.mongodb.com/)
[![Golang 1.22](https://img.shields.io/badge/Golang-1.22-00ADD8?logo=go&logoColor=white)](https://go.dev/)
[![LocalStack AWS](https://img.shields.io/badge/LocalStack-AWS%20SQS-FF9900?logo=amazon-aws&logoColor=white)](https://localstack.cloud/)
[![OWASP API Security](https://img.shields.io/badge/OWASP-API%20Top%2010-blue)](https://owasp.org/)
[![ISO/IEC 27001](https://img.shields.io/badge/ISO%2FIEC-27001%20Compliant-success)](https://www.iso.org/)

---

## 🏛️ Contexto Académico
* **Institución:** Universidad Mariano Gálvez de Guatemala (UMG)
* **Facultad:** Ingeniería en Sistemas de Información y Ciencias de la Computación
* **Curso:** Seguridad y Auditoría de Sistemas
* **Catedrático:** Ing. Omar Sagastume
* **Equipo de Trabajo:**
  * **Joshua Iván André Méndez Vásquez** (Líder Técnico & Auditor de Ciberseguridad)
  * **Esteban David Salic Mejía** (Arquitectura & Desarrollo)
  * **Elías Gregorio Marquirez** (Infraestructura & Operaciones)

---

## 📚 Documentación del Proyecto
* [📘 Documentación Técnica Ágil (Scrum, Sprints, DoD y Arquitectura)](docs/DOCUMENTACION_TECNICA.md)
* [📱 Manual de Usuario (Guía Operativa Móvil PWA, Despacho y Auditoría)](docs/MANUAL_DE_USUARIO.md)
* [🛡️ Arquitectura de Ciberseguridad y Trazabilidad Textil](docs/ARQUITECTURA_SEGURIDAD.md)

---

## 👔 1. Modelo de Negocio y Segmento
**Corte & Sastre** es una empresa guatemalteca especializada en la **confección y distribución de camisería masculina de lujo y sastrería a medida (*Bespoke Tailoring*)**.
* **Segmento:** Sector corporativo de alta dirección, profesionales y diplomáticos en zonas comerciales prémium (Zona 10, Zona 14, Plaza Fontabella, Paseo Cayalá).
* **Canales:** Tiendas físicas, asesores de campo equipados con terminales móviles (*Handheld PWA*), y rutas de entrega con cobro contra entrega (*COD - Cash On Delivery*).
* **Activo Crítico (*Crown Jewels*):** Fichas técnicas de confección, fórmulas textiles (Lino Belga, Algodón Egipcio Giza 87), costos unitarios de importación y contratos confidenciales con tejedurías internacionales.

---

## 📐 2. Arquitectura de Tres Capas ("Zero Trust Data Tiering")

```mermaid
flowchart TD
    subgraph Zona1["1. Zona No Confiable (Borde)"]
        HH["📱 Handheld PWA Móvil (iOS / Android)<br/>• Identificación de Operador + PIN<br/>• 2FA Fuera de Banda (Telegram)<br/>• TLS 1.3 Cifrado Punto a Punto"]
    end

    subgraph Zona2["2. DMZ (Buffer Volátil Perimetral)"]
        API["⚙️ API Gateway (Golang / Gin)<br/>• Consultas Parametrizadas Anti-SQLi<br/>• Filtrado Estricto Anti-Data-Leak"]
        BD1[("🍃 BD 1: MongoDB 7.0 (Buffer Ingesta)<br/>• Colección: pedidos_ingesta<br/>• Política: Zero Data Retention")]
        SQS["☁️ AWS SQS Emulado (LocalStack)<br/>• Cola: pedidos-buffer-queue"]
    end

    subgraph Zona3["3. Zona Blindada (Red Interna Aislada)"]
        Worker["🔄 Worker Asíncrono Seguro (PULL Pattern)<br/>• Transacción ACID + Purga DMZ"]
        BD2[("📦 BD 2: Bodega WMS (PostgreSQL 16)<br/>• 10 Estados Logísticos Oficiales<br/>• Restricción CHECK stock >= 0")]
        BD3[("💎 BD 3: Crown Jewels (PostgreSQL 16)<br/>• Catálogo Maestro, Costos y Fórmulas<br/>• Sin Exposición Externa")]
        WORM[("🛡️ Ledger WORM (PostgreSQL 16)<br/>• Triggers Anti-UPDATE / Anti-DELETE<br/>• Encadenamiento SHA-256 (Hash Chaining)")]
    end

    HH -->|"1. POST /api/v1/pedidos (HTTPS)"| API
    API -->|"2. Deposita preorden volátil"| BD1
    API -->|"3. Notifica mensaje SQS"| SQS
    SQS -->|"4. Consumo PULL"| Worker
    Worker -->|"5. Extrae y PURGA buffer"| BD1
    Worker -->|"6. Registra despacho en Bodega"| BD2
    BD2 <-->|"7. Valida disponibilidad y reglas"| BD3
    Worker -->|"8. Sella bloque inmutable SHA-256"| WORM
```

### Principios Fundamentales de Seguridad
1. **Flujo Unidireccional PULL:** La aplicación móvil y la DMZ jamás tienen acceso directo a la base de datos interna. El worker interno extrae información desde la DMZ hacia el núcleo seguro.
2. **Zero Data Retention en DMZ:** Los pedidos procesados en MongoDB son eliminados inmediatamente tras su registro en PostgreSQL, eliminando cualquier vector de acumulación perimetral.
3. **Ledger Inmutable WORM (*Write Once, Read Many*):** Triggers a nivel de kernel de PostgreSQL impiden sentencias `UPDATE` o `DELETE` sobre los logs de auditoría. Cada fila está encadenada matemáticamente por hash SHA-256:
   $$\text{Hash}_N = \text{SHA256}(\text{ID} + \text{Actor} + \text{Acción} + \text{Recurso} + \text{Payload} + \text{IP} + \text{Hash}_{N-1})$$
4. **Filtrado Anti-Data-Leak:** El backend omite deliberadamente los costos de producción y márgenes comerciales en las respuestas al dispositivo móvil.
5. **Autenticación Fuerte Fuera de Banda (2FA):** Código OTP numérico de 6 dígitos con entrega vía Telegram Bot API.

---

## 📂 3. Estructura del Repositorio

```text
├── backend/
│   ├── Dockerfile                 # Imagen multi-stage optimizada en Alpine Linux
│   ├── go.mod                     # Dependencias oficiales de Go
│   ├── main.go                    # API Gateway, worker asíncrono y control de 2FA
│   └── frontend/
│       ├── index.html             # Handheld PWA interactivo (Modo oscuro / bodeguero)
│       ├── app.js                 # Lógica de cliente, escáner de códigos y offline SW
│       ├── styles.css             # Estilos responsivos para terminales móviles
│       ├── sw.js                  # Service Worker de la PWA
│       ├── manifest.json          # Manifiesto de instalación nativa iOS / Android
│       ├── explorador.html        # Explorador visual Multi-BD (PostgreSQL, MongoDB, SQS)
│       └── auditoria.html         # Consola forense del Ledger WORM SHA-256
├── db/
│   └── init-scripts/
│       ├── 01_init_schemas_and_roles.sql   # Creación de esquemas y permisos
│       ├── 02_init_tables.sql              # Definición de tablas, llaves y triggers WORM
│       ├── 03_seed_data.sql                # Datos maestros base
│       └── 04_full_enterprise_data.sql     # Catálogo completo (25 SKUs, 8 proveedores, 10 telas, 19 despachos)
├── localstack/
│   └── init-aws.sh                # Script de aprovisionamiento de cola AWS SQS
├── docs/
│   └── ARQUITECTURA_SEGURIDAD.md  # Informe formal y mapeo de controles ISO 27001 / OWASP
├── docker-compose.yml             # Orquestador con red aislada bridge (cys_isolated_net)
├── .env.example                   # Plantilla de variables de entorno
└── .gitignore                     # Filtro de archivos para control de versiones
```

---

## 🚀 4. Puesta en Marcha Rápida (Local)

### Requisitos Previos
* Docker y Docker Compose instalados.
* Git.

### Instalación
```bash
# 1. Clonar el repositorio
git clone https://github.com/JoshuaMzV/Corte-Sastre.git
cd Corte-Sastre

# 2. Configurar variables de entorno
cp .env.example .env

# 3. Levantar la infraestructura completa
docker compose up -d --build
```

### Accesos Locales
* 📱 **Handheld Móvil:** `http://localhost:8088/`
* 🗄️ **Explorador Multi-BD:** `http://localhost:8088/explorador`
* 🛡️ **Consola Forense WORM:** `http://localhost:8088/auditoria`

---

## 🗄️ 5. Especificación y Acceso a las 3 Bases de Datos Locales

El archivo `docker-compose.yml` inicializa automáticamente todos los esquemas, tablas, datos maestros y colas al arrancar por primera vez:

### A. PostgreSQL 16 (`postgres-core` | Puerto Host: 5433 / Interno: 5432)
* **Base de datos:** `corte_y_sastre_db`
* **Credenciales:** Usuario `postgres_admin` | Contraseña `MasterAdminDB2026!`
* **Esquemas Aprovisionados (`db/init-scripts/`):**
  * `seguridad_iam`: `empleados_acl` (Control de acceso basado en roles y sedes autorizadas).
  * `mercancia_vault`: `camisas_catalogo`, `proveedores`, `telas` (Catálogo confidencial de lujo y costos).
  * `bodega_wms`: `estanterias`, `stock_inventario`, `ordenes_despacho`, `ordenes_detalle` (Gestión logística de bodega con 10 estados).
  * `auditoria_core`: `logs_inmutables` (Ledger con triggers WORM y encadenamiento SHA-256).
* **Comando para ingresar por consola:**
  ```bash
  docker exec -it cys_postgres_core psql -U postgres_admin -d corte_y_sastre_db
  ```

### B. MongoDB 7.0 (`mongo-buffer` | Puerto: 27017)
* **Base de datos:** `pedidos_buffer`
* **Colección auto-creada (`db/mongo-init/`):** `pedidos_ingesta` (Buffer DMZ volátil con política Zero Data Retention).
* **Credenciales:** Usuario `admin_buffer` | Contraseña `BufferSecure2026!` (authSource: `admin`)
* **Comando para ingresar por consola:**
  ```bash
  docker exec -it cys_mongo_buffer mongosh -u admin_buffer -p BufferSecure2026! --authenticationDatabase admin pedidos_buffer
  ```

### C. LocalStack AWS Emulado (`localstack` | Puerto: 4566)
* **Servicios Activos:** AWS SQS, AWS KMS, AWS S3, AWS Secrets Manager.
* **Cola auto-aprovisionada (`localstack/init-aws.sh`):** `pedidos-buffer-queue`
* **Comando para inspeccionar la cola SQS:**
  ```bash
  docker exec -it cys_localstack awslocal sqs get-queue-attributes --queue-url http://sqs.us-east-1.localhost.localstack.cloud:4566/000000000000/pedidos-buffer-queue --attribute-names All
  ```

---

## 🔍 6. Verificación Criptográfica de Auditoría
Para comprobar matemáticamente que ningún registro ha sido manipulado en el Ledger WORM:
```bash
docker exec -it cys_postgres_core psql -U postgres_admin -d corte_y_sastre_db -c "SELECT * FROM auditoria_core.verificar_integridad();"
```
**Resultado esperado:**
```text
 es_valido | registros_auditados | error_en_id 
-----------+---------------------+-------------
 t         |                  49 |            
(1 row)
```

---

## 📜 Licencia y Uso
Proyecto con fines exclusivamente educativos y de investigación para la Universidad Mariano Gálvez de Guatemala.
