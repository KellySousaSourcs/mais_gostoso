const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');

const app = express();
app.use(cors());
app.use(express.json());

// 🔗 Conexão MongoDB
mongoose.connect('mongodb+srv://<usuario>:<senha>@cluster0.mongodb.net/maisgostoso');

// 🔥 Modelo de usuário
const UserSchema = new mongoose.Schema({
    nome: String,
    telefone: String,
    email: { type: String, unique: true },
    senha: String,
    imagem: String,
});

const User = mongoose.model('User', UserSchema);

// 🛠️ Registro
app.post('/register', async (req, res) => {
    const { nome, telefone, email, senha, imagem } = req.body;

    const senhaHash = await bcrypt.hash(senha, 10);

    try {
        const user = await User.create({
            nome,
            telefone,
            email,
            senha: senhaHash,
            imagem,
        });
        res.json(user);
    } catch (e) {
        res.status(400).json({ error: 'Usuário já existe!' });
    }
});

// 🔑 Login
app.post('/login', async (req, res) => {
    const { email, senha } = req.body;

    const user = await User.findOne({ email });

    if (!user) {
        return res.status(404).json({ error: 'Usuário não encontrado' });
    }

    const isSenhaValida = await bcrypt.compare(senha, user.senha);

    if (!isSenhaValida) {
        return res.status(400).json({ error: 'Senha incorreta' });
    }

    const token = jwt.sign({ id: user._id }, 'secreto123');

    res.json({ token, user });
});

// 🔐 Middleware de autenticação
const auth = (req, res, next) => {
    const token = req.headers['authorization'];

    if (!token) return res.status(401).json({ error: 'Token não fornecido' });

    try {
        const decoded = jwt.verify(token, 'secreto123');
        req.userId = decoded.id;
        next();
    } catch (e) {
        res.status(401).json({ error: 'Token inválido' });
    }
};

// 👤 Buscar dados do usuário autenticado
app.get('/profile', auth, async (req, res) => {
    const user = await User.findById(req.userId);
    res.json(user);
});

// 🚀 Start
app.listen(3000, () => console.log('Servidor rodando na porta 3000'));
