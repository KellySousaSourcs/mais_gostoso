const { DataTypes } = require('sequelize');

module.exports = (sequelize) => {
  const User = sequelize.define('User', {
    nome: {
      type: DataTypes.STRING,
      allowNull: false,
      trim: true
    },
    telefone: {
      type: DataTypes.STRING,
      allowNull: false,
      unique: true,
      trim: true
    },
    ultimoAcesso: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW
    }
  }, {
    tableName: 'users',
    timestamps: false // Desativa created_at e updated_at
  });

  return User;
};