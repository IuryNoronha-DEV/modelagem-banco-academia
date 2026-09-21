# Modelagem de Banco de Dados - Academia

## 1. Cenário

O sistema tem como objetivo armazenar informações básicas de uma academia, como alunos, professores e planos disponíveis.

## 2. Entidades

### Aluno

* **id_aluno (PK)**: identificador único do aluno
* nome
* cpf
* email
* telefone

### Professor

* **id_professor (PK)**: identificador único do professor
* nome
* cpf
* email

### Plano

* **id_plano (PK)**: identificador único do plano
* nome
* valor
* duração

## 3. Relacionamentos

### Aluno e Plano

Um aluno pode contratar apenas um plano, enquanto um plano pode ser contratado por vários alunos.

**Cardinalidade: 1:N**

```text
Plano (1) -------- (N) Aluno
```

### Professor e Aluno

Um professor pode acompanhar vários alunos, enquanto um aluno pode ser acompanhado por um professor.

**Cardinalidade: 1:N**

```text
Professor (1) -------- (N) Aluno
```

## 4. Modelo Conceitual

```text
+----------------+          +----------------+
|     PLANO      |          |   PROFESSOR    |
+----------------+          +----------------+
| PK id_plano    |          | PK id_professor|
| nome           |          | nome           |
| valor          |          | cpf            |
| duração        |          | email          |
+-------+--------+          +-------+--------+
        |                           |
        | 1:N                       | 1:N
        |                           |
        +-----------+---------------+
                    |
                    |
             +------v-------+
             |    ALUNO     |
             +--------------+
             | PK id_aluno  |
             | nome         |
             | cpf          |
             | email        |
             | telefone     |
             +--------------+
```

## 5. Resumo

| Relacionamento    | Cardinalidade |
| ----------------- | ------------- |
| Plano - Aluno     | 1:N           |
| Professor - Aluno | 1:N           |
