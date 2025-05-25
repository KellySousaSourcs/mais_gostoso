const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
  nome: {
    type: String,
    required: true,
    trim: true
  },
  telefone: {
    type: String,
    required: true,
    unique: true,
    trim: true
  },
  ultimoAcesso: {
    type: Date,
    default: Date.now
  }
});

module.exports = mongoose.model('User', userSchema);