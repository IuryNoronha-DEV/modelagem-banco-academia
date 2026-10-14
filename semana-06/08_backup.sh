#!/usr/bin/env bash
set -Eeuo pipefail
umask 077

DB_NAME="${DB_NAME:-academia_sprint5}"
DB_HOST="${DB_HOST:-localhost}"
DB_PORT="${DB_PORT:-5432}"
DB_USER="${DB_USER:-postgres}"
BACKUP_DIR="${BACKUP_DIR:-$HOME/backups/postgresql}"
RETENTION_DAYS="${RETENTION_DAYS:-30}"

command -v pg_dump >/dev/null 2>&1 || {
  printf 'Erro: pg_dump não foi encontrado no PATH.\n' >&2
  exit 1
}
command -v find >/dev/null 2>&1 || {
  printf 'Erro: find não foi encontrado no PATH.\n' >&2
  exit 1
}

mkdir -p "$BACKUP_DIR"
timestamp="$(date '+%Y%m%d_%H%M%S')"
backup_file="$BACKUP_DIR/${DB_NAME}_${timestamp}.dump"
temporary_file="${backup_file}.tmp"

cleanup() {
  rm -f "$temporary_file"
}
trap cleanup EXIT

printf 'Iniciando backup de %s...\n' "$DB_NAME"
if ! pg_dump \
  --host="$DB_HOST" \
  --port="$DB_PORT" \
  --username="$DB_USER" \
  --dbname="$DB_NAME" \
  --format=custom \
  --file="$temporary_file"; then
  printf 'Erro: o backup falhou; o arquivo temporário será removido.\n' >&2
  exit 1
fi

mv "$temporary_file" "$backup_file"
printf 'Backup concluído: %s\n' "$backup_file"

find "$BACKUP_DIR" -maxdepth 1 -type f \
  -name "${DB_NAME}_*.dump" \
  -mtime "+$RETENTION_DAYS" \
  -print -delete

printf 'Limpeza de backups com mais de %s dias concluída.\n' "$RETENTION_DAYS"
