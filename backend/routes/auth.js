import express from 'express';
const router = express.Router();

router.post("/login", async (req, res) => {
  try {
    const { nome, telefone } = req.body;
    const { User } = req.app.locals.sequelize.models;

    const [user, created] = await User.findOrCreate({
      where: { telefone },
      defaults: { nome, ultimoAcesso: new Date() }
    });

    if (!created) {
      await User.update(
        { ultimoAcesso: new Date() },
        { where: { id: user.id } }
      );
    }

    res.status(200).json({
      success: true,
      user: {
        id: user.id,
        nome: user.nome,
        telefone: user.telefone
      }
    });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
});

router.get("/session/:telefone", async (req, res) => {
  try {
    const { User } = req.app.locals.sequelize.models;
    const user = await User.findOne({ 
      where: { telefone: req.params.telefone } 
    });

    if (user) {
      res.status(200).json({
        success: true,
        user: {
          id: user.id,
          nome: user.nome,
          telefone: user.telefone
        }
      });
    } else {
      res.status(404).json({ success: false, message: "Usuário não encontrado" });
    }
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
});

export default router;