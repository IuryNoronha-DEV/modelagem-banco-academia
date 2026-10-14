-- Sprint 5 | Controle de acesso
-- Execute como usuário administrador/superusuário do PostgreSQL.
-- Troque as senhas de exemplo antes de executar em ambiente real.
CREATE ROLE academia_leitura NOLOGIN;
GRANT CONNECT ON DATABASE postgres TO academia_leitura; -- ajuste 'postgres' para o nome real do seu banco, se necessário
GRANT USAGE ON SCHEMA academia_sprint5 TO academia_leitura;
GRANT SELECT ON ALL TABLES IN SCHEMA academia_sprint5 TO academia_leitura;
ALTER DEFAULT PRIVILEGES IN SCHEMA academia_sprint5 GRANT SELECT ON TABLES TO academia_leitura;

CREATE ROLE academia_operacao NOLOGIN;
GRANT USAGE ON SCHEMA academia_sprint5 TO academia_operacao;
GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA academia_sprint5 TO academia_operacao;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA academia_sprint5 TO academia_operacao;
REVOKE DELETE ON ALL TABLES IN SCHEMA academia_sprint5 FROM academia_operacao;
ALTER DEFAULT PRIVILEGES IN SCHEMA academia_sprint5 GRANT SELECT, INSERT, UPDATE ON TABLES TO academia_operacao;
ALTER DEFAULT PRIVILEGES IN SCHEMA academia_sprint5 GRANT USAGE, SELECT ON SEQUENCES TO academia_operacao;

-- Usuários distintos vinculados a roles. Se já existirem, crie-os uma única vez ou ajuste manualmente.
CREATE USER academia_consulta WITH PASSWORD 'TroqueEstaSenha_Consulta_2026!';
GRANT academia_leitura TO academia_consulta;
CREATE USER academia_atendente WITH PASSWORD 'TroqueEstaSenha_Atendente_2026!';
GRANT academia_operacao TO academia_atendente;

-- Menor privilégio: consulta não pode modificar; operação não recebe DELETE.
REVOKE INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA academia_sprint5 FROM academia_leitura;
