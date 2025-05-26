// Adicione no início do arquivo:
const { Sequelize } = require('sequelize');

// Substitua a conexão do MongoDB por:
const sequelize = new Sequelize(process.env.DB_NAME, process.env.DB_USER, process.env.DB_PASSWORD, {
  host: process.env.DB_HOST,
  dialect: 'mysql',
  logging: false // Desativa logs SQL no console
});

// Teste da conexão
async function testConnection() {
  try {
    await sequelize.authenticate();
    console.log('Conexão com MySQL estabelecida com sucesso!');
  } catch (error) {
    console.error('Erro ao conectar ao MySQL:', error);
    process.exit(1);
  }
}

// Chame esta função antes de startServer()
await testConnection();

// Disponibilize o sequelize para as rotas
app.locals.sequelize = sequelize;