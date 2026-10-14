use("academia_nosql");

db.alunos.insertMany([
  {
    _id: ObjectId("670000000000000000000001"),
    nome: "Ana Souza",
    email: "ana.souza@example.com",
    ativo: true,
    plano: { nome: "Mensal", categoria: "Básico" },
    contatoEmergencia: { nome: "Marina Souza", telefone: "98990000001" },
    objetivos: ["condicionamento", "mobilidade"]
  },
  {
    _id: ObjectId("670000000000000000000002"),
    nome: "Bruno Lima",
    email: "bruno.lima@example.com",
    ativo: true,
    plano: { nome: "Trimestral", categoria: "Intermediário" },
    contatoEmergencia: { nome: "Paulo Lima", telefone: "98990000002" },
    objetivos: ["força"]
  },
  {
    _id: ObjectId("670000000000000000000003"),
    nome: "Carla Mendes",
    email: "carla.mendes@example.com",
    ativo: true,
    plano: { nome: "Anual", categoria: "Premium" },
    contatoEmergencia: { nome: "Lia Mendes", telefone: "98990000003" },
    objetivos: ["condicionamento", "força"]
  },
  {
    _id: ObjectId("670000000000000000000004"),
    nome: "Diego Costa",
    email: "diego.costa@example.com",
    ativo: false,
    plano: { nome: "Mensal", categoria: "Básico" },
    contatoEmergencia: { nome: "Rui Costa", telefone: "98990000004" },
    objetivos: ["mobilidade"]
  },
  {
    _id: ObjectId("670000000000000000000005"),
    nome: "Elisa Rocha",
    email: "elisa.rocha@example.com",
    ativo: true,
    plano: { nome: "Anual", categoria: "Premium" },
    contatoEmergencia: { nome: "Bia Rocha", telefone: "98990000005" },
    objetivos: ["força", "hipertrofia"]
  },
  {
    _id: ObjectId("670000000000000000000006"),
    nome: "Felipe Alves",
    email: "felipe.alves@example.com",
    ativo: true,
    plano: { nome: "Trimestral", categoria: "Intermediário" },
    contatoEmergencia: { nome: "Nina Alves", telefone: "98990000006" },
    objetivos: ["condicionamento"]
  },
  {
    _id: ObjectId("670000000000000000000007"),
    nome: "Giovana Reis",
    email: "giovana.reis@example.com",
    ativo: true,
    plano: { nome: "Mensal", categoria: "Básico" },
    contatoEmergencia: { nome: "Caio Reis", telefone: "98990000007" },
    objetivos: ["mobilidade", "condicionamento"]
  },
  {
    _id: ObjectId("670000000000000000000008"),
    nome: "Henrique Melo",
    email: "henrique.melo@example.com",
    ativo: false,
    plano: { nome: "Trimestral", categoria: "Intermediário" },
    contatoEmergencia: { nome: "Lara Melo", telefone: "98990000008" },
    objetivos: ["força"]
  },
  {
    _id: ObjectId("670000000000000000000009"),
    nome: "Isabela Nunes",
    email: "isabela.nunes@example.com",
    ativo: true,
    plano: { nome: "Anual", categoria: "Premium" },
    contatoEmergencia: { nome: "Mauro Nunes", telefone: "98990000009" },
    objetivos: ["hipertrofia"]
  },
  {
    _id: ObjectId("670000000000000000000010"),
    nome: "João Pedro",
    email: "joao.pedro@example.com",
    ativo: true,
    plano: { nome: "Mensal", categoria: "Básico" },
    contatoEmergencia: { nome: "Rosa Pedro", telefone: "98990000010" },
    objetivos: ["condicionamento", "mobilidade"]
  }
]);

db.matriculas.insertMany([
  {
    _id: ObjectId("680000000000000000000001"),
    alunoId: ObjectId("670000000000000000000001"),
    inicio: ISODate("2026-01-10T12:00:00Z"),
    status: "ATIVA",
    pagamentos: [{ mes: "2026-01", valor: 119.90, pago: true }]
  },
  {
    _id: ObjectId("680000000000000000000002"),
    alunoId: ObjectId("670000000000000000000002"),
    inicio: ISODate("2026-02-01T12:00:00Z"),
    status: "ATIVA",
    pagamentos: [{ mes: "2026-02", valor: 249.90, pago: true }]
  },
  {
    _id: ObjectId("680000000000000000000003"),
    alunoId: ObjectId("670000000000000000000003"),
    inicio: ISODate("2026-01-15T12:00:00Z"),
    status: "ATIVA",
    pagamentos: [{ mes: "2026-01", valor: 899.90, pago: true }]
  },
  {
    _id: ObjectId("680000000000000000000004"),
    alunoId: ObjectId("670000000000000000000004"),
    inicio: ISODate("2025-11-05T12:00:00Z"),
    status: "ENCERRADA",
    pagamentos: [{ mes: "2025-11", valor: 119.90, pago: true }]
  },
  {
    _id: ObjectId("680000000000000000000005"),
    alunoId: ObjectId("670000000000000000000005"),
    inicio: ISODate("2026-03-02T12:00:00Z"),
    status: "ATIVA",
    pagamentos: [{ mes: "2026-03", valor: 899.90, pago: true }]
  },
  {
    _id: ObjectId("680000000000000000000006"),
    alunoId: ObjectId("670000000000000000000006"),
    inicio: ISODate("2026-02-20T12:00:00Z"),
    status: "ATIVA",
    pagamentos: [{ mes: "2026-02", valor: 249.90, pago: false }]
  },
  {
    _id: ObjectId("680000000000000000000007"),
    alunoId: ObjectId("670000000000000000000007"),
    inicio: ISODate("2026-03-12T12:00:00Z"),
    status: "ATIVA",
    pagamentos: [{ mes: "2026-03", valor: 119.90, pago: true }]
  },
  {
    _id: ObjectId("680000000000000000000008"),
    alunoId: ObjectId("670000000000000000000008"),
    inicio: ISODate("2025-12-12T12:00:00Z"),
    status: "ENCERRADA",
    pagamentos: [{ mes: "2025-12", valor: 249.90, pago: true }]
  },
  {
    _id: ObjectId("680000000000000000000009"),
    alunoId: ObjectId("670000000000000000000009"),
    inicio: ISODate("2026-04-03T12:00:00Z"),
    status: "ATIVA",
    pagamentos: [{ mes: "2026-04", valor: 899.90, pago: false }]
  },
  {
    _id: ObjectId("680000000000000000000010"),
    alunoId: ObjectId("670000000000000000000010"),
    inicio: ISODate("2026-04-10T12:00:00Z"),
    status: "ATIVA",
    pagamentos: [{ mes: "2026-04", valor: 119.90, pago: true }]
  }
]);

print("Alunos inseridos: " + db.alunos.countDocuments());
print("Matrículas inseridas: " + db.matriculas.countDocuments());
