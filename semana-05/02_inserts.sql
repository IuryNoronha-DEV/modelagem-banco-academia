-- Sprint 5 | Carga de dados de demonstração
-- Cada tabela recebe 15 registros. Execute depois de 01_ddl.sql.
SET search_path TO academia_sprint5, public;

INSERT INTO aluno (nome, cpf, email, telefone, data_nascimento, ativo)
SELECT 'Aluno ' || lpad(i::text, 2, '0'), lpad((10000000000+i)::text,11,'0'), 'aluno'||i||'@exemplo.com', '(98) 9'||lpad((80000000+i)::text,8,'0'), DATE '1985-01-01' + (i*365/2), (i % 10 <> 0)
FROM generate_series(1,15) AS g(i);

INSERT INTO professor (nome, cpf, email, especialidade, ativo, contratado_em)
SELECT 'Professor '||lpad(i::text,2,'0'), lpad((20000000000+i)::text,11,'0'), 'professor'||i||'@exemplo.com', (ARRAY['Musculação','Pilates','Funcional','Yoga','Natação'])[ ((i-1)%5)+1 ], TRUE, DATE '2020-01-01' + i*20
FROM generate_series(1,15) AS g(i);

INSERT INTO plano (nome, valor, duracao_meses, permite_aulas_coletivas, ativo)
SELECT 'Plano '||lpad(i::text,2,'0'), (79.90 + i*10)::NUMERIC(10,2), ((i-1)%12)+1, (i%4<>0), TRUE
FROM generate_series(1,15) AS g(i);

INSERT INTO modalidade (nome, descricao, capacidade, ativa)
SELECT (ARRAY['Musculação','Pilates','Funcional','Yoga','Spinning','Dança','Boxe','Alongamento','Cross training','Zumba','Natação','Corrida','Mobilidade','Luta','Circuito'])[i], 'Modalidade oferecida pela academia: '||(ARRAY['Musculação','Pilates','Funcional','Yoga','Spinning','Dança','Boxe','Alongamento','Cross training','Zumba','Natação','Corrida','Mobilidade','Luta','Circuito'])[i], 10 + (i%16), TRUE
FROM generate_series(1,15) AS g(i);

INSERT INTO unidade (nome, endereco, cidade, ativa)
SELECT 'Unidade '||lpad(i::text,2,'0'), 'Rua de Exemplo, '||(100+i), (ARRAY['São Luís','São José de Ribamar','Paço do Lumiar'])[((i-1)%3)+1], TRUE
FROM generate_series(1,15) AS g(i);

INSERT INTO matricula (id_aluno, id_plano, data_inicio, status)
SELECT i, i, DATE '2026-01-01' + i*3, CASE WHEN i%7=0 THEN 'CANCELADA' ELSE 'ATIVA' END
FROM generate_series(1,15) AS g(i);

INSERT INTO aula (nome, id_professor, id_modalidade, id_unidade, inicio, duracao_minutos, vagas, status)
SELECT 'Aula '||lpad(i::text,2,'0'), i, i, i, TIMESTAMPTZ '2026-11-01 08:00:00-03' + (i-1)*INTERVAL '1 day', 45 + (i%4)*15, 10+(i%11), CASE WHEN i%6=0 THEN 'CANCELADA' ELSE 'AGENDADA' END
FROM generate_series(1,15) AS g(i);

INSERT INTO participacao_aula (id_aula, id_aluno, inscrito_em, presenca)
SELECT i, i, TIMESTAMPTZ '2026-10-01 10:00:00-03' + i*INTERVAL '1 hour', (i%3<>0)
FROM generate_series(1,15) AS g(i);

INSERT INTO pagamento (id_matricula, valor, vencimento, pago_em, metodo, status, referencia)
SELECT i, (79.90+i*10)::NUMERIC(10,2), DATE '2026-10-05'+i, CASE WHEN i%4=0 THEN NULL ELSE TIMESTAMPTZ '2026-10-01 12:00:00-03'+i*INTERVAL '1 hour' END,
       (ARRAY['PIX','CREDITO','DEBITO','BOLETO','DINHEIRO'])[((i-1)%5)+1], CASE WHEN i%4=0 THEN 'PENDENTE' ELSE 'PAGO' END, 'PAG-S5-'||lpad(i::text,4,'0')
FROM generate_series(1,15) AS g(i);

INSERT INTO equipamento (nome, numero_patrimonio, id_modalidade, data_aquisicao, valor_aquisicao, em_uso, observacoes)
SELECT (ARRAY['Esteira','Bicicleta ergométrica','Halteres','Colchonete','Barra','Anilha','Bola suíça','Kettlebell','Corda','Banco','Elíptico','Remo ergométrico','Step','Saco de pancada','Rolo de liberação'])[i], 'PAT-'||lpad(i::text,5,'0'), i, DATE '2023-01-01'+i*25, (150+i*75)::NUMERIC(12,2), TRUE, 'Equipamento de demonstração nº '||i
FROM generate_series(1,15) AS g(i);

INSERT INTO avaliacao (id_aluno, id_professor, realizada_em, peso_kg, altura_m, nota, observacao)
SELECT i, i, DATE '2026-09-01'+i, (55+i*2)::NUMERIC(5,2), (1.50+(i%40)*0.01)::NUMERIC(3,2), ((i-1)%5)+1, 'Avaliação inicial do aluno '||i
FROM generate_series(1,15) AS g(i);

-- Verificação da quantidade de registros: cada tabela deve retornar 15.
SELECT 'aluno' AS tabela, COUNT(*) AS registros FROM aluno
UNION ALL SELECT 'professor', COUNT(*) FROM professor
UNION ALL SELECT 'plano', COUNT(*) FROM plano
UNION ALL SELECT 'modalidade', COUNT(*) FROM modalidade
UNION ALL SELECT 'unidade', COUNT(*) FROM unidade
UNION ALL SELECT 'matricula', COUNT(*) FROM matricula
UNION ALL SELECT 'aula', COUNT(*) FROM aula
UNION ALL SELECT 'participacao_aula', COUNT(*) FROM participacao_aula
UNION ALL SELECT 'pagamento', COUNT(*) FROM pagamento
UNION ALL SELECT 'equipamento', COUNT(*) FROM equipamento
UNION ALL SELECT 'avaliacao', COUNT(*) FROM avaliacao
ORDER BY tabela;
