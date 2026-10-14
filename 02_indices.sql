-- Sprint 4 - Índices da Academia
-- PK e UNIQUE já criam índices automaticamente no PostgreSQL.
-- Estes índices adicionais apoiam FKs e consultas frequentes.

CREATE INDEX IF NOT EXISTS idx_matricula_id_aluno
    ON matricula (id_aluno);
-- Justificativa: acelera consultas e JOINs entre aluno e matrícula.

CREATE INDEX IF NOT EXISTS idx_matricula_id_plano
    ON matricula (id_plano);
-- Justificativa: acelera JOINs/filtragem de matrículas por plano.

CREATE INDEX IF NOT EXISTS idx_aula_id_professor
    ON aula (id_professor);
-- Justificativa: acelera JOINs e busca de aulas ministradas por professor.

CREATE INDEX IF NOT EXISTS idx_matricula_status
    ON matricula (status);
-- Justificativa: apoia consultas por status (ATIVA/CANCELADA).
-- Como há poucos valores distintos, a utilidade depende do volume e da seletividade.
