-- Sprint 4 - Transações
-- Execute depois de 01_modelagem_fisica.sql e 02_indices.sql.
-- Os CPFs de exemplo devem ser exclusivos; rode este arquivo apenas uma vez,
-- ou troque os CPFs se os dados já tiverem sido inseridos.

-- TRANSAÇÃO 1: matricular um aluno em um plano existente.
BEGIN;
SAVEPOINT antes_da_matricula;

WITH novo_aluno AS (
    INSERT INTO aluno (nome, cpf, email)
    VALUES ('Aluno Sprint4 A', '44444444444', 'sprint4a@exemplo.com')
    RETURNING id_aluno, nome
),
nova_matricula AS (
    INSERT INTO matricula (id_aluno, id_plano, status)
    SELECT id_aluno, 1, 'ATIVA'
    FROM novo_aluno
    RETURNING id_matricula, id_aluno, id_plano
)
SELECT novo_aluno.id_aluno, novo_aluno.nome,
       nova_matricula.id_matricula, nova_matricula.id_plano
FROM novo_aluno
JOIN nova_matricula ON nova_matricula.id_aluno = novo_aluno.id_aluno;

-- Exemplo de uso do SAVEPOINT: desfaz somente as operações posteriores a ele.
-- Como o SAVEPOINT foi criado antes do CTE, o ROLLBACK TO desfaz a inserção.
ROLLBACK TO SAVEPOINT antes_da_matricula;

-- Reexecuta a operação válida, agora mantendo o resultado para confirmar a transação.
WITH novo_aluno AS (
    INSERT INTO aluno (nome, cpf, email)
    VALUES ('Aluno Sprint4 A', '44444444444', 'sprint4a@exemplo.com')
    RETURNING id_aluno, nome
),
nova_matricula AS (
    INSERT INTO matricula (id_aluno, id_plano, status)
    SELECT id_aluno, 1, 'ATIVA'
    FROM novo_aluno
    RETURNING id_matricula, id_aluno, id_plano
)
SELECT novo_aluno.id_aluno, novo_aluno.nome,
       nova_matricula.id_matricula, nova_matricula.id_plano
FROM novo_aluno
JOIN nova_matricula ON nova_matricula.id_aluno = novo_aluno.id_aluno;
COMMIT;

-- TRANSAÇÃO 2: cadastrar professor e sua aula.
BEGIN;
SAVEPOINT antes_da_aula;

WITH novo_professor AS (
    INSERT INTO professor (nome, especialidade)
    VALUES ('Professor Sprint4', 'Treinamento funcional')
    RETURNING id_professor, nome
),
nova_aula AS (
    INSERT INTO aula (nome, horario, id_professor)
    SELECT 'Aula Sprint4', TIME '19:00', id_professor
    FROM novo_professor
    RETURNING id_aula, nome, id_professor
)
SELECT novo_professor.id_professor, novo_professor.nome,
       nova_aula.id_aula, nova_aula.nome AS aula
FROM novo_professor
JOIN nova_aula ON nova_aula.id_professor = novo_professor.id_professor;
COMMIT;

-- Demonstração explícita de ROLLBACK total (esta inserção NÃO ficará salva).
BEGIN;
INSERT INTO aluno (nome, cpf, email)
VALUES ('Aluno para rollback', '99999999999', 'rollback@exemplo.com')
RETURNING id_aluno;
ROLLBACK;
