// ============================================================================
// INICIALIZACIÓN DE BUFFER TRANSITORIO NOSQL (MONGODB 7.0)
// ============================================================================

db = db.getSiblingDB("pedidos_buffer");

// 1. Crear colección con índices para performance de ingesta
db.createCollection("pedidos_ingesta");
db.pedidos_ingesta.createIndex({ "timestamp_ingesta": 1 });
db.pedidos_ingesta.createIndex({ "worker_code": 1 });
db.pedidos_ingesta.createIndex({ "flag_etl": 1 });

// 2. Insertar preórdenes de muestra en DMZ
db.pedidos_ingesta.insertMany([
  {
    handheld_id: "HH-MATRIZ-01",
    sucursal_id: "BOD-CENTRAL-01",
    bodega_origen: "BOD-CENTRAL-01",
    flag_etl: "READY_FOR_DISPATCH",
    cliente_nombre: "Corporación Castillo Hermanos",
    cliente_direccion: "Avenida Candelaria 2-04 Zona 1",
    nit: "8472910-4",
    items: [
      { sku: "CYS-OXF-BLA-M", cantidad: 12, precio_unitario: 45.00 },
      { sku: "CYS-LIN-BLA-L", cantidad: 6, precio_unitario: 65.00 }
    ],
    worker_code: "102",
    total_orden: 930.00,
    estado_ingesta: "EN_PROCESAMIENTO_BUFFER",
    metodo_pago: "CREDITO_30_DIAS",
    timestamp_ingesta: new Date()
  },
  {
    handheld_id: "HH-ZONA10-02",
    sucursal_id: "SUC-ZONA10",
    bodega_origen: "BOD-CENTRAL-01",
    flag_etl: "PENDING_CREDIT_CHECK",
    cliente_nombre: "Club Alemán de Guatemala",
    cliente_direccion: "3a Avenida 13-37 Zona 10",
    nit: "1940294-1",
    items: [
      { sku: "CYS-EGI-BLA-M", cantidad: 4, precio_unitario: 95.00 },
      { sku: "CYS-TWI-AZU-L", cantidad: 5, precio_unitario: 80.00 }
    ],
    worker_code: "101",
    total_orden: 780.00,
    estado_ingesta: "EN_PROCESAMIENTO_BUFFER",
    metodo_pago: "TRANSFERENCIA_BANCARIA",
    timestamp_ingesta: new Date()
  },
  {
    handheld_id: "HH-CAYALA-03",
    sucursal_id: "SUC-CAYALA",
    bodega_origen: "BOD-CENTRAL-01",
    flag_etl: "EXPRESS_VIP",
    cliente_nombre: "Dr. Fernando Morales (Clínica Las Américas)",
    cliente_direccion: "Avenida Las Américas 8-42 Zona 14",
    nit: "3829104-9",
    items: [
      { sku: "CYS-DOB-BLA-M", cantidad: 3, precio_unitario: 75.00 },
      { sku: "CYS-CHB-IND-L", cantidad: 2, precio_unitario: 55.00 }
    ],
    worker_code: "103",
    total_orden: 335.00,
    estado_ingesta: "EN_PROCESAMIENTO_BUFFER",
    metodo_pago: "TARJETA_CREDITO_VISALINK",
    timestamp_ingesta: new Date()
  }
]);

print("✔ MongoDB Buffer pedidos_buffer inicializado con éxito.");
