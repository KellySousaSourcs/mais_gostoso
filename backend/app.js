const path = require('path');
const envPath = path.resolve(__dirname, '.env'); // Tenta na pasta backend
if (!require('fs').existsSync(envPath)) {
  envPath = path.resolve(__dirname, '../.env'); // Tenta na raiz do projeto
}
require('dotenv').config({ path: envPath });

// Adicione ESTE debug temporário:
console.log('Carregando .env de:', envPath);
console.log('Conteúdo de MONGODB_URI:', process.env.MONGODB_URI);

const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const { MongoClient, ServerApiVersion } = require('mongodb');
const authRoutes = require('./routes/auth');

const app = express();

// Verificação das variáveis de ambiente
const requiredEnvVars = ['MONGODB_URI', 'DB_NAME'];
for (const envVar of requiredEnvVars) {
  if (!process.env[envVar]) {
    console.error(`Erro: Variável de ambiente ${envVar} não está definida`);
    process.exit(1);
  }
}

// Middleware
app.use(cors());
app.use(bodyParser.json());

// Rotas
app.use('/api/auth', authRoutes);

// Conexão com MongoDB
const client = new MongoClient(process.env.MONGODB_URI, {
  serverApi: {
    version: ServerApiVersion.v1,
    strict: true,
    deprecationErrors: true,
  }
});

async function startServer() {
  try {
    await client.connect();
    console.log('Conectado ao MongoDB com sucesso!');
    
    app.locals.db = client.db(process.env.DB_NAME);
    
    const PORT = process.env.PORT || 5000;
    app.listen(PORT, () => console.log(`Servidor rodando na porta ${PORT}`));
  } catch (err) {
    console.error('Erro ao conectar ao MongoDB:', err);
    process.exit(1);
  }
}

startServer().catch(console.error);

process.on('SIGINT', async () => {
  await client.close();
  console.log('Conexão com MongoDB fechada');
  process.exit();
});