-- Rode após criar os índices. ANALYZE atualiza estatísticas do planejador.
ANALYZE aluno;
ANALYZE matricula;
ANALYZE plano;
ANALYZE aula;
ANALYZE professor;

-- Consulta 1: busca matrículas de um aluno específico.
EXPLAIN ANALYZE
SELECT m.id_matricula, m.status, m.criada_em, p.nome AS plano
FROM matricula AS m
JOIN plano AS p ON p.id_plano = m.id_plano
WHERE m.id_aluno = 1;

-- Consulta 2: aulas de um professor.
EXPLAIN ANALYZE
SELECT a.id_aula, a.nome, a.horario, p.nome AS professor
FROM aula AS a
JOIN professor AS p ON p.id_professor = a.id_professor
WHERE a.id_professor = 1;

-- Interpretação: observe se aparece Index Scan/Bitmap Index Scan nos índices
-- criados. Com poucas linhas, o PostgreSQL pode preferir Seq Scan por ser mais
-- barato; isso não significa que o índice esteja incorreto. A avaliação deve
-- considerar o plano real, o volume de dados e os custos estimados/medidos.
