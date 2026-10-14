CREATE ROLE academia_leitura NOLOGIN;
CREATE USER academia_consulta WITH PASSWORD 'TROQUE_POR_SENHA_FORTE_1';
CREATE USER academia_operacao WITH PASSWORD 'TROQUE_POR_SENHA_FORTE_2';

GRANT CONNECT ON DATABASE modelagem_banco_academia TO academia_leitura;
GRANT CONNECT ON DATABASE modelagem_banco_academia TO academia_operacao;

GRANT USAGE ON SCHEMA public TO academia_leitura, academia_operacao;

-- Perfil de consulta: somente leitura nas tabelas do projeto.
GRANT SELECT ON TABLE aluno, plano, professor, matricula, aula TO academia_leitura;
GRANT academia_leitura TO academia_consulta;

-- Perfil operacional: consulta e alteração de dados, sem permissão de DDL.
GRANT SELECT, INSERT, UPDATE, DELETE
ON TABLE aluno, plano, professor, matricula, aula TO academia_operacao;

-- Permite que inserções com IDs gerados funcionem para o perfil operacional.
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO academia_operacao;

-- Exemplo de revogação: o perfil de leitura não pode alterar dados.
REVOKE INSERT, UPDATE, DELETE ON TABLE aluno, plano, professor, matricula, aula
FROM academia_leitura;

-- Para futuras tabelas criadas pelo usuário que executar estes comandos:
-- ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO academia_leitura;
