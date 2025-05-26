import { DataTypes } from 'sequelize';

export default (sequelize) => {
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
    timestamps: false
  });

  return User;
};