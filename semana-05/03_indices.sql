-- Sprint 5 | Índices justificados
SET search_path TO academia_sprint5, public;

-- Índices nas FKs usadas em JOINs: PostgreSQL não cria automaticamente índices nas colunas FK.
CREATE INDEX IF NOT EXISTS idx_matricula_aluno ON matricula(id_aluno);
CREATE INDEX IF NOT EXISTS idx_matricula_plano ON matricula(id_plano);
CREATE INDEX IF NOT EXISTS idx_aula_professor_inicio ON aula(id_professor, inicio);
CREATE INDEX IF NOT EXISTS idx_aula_modalidade ON aula(id_modalidade);
CREATE INDEX IF NOT EXISTS idx_aula_unidade_inicio ON aula(id_unidade, inicio);
CREATE INDEX IF NOT EXISTS idx_participacao_aluno ON participacao_aula(id_aluno);
CREATE INDEX IF NOT EXISTS idx_pagamento_matricula ON pagamento(id_matricula);
CREATE INDEX IF NOT EXISTS idx_pagamento_status_vencimento ON pagamento(status, vencimento);
CREATE INDEX IF NOT EXISTS idx_avaliacao_aluno_data ON avaliacao(id_aluno, realizada_em DESC);
CREATE INDEX IF NOT EXISTS idx_equipamento_modalidade ON equipamento(id_modalidade);

-- CPF, e-mail, nome de plano e demais colunas UNIQUE já ganham índices únicos via constraints.
-- Não foram criados índices duplicados para essas colunas.
ANALYZE aluno;
ANALYZE professor;
ANALYZE plano;
ANALYZE modalidade;
ANALYZE unidade;
ANALYZE matricula;
ANALYZE aula;
ANALYZE participacao_aula;
ANALYZE pagamento;
ANALYZE equipamento;
ANALYZE avaliacao;
