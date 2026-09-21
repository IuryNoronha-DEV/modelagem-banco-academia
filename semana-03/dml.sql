INSERT INTO aluno (id_aluno, nome, cpf, email)
VALUES
(1, 'Ana Silva', '11111111111', 'ana@email.com'),
(2, 'Bruno Santos', '22222222222', 'bruno@email.com'),
(3, 'Carla Oliveira', '33333333333', 'carla@email.com');


-- ==========================================
-- INSERTS NA TABELA PLANO
-- ==========================================

INSERT INTO plano (id_plano, nome, valor)
VALUES
(1, 'Plano Básico', 99.90),
(2, 'Plano Intermediário', 149.90),
(3, 'Plano Premium', 199.90);


-- ==========================================
-- INSERTS NA TABELA PROFESSOR
-- ==========================================

INSERT INTO professor (id_professor, nome, especialidade)
VALUES
(1, 'Carlos Mendes', 'Musculação'),
(2, 'Juliana Costa', 'Pilates'),
(3, 'Marcos Lima', 'Funcional');


-- ==========================================
-- INSERTS NA TABELA MATRICULA
-- ==========================================

INSERT INTO matricula (id_matricula, id_aluno, id_plano)
VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3);


-- ==========================================
-- INSERTS NA TABELA AULA
-- ==========================================

INSERT INTO aula (id_aula, nome, horario, id_professor)
VALUES
(1, 'Musculação', '08:00:00', 1),
(2, 'Pilates', '10:00:00', 2),
(3, 'Funcional', '18:00:00', 3);


-- ==========================================
-- SELECT COM JOIN 1
-- ALUNOS E SEUS PLANOS
-- ==========================================

SELECT
    aluno.nome AS aluno,
    plano.nome AS plano,
    plano.valor
FROM aluno
JOIN matricula
    ON aluno.id_aluno = matricula.id_aluno
JOIN plano
    ON matricula.id_plano = plano.id_plano;


-- ==========================================
-- SELECT COM JOIN 2
-- AULAS E SEUS PROFESSORES
-- ==========================================

SELECT
    aula.nome AS aula,
    aula.horario,
    professor.nome AS professor,
    professor.especialidade
FROM aula
JOIN professor
    ON aula.id_professor = professor.id_professor;
