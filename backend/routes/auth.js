const express = require("express");
const router = express.Router();
const { ObjectId } = require("mongodb");

// Login/Cadastro automático
router.post("/login", async (req, res) => {
  try {
    const { nome, telefone } = req.body;
    const db = req.app.locals.db;
    const usersCollection = db.collection("users");

    // Verifica se usuário existe
    let user = await usersCollection.findOne({ telefone });

    if (!user) {
      // Se não existe, cria um novo
      const newUser = {
        nome,
        telefone,
        ultimoAcesso: new Date(),
      };

      const result = await usersCollection.insertOne(newUser);
      user = await usersCollection.findOne({ _id: result.insertedId });
    } else {
      // Atualiza o último acesso
      await usersCollection.updateOne(
        { _id: user._id },
        { $set: { ultimoAcesso: new Date() } }
      );
      user = await usersCollection.findOne({ _id: user._id });
    }

    res.status(200).json({
      success: true,
      user: {
        id: user._id,
        nome: user.nome,
        telefone: user.telefone,
      },
    });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
});

// Verificar sessão (para login automático)
router.get("/session/:telefone", async (req, res) => {
  try {
    const db = req.app.locals.db;
    const usersCollection = db.collection("users");

    const user = await usersCollection.findOne({
      telefone: req.params.telefone,
    });

    if (user) {
      res.status(200).json({
        success: true,
        user: {
          id: user._id,
          nome: user.nome,
          telefone: user.telefone,
        },
      });
    } else {
      res
        .status(404)
        .json({ success: false, message: "Usuário não encontrado" });
    }
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
});

module.exports = router;
