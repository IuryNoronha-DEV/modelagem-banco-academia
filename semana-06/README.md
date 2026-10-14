# Modelagem de Banco de Dados — Semana 06 (Sprint 6)

## Domínio

O projeto representa a gestão de uma academia. O PostgreSQL mantém o modelo relacional da Sprint 5 no schema `academia_sprint5`. A implementação MongoDB utiliza o banco `academia_nosql`, com as collections `alunos` e `matriculas`.

## Arquivos

- `08_backup.sh`: backup lógico PostgreSQL em formato customizado, tratamento de falhas e retenção de 30 dias.
- `09_mongodb_inserts.js`: criação dos documentos de alunos e matrículas.
- `10_mongodb_consultas.js`: filtros, projeções, ordenação, agregação e consulta entre collections.
- `11_mongodb_indices_explain.js`: índices MongoDB e planos de execução com `explain("executionStats")`.

## Backup PostgreSQL

O script utiliza `pg_dump -Fc`, gera um nome com data e hora, grava primeiro em arquivo temporário e só publica o arquivo final após a conclusão bem-sucedida. Se o comando falhar, o código de saída é diferente de zero e o arquivo temporário é removido. A limpeza remove arquivos de backup da mesma base com mais de 30 dias.

Variáveis de ambiente disponíveis:

- `DB_NAME`: nome da base; padrão `academia_sprint5`.
- `DB_HOST`: host PostgreSQL; padrão `localhost`.
- `DB_PORT`: porta; padrão `5432`.
- `DB_USER`: usuário PostgreSQL; padrão `postgres`.
- `BACKUP_DIR`: diretório de saída; padrão `$HOME/backups/postgresql`.
- `RETENTION_DAYS`: retenção em dias; padrão `30`.

Configure a autenticação sem gravar senhas no script. No Linux, pode-se utilizar o arquivo `~/.pgpass` com permissão `0600`, no formato `host:port:database:user:password`.

### Execução manual

```bash
chmod +x semana-06/08_backup.sh
DB_NAME=academia_sprint5 DB_USER=postgres ./semana-06/08_backup.sh
```

O usuário PostgreSQL precisa ter permissão para ler todos os objetos que serão exportados. O diretório de backup deve ter acesso restrito.

### Agendamento diário às 2h

Abra o crontab do usuário que executará o backup:

```bash
crontab -e
```

Adicione a linha abaixo, ajustando o caminho absoluto para o script e o diretório de log:

```cron
0 2 * * * DB_NAME=academia_sprint5 DB_USER=postgres BACKUP_DIR=/var/backups/academia /caminho/absoluto/semana-06/08_backup.sh >> /var/log/academia-backup.log 2>&1
```

O diretório de destino e o arquivo de log devem existir e permitir gravação ao usuário do cron.

## Teste de restauração

A restauração deve ocorrer em uma base de teste, nunca sobre a base de produção. O teste abaixo pressupõe acesso administrativo ao PostgreSQL e um arquivo `.dump` gerado pelo script.

```bash
createdb academia_teste
pg_restore --verbose --no-owner --dbname=academia_teste /caminho/do/backup.dump
```

Se o backup contém o schema `academia_sprint5`, a contagem pode ser conferida com:

```bash
psql -d academia_teste -c "SELECT 'aluno' AS tabela, COUNT(*) AS registros FROM academia_sprint5.aluno UNION ALL SELECT 'matricula', COUNT(*) FROM academia_sprint5.matricula UNION ALL SELECT 'aula', COUNT(*) FROM academia_sprint5.aula;"
```

Compare as contagens com a base de origem. Registre a data do teste, o arquivo restaurado e as contagens observadas. A restauração não é considerada validada até que o comando seja executado e os resultados reais sejam conferidos.

## Regra 3-2-1

A estratégia 3-2-1 mantém três cópias dos dados, em dois tipos de mídia ou sistemas de armazenamento, com uma cópia fora do ambiente principal. O script gera a cópia local; a rotina operacional deve copiar os arquivos para outro dispositivo ou armazenamento independente e manter uma cópia externa. Um único diretório no mesmo computador não atende sozinho à regra 3-2-1.

## Modelagem MongoDB

O banco `academia_nosql` possui duas collections relacionadas:

- `alunos`: cadastro, estado de atividade, objetivos, plano e contato de emergência.
- `matriculas`: data de início, situação, pagamentos embutidos e referência ao aluno pelo campo `alunoId`.

O campo `contatoEmergencia`, o plano e os objetivos são embutidos em `alunos` porque são consultados junto ao cadastro e possuem volume limitado. Os pagamentos são embutidos em `matriculas` por pertencerem ao ciclo de cobrança da matrícula e serem consultados junto dela neste exemplo. `matriculas.alunoId` referencia `alunos._id`, evitando duplicar o cadastro completo do aluno em cada matrícula. Essa referência permite consultas independentes e o uso de `$lookup` quando necessário.

Os scripts de inserção criam 10 documentos em cada collection. Para evitar duplicidade, execute `09_mongodb_inserts.js` em uma base vazia ou remova os documentos de demonstração antes de executá-lo novamente.

### Execução MongoDB

Execute os arquivos com `mongosh`, na ordem:

```bash
mongosh < semana-06/09_mongodb_inserts.js
mongosh < semana-06/10_mongodb_consultas.js
mongosh < semana-06/11_mongodb_indices_explain.js
```

As consultas demonstram `find`, filtros, projeção de campos, `sort`, agregação e `$lookup`. Os índices apoiam busca por e-mail, filtragem de alunos ativos, busca de matrícula por aluno/status e listagem de matrículas por situação e data. `explain("executionStats")` apresenta o plano executado e estatísticas reais, incluindo documentos examinados e retornados. A avaliação deve ser baseada na saída obtida no ambiente MongoDB.

## Índices e desempenho

Índices podem reduzir documentos examinados, mas consomem armazenamento e adicionam custo às escritas. O índice único de e-mail impede duplicidade; os índices compostos correspondem aos filtros e ordenações usados nas consultas de exemplo. O benefício deve ser conferido com `explain("executionStats")`, observando o estágio de execução e as métricas retornadas.

## PostgreSQL e MongoDB

PostgreSQL é adequado para matrículas, cobranças e relações que exigem integridade referencial, restrições e transações entre várias tabelas. O modelo relacional explicita as relações entre alunos, planos, matrículas e pagamentos.

MongoDB é adequado para dados de perfil com atributos variáveis e conjuntos de informações que costumam ser lidos juntos, como objetivos e contato de emergência. O embedding reduz a necessidade de consultas adicionais para dados que mudam e são acessados em conjunto. Referencing é útil quando os registros têm ciclo de vida próprio, são consultados separadamente ou podem ser associados a vários documentos. A escolha depende dos padrões de acesso, volume, consistência e requisitos da aplicação.

## Validação da entrega

Antes de considerar o backup e os índices validados, execute os scripts nos ambientes correspondentes, confira as contagens e registre as saídas reais de `pg_restore`, `psql` e `explain("executionStats")`. Os arquivos fornecem os comandos para realizar esses testes; os resultados dependem da execução no ambiente PostgreSQL e MongoDB utilizado.
