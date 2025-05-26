import { fileURLToPath } from 'url';
import { dirname } from 'path';
import path from 'path';
import fs from 'fs';
import dotenv from 'dotenv';
import express from 'express';
import cors from 'cors';
import bodyParser from 'body-parser';
import { Sequelize } from 'sequelize';
import authRoutes from './routes/auth.js';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

// Configuração do .env
let envPath = path.resolve(__dirname, '.env');
if (!fs.existsSync(envPath)) {
  envPath = path.resolve(__dirname, '../.env');
}
dotenv.config({ path: envPath });

console.log('Carregando .env de:', envPath);

const app = express();

// Verificação das variáveis de ambiente
const requiredEnvVars = ['DB_NAME', 'DB_USER', 'DB_PASSWORD', 'DB_HOST'];
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

// Conexão com MySQL
const sequelize = new Sequelize(
  process.env.DB_NAME,
  process.env.DB_USER,
  process.env.DB_PASSWORD,
  {
    host: process.env.DB_HOST,
    dialect: 'mysql',
    logging: false
  }
);

async function startServer() {
  try {
    await sequelize.authenticate();
    console.log('Conectado ao MySQL com sucesso!');
    
    // Sincroniza modelos (cria tabelas se não existirem)
    await sequelize.sync({ alter: true });
    
    const PORT = process.env.PORT || 5000;
    app.listen(PORT, () => console.log(`Servidor rodando na porta ${PORT}`));
  } catch (err) {
    console.error('Erro ao conectar ao MySQL:', err);
    process.exit(1);
  }
}

startServer().catch(console.error);

// Tratamento de encerramento
process.on('SIGINT', async () => {
  await sequelize.close();
  console.log('Conexão com MySQL fechada');
  process.exit();
});