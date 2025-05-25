const express = require('express');
const router = express.Router();
const User = require('../models/user');

// Login/Cadastro automático
router.post('/login', async (req, res) => {
  try {
    const { nome, telefone } = req.body;
    
    // Verifica se usuário existe
    let user = await User.findOne({ telefone });
    
    if (!user) {
      // Se não existe, cria um novo
      user = new User({ nome, telefone });
      await user.save();
    } else {
      // Atualiza o último acesso
      user.ultimoAcesso = Date.now();
      await user.save();
    }
    
    res.status(200).json({ 
      success: true,
      user: {
        id: user._id,
        nome: user.nome,
        telefone: user.telefone
      }
    });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
});

// Verificar sessão (para login automático)
router.get('/session/:telefone', async (req, res) => {
  try {
    const user = await User.findOne({ telefone: req.params.telefone });
    
    if (user) {
      res.status(200).json({ 
        success: true,
        user: {
          id: user._id,
          nome: user.nome,
          telefone: user.telefone
        }
      });
    } else {
      res.status(404).json({ success: false, message: 'Usuário não encontrado' });
    }
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
});

module.exports = router;