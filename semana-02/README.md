# Entregável de Modelagem de Banco de Dados – Semana 02

## 1. Cenário escolhido

O cenário escolhido foi uma **Academia**.

O banco de dados tem como objetivo armazenar informações básicas sobre alunos, planos, professores e aulas oferecidas pela academia.

---

## 2. Entidades

Foram identificadas quatro entidades principais:

- Aluno
- Plano
- Professor
- Aula

Todas são consideradas entidades fortes, pois possuem uma chave primária própria.

Não foi identificada a necessidade de uma entidade fraca neste modelo simplificado.

---

## 3. Atributos

### Aluno

- `id_aluno` - INT - **PK**
- `nome` - VARCHAR(100) - NOT NULL
- `cpf` - VARCHAR(11) - UNIQUE
- `email` - VARCHAR(100)

### Plano

- `id_plano` - INT - **PK**
- `nome` - VARCHAR(50) - NOT NULL
- `valor` - DECIMAL(10,2) - NOT NULL

### Professor

- `id_professor` - INT - **PK**
- `nome` - VARCHAR(100) - NOT NULL
- `especialidade` - VARCHAR(100)

### Aula

- `id_aula` - INT - **PK**
- `nome` - VARCHAR(50) - NOT NULL
- `horario` - TIME - NOT NULL
- `id_professor` - INT - **FK**
- `id_plano` - INT - **FK**

---

## 4. Relacionamentos

### Professor e Aula

Um professor pode ministrar várias aulas.

Cada aula é ministrada por um professor.

**Cardinalidade: 1:N**

Professor (1) ---- (N) Aula

---

### Plano e Aula

Um plano pode estar associado a várias aulas.

Cada aula pertence a um plano.

**Cardinalidade: 1:N**

Plano (1) ---- (N) Aula

---

## 5. Diagrama Entidade-Relacionamento

```mermaid
erDiagram

    PROFESSOR ||--o{ AULA : ministra
    PLANO ||--o{ AULA : inclui

    ALUNO {
        INT id_aluno PK
        VARCHAR nome
        VARCHAR cpf UK
        VARCHAR email
    }

    PLANO {
        INT id_plano PK
        VARCHAR nome
        DECIMAL valor
    }

    PROFESSOR {
        INT id_professor PK
        VARCHAR nome
        VARCHAR especialidade
    }

    AULA {
        INT id_aula PK
        VARCHAR nome
        TIME horario
        INT id_professor FK
        INT id_plano FK
    }
