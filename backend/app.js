const express = require('express')
const cors = require('cors')
const pool = require("./db.js")
const crypto = require('crypto')

const app = express()
const porta = 3000

app.use(cors())
app.use(express.json())

app.listen(porta, () => {
    console.log(`Servidor rodando em: http://localhost:${porta}`)
})

// ================= CADASTRO ======================
//Mostrar
app.get('/mostrar', async (req, res) => {
    try {
        const [resultado] = await pool.query(`select * from cadastro`)
        res.send(resultado)
    } catch (error) {
        console.log(error)
        res.status(500).json("erro no servidor")
    }
})
//inserir 
app.post('/inserir', async (req, res) => {
    try {
        const { nome, email, cep, cpf, telefone, data_nascimento, senha } = req.body
        const hash = crypto.createHash("sha256").update(senha.trim()).digest("base64")
        const sql = `INSERT INTO cadastro (nome, email, cep, cpf, telefone, data_nascimento, senha) VALUES (?, ?, ?, ?, ?, ?, ?)`
        const [resultado] = await pool.query(sql, [nome, email, cep, cpf, telefone, data_nascimento, hash])
        if (resultado.affectedRows === 1) {
            res.json({ resposta: "Cadastro efetuado com sucesso!" })
        } else {
            res.json({ resposta: "Erro ao fazer cadastro!" })
        }
    } catch (error) {
        console.log(error)
        res.status(500).json("erro no servidor")
    }
})
//atualizar
app.put('/atualizar', async (req, res) => {
    try {
        const { nome, email, cep, cpf, telefone, data_nascimento, senha, id_usuario } = req.body
        const hash = crypto.createHash("sha256").update(senha.trim()).digest("base64")
        const sql = `UPDATE cadastro SET nome = ?, email = ?, cep = ?, cpf = ?, telefone = ?, data_nascimento = ?, senha = ? WHERE id_usuario = ?`
        const [resultado] = await pool.query(sql, [nome, email, cep, cpf, telefone, data_nascimento, hash, id_usuario])
        if (resultado.affectedRows === 1) {
            res.json({ resposta: "Cadastro atualizado com sucesso!" })
        } else {
            res.json({ resposta: "Erro ao atualizar cadastro!" })
        }

    } catch (error) {
        console.log(error)
        res.status(500).json("erro no servidor")
    }

})
//delete
app.delete('/deletar', async (req, res) => {
    try {
        const { id_usuario } = req.body
        const [resultado] = await pool.query(`DELETE FROM cadastro WHERE id_usuario = ${id_usuario}`)
        if (resultado.affectedRows === 1) {
            res.json({ resposta: "Cadastro deletado com sucesso!" })
        } else {
            res.json({ resposta: "Erro ao deletar cadastro!" })
        }
    } catch (error) {
        console.log(error)
    }

})