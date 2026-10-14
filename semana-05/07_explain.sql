-- Sprint 5 | Análise de plano de execução
SET search_path TO academia_sprint5, public;
ANALYZE;

-- Consulta 1: filtra pagamentos por status e vencimento; avalie idx_pagamento_status_vencimento.
EXPLAIN (ANALYZE, BUFFERS, VERBOSE)
SELECT id_pagamento, id_matricula, valor, vencimento
FROM pagamento
WHERE status='PENDENTE' AND vencimento >= CURRENT_DATE
ORDER BY vencimento;

-- Consulta 2: busca aulas de um professor em uma faixa de data; avalie idx_aula_professor_inicio.
EXPLAIN (ANALYZE, BUFFERS, VERBOSE)
SELECT id_aula, nome, inicio, status
FROM aula
WHERE id_professor=1
  AND inicio >= TIMESTAMPTZ '2026-10-01 00:00:00-03'
  AND inicio < TIMESTAMPTZ '2027-01-01 00:00:00-03'
ORDER BY inicio;

-- Importante: com apenas 15 linhas por tabela, o PostgreSQL pode preferir Seq Scan.
-- Isso não significa que o índice esteja errado; registre o plano real obtido na sua execução.
