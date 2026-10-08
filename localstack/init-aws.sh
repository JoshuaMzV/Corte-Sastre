#!/usr/bin/env bash
set -eo pipefail

echo "=========================================================="
echo "Inicializando Servicios AWS en LocalStack (Corte & Sastre)"
echo "=========================================================="

export AWS_DEFAULT_REGION=us-east-1
export AWS_ACCESS_KEY_ID=test
export AWS_SECRET_ACCESS_KEY=test

# 1. Crear Master Key en AWS KMS para Envelope Encryption
echo "Creando Master Key en AWS KMS..."
KMS_KEY_OUT=$(awslocal kms create-key --description "Master Key Cifrado de Sobres Corte & Sastre")
echo "$KMS_KEY_OUT"

# 2. Crear Cola SQS para procesamiento seguro de pedidos
echo "Creando Cola SQS: pedidos-buffer-queue..."
awslocal sqs create-queue --queue-name pedidos-buffer-queue

# 3. Crear Bucket S3 para Respaldos WORM / Inmutables
echo "Creando Bucket S3 de Respaldos..."
awslocal s3 mb s3://corte-y-sastre-backups

# 4. Guardar secreto en Secrets Manager
echo "Guardando secreto en Secrets Manager..."
awslocal secretsmanager create-secret \
    --name "corte-y-sastre/db-credentials" \
    --description "Credenciales seguras PostgreSQL" \
    --secret-string '{"db_host":"postgres-core","db_port":5432,"db_user":"app_backend_user","db_pass":"BackendServicePassword2026!","db_name":"corte_y_sastre_db"}'

echo "=========================================================="
echo "LocalStack inicializado con éxito para Corte & Sastre."
echo "=========================================================="
