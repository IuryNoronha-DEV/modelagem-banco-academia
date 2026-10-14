-- Sprint 5 | Consultas SQL (JOIN, GROUP BY, subconsultas)
SET search_path TO academia_sprint5, public;

-- 1. Alunos e seus planos atuais (JOIN de 3 tabelas)
SELECT a.id_aluno, a.nome, p.nome AS plano, p.valor, m.status
FROM aluno a JOIN matricula m ON m.id_aluno=a.id_aluno JOIN plano p ON p.id_plano=m.id_plano
ORDER BY a.nome;

-- 2. Aulas com professor, modalidade e unidade
SELECT au.nome AS aula, pr.nome AS professor, mo.nome AS modalidade, un.nome AS unidade, au.inicio
FROM aula au JOIN professor pr ON pr.id_professor=au.id_professor
JOIN modalidade mo ON mo.id_modalidade=au.id_modalidade JOIN unidade un ON un.id_unidade=au.id_unidade
ORDER BY au.inicio;

-- 3. Quantidade de alunos por plano
SELECT p.nome, COUNT(m.id_matricula) AS total_matriculas
FROM plano p LEFT JOIN matricula m ON m.id_plano=p.id_plano GROUP BY p.id_plano, p.nome ORDER BY total_matriculas DESC;

-- 4. Receita paga por método de pagamento
SELECT metodo, SUM(valor) AS receita_total, COUNT(*) AS pagamentos
FROM pagamento WHERE status='PAGO' GROUP BY metodo ORDER BY receita_total DESC;

-- 5. Pagamentos pendentes ou atrasados
SELECT pg.id_pagamento, a.nome AS aluno, pg.valor, pg.vencimento, pg.status
FROM pagamento pg JOIN matricula m ON m.id_matricula=pg.id_matricula JOIN aluno a ON a.id_aluno=m.id_aluno
WHERE pg.status IN ('PENDENTE','ATRASADO') ORDER BY pg.vencimento;

-- 6. Professores e quantidade de aulas agendadas
SELECT pr.nome, COUNT(au.id_aula) AS aulas_agendadas
FROM professor pr LEFT JOIN aula au ON au.id_professor=pr.id_professor AND au.status='AGENDADA'
GROUP BY pr.id_professor, pr.nome ORDER BY aulas_agendadas DESC;

-- 7. Equipamentos por modalidade
SELECT mo.nome AS modalidade, COUNT(eq.id_equipamento) AS quantidade, SUM(eq.valor_aquisicao) AS valor_investido
FROM modalidade mo LEFT JOIN equipamento eq ON eq.id_modalidade=mo.id_modalidade
GROUP BY mo.id_modalidade, mo.nome ORDER BY quantidade DESC;

-- 8. Alunos com nota de avaliação acima da média geral (subconsulta)
SELECT a.nome, av.nota, av.realizada_em FROM avaliacao av JOIN aluno a ON a.id_aluno=av.id_aluno
WHERE av.nota > (SELECT AVG(nota) FROM avaliacao) ORDER BY av.nota DESC;

-- 9. Planos com valor acima da média (subconsulta)
SELECT nome, valor FROM plano WHERE valor > (SELECT AVG(valor) FROM plano) ORDER BY valor DESC;

-- 10. Alunos que têm pelo menos uma participação com presença (EXISTS)
SELECT a.id_aluno, a.nome FROM aluno a
WHERE EXISTS (SELECT 1 FROM participacao_aula pa WHERE pa.id_aluno=a.id_aluno AND pa.presenca=TRUE)
ORDER BY a.nome;

-- 11. Taxa de presença por aula (GROUP BY)
SELECT au.nome, COUNT(pa.id_participacao) AS inscritos,
       COUNT(*) FILTER (WHERE pa.presenca) AS presentes,
       ROUND(100.0*COUNT(*) FILTER (WHERE pa.presenca)/NULLIF(COUNT(pa.id_participacao),0),2) AS percentual_presenca
FROM aula au LEFT JOIN participacao_aula pa ON pa.id_aula=au.id_aula
GROUP BY au.id_aula, au.nome ORDER BY percentual_presenca DESC NULLS LAST;

-- 12. Últimas avaliações por aluno
SELECT a.nome, av.realizada_em, av.peso_kg, av.altura_m, av.nota
FROM avaliacao av JOIN aluno a ON a.id_aluno=av.id_aluno
WHERE av.realizada_em = (SELECT MAX(av2.realizada_em) FROM avaliacao av2 WHERE av2.id_aluno=av.id_aluno)
ORDER BY a.nome;
