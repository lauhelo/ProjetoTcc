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

// ================= CADASTRO USUÁRIOS ==============================================================================================================
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

// ================= LOGIN ================================================================================================
app.post('/login', async (req, res) => {
    try {
        const { email, senha } = req.body

        const hash = crypto.createHash("sha256")
            .update(senha.trim())
            .digest("base64")

        const sql = `
        SELECT * FROM cadastro 
        WHERE email = ? AND senha = ?
        `

        const [resultado] = await pool.query(sql, [email, hash])

        if (resultado.length > 0) {
            res.json({ usuario: resultado })
        } else {
            res.json({ usuario: null })
        }

    } catch (error) {
        console.log(error)
        res.status(500).json(error.message)
    }
})

// ================= CADASTRO ANIMAIS ============================================================================================================

// Mostrar
app.get('/mostrarAnimal', async (req, res) => {
    try {
        const [resultado] = await pool.query(`SELECT * FROM animais`)
        res.send(resultado)
    } catch (error) {
        console.log(error)
        res.status(500).json("erro no servidor")
    }
})

// Inserir
app.post('/inserirAnimal', async (req, res) => {
    try {
        const { id_ong, nome, especie, raca, porte, idade, sexo, descricao, status, imagem, ong, cidade, estado } = req.body
        const sql = ` INSERT INTO animais (id_ong, nome, especie, raca, porte, idade, sexo, descricao, status, imagem, ong, cidade, estado)  
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`
        const [resultado] = await pool.query(sql, [ id_ong, nome, especie, raca, porte, idade, sexo, descricao, status, imagem, ong, cidade, estado])
        if (resultado.affectedRows === 1) {
            res.json({ resposta: "Animal cadastrado com sucesso!" })
        } else {
            res.json({ resposta: "Erro ao cadastrar animal!" })
        }
    } catch (error) {
        console.log(error)
        res.status(500).json("erro no servidor")
    }
})

// Atualizar
app.put('/atualizarAnimal', async (req, res) => {
    try {
        const {id_animal, id_ong, nome, especie, raca, porte, idade, sexo, descricao, status, imagem, ong, cidade, estado} = req.body
        const sql = `UPDATE animais SET id_ong = ?, nome = ?, especie = ?, raca = ?, porte = ?, idade = ?, sexo = ?, descricao = ?,
         status = ?, imagem = ?, ong = ?, cidade = ?, estado = ? WHERE id_animal = ?`

        const [resultado] = await pool.query(sql, [
            id_ong, nome, especie, raca, porte, idade, sexo, descricao, status, imagem, ong, cidade, estado, id_animal
        ])
        if (resultado.affectedRows === 1) {
            res.json({ resposta: "Animal atualizado com sucesso!" })
        } else {
            res.json({ resposta: "Erro ao atualizar animal!" })
        }

    } catch (error) {
        console.log(error)
        res.status(500).json("erro no servidor")
    }
})

// Deletar
app.delete('/deletarAnimal', async (req, res) => {
    try {
        const { id_animal } = req.body
        const [resultado] = await pool.query(`DELETE FROM animais WHERE id_animal = ?`, [id_animal])
        if (resultado.affectedRows === 1) {
            res.json({ resposta: "Animal deletado com sucesso!" })
        } else {
            res.json({ resposta: "Erro ao deletar animal!" })
        }
    } catch (error) {
        console.log(error)
    }
})


// ================= CADASTRO ONG ===================================================================================================================================

// Mostrar
app.get('/mostrarOng', async (req, res) => {
    try {
        const [resultado] = await pool.query(`SELECT * FROM ong`)
        res.send(resultado)
    } catch (error) {
        console.log(error)
        res.status(500).json("erro no servidor")
    }
})

// Inserir
app.post('/inserirOng', async (req, res) => {
    try {
        const { nome, telefone, endereco, cidade, estado, pix, trabalho_ofe } = req.body
        const sql = ` INSERT INTO ong (nome, telefone, endereco, cidade, estado, pix, trabalho_ofe) VALUES (?, ?, ?, ?, ?, ?, ?)`
        const [resultado] = await pool.query(sql, [
            nome, telefone, endereco, cidade, estado, pix, trabalho_ofe
        ])
        if (resultado.affectedRows === 1) {
            res.json({ resposta: "ONG cadastrada com sucesso!" })
        } else {
            res.json({ resposta: "Erro ao cadastrar ONG!" })
        }
    } catch (error) {
        console.log(error)
        res.status(500).json("erro no servidor")
    }
})

// Atualizar
app.put('/atualizarOng', async (req, res) => {
    try {
        const { id_ong, nome, telefone, endereco, cidade, estado, pix, trabalho_ofe } = req.body
        const sql = ` UPDATE ong SET nome = ?, telefone = ?, endereco = ?, cidade = ?, estado = ?, pix = ?, trabalho_ofe = ? WHERE id_ong = ?`

        const [resultado] = await pool.query(sql, [
            nome, telefone, endereco, cidade, estado, pix, trabalho_ofe, id_ong
        ])
        if (resultado.affectedRows === 1) {
            res.json({ resposta: "ONG atualizada com sucesso!" })
        } else {
            res.json({ resposta: "Erro ao atualizar ONG!" })
        }
    } catch (error) {
        console.log(error)
        res.status(500).json("erro no servidor")
    }
})

// Deletar
app.delete('/deletarOng', async (req, res) => {
    try {
        const { id_ong } = req.body
        const [resultado] = await pool.query(`DELETE FROM ong WHERE id_ong = ?`, [id_ong]
        )

        if (resultado.affectedRows === 1) {
            res.json({ resposta: "ONG deletada com sucesso!" })
        } else {
            res.json({ resposta: "Erro ao deletar ONG!" })
        }
    } catch (error) {
        console.log(error)
    }
})


// ================= CADASTRO DICAS ===================================================================================

// Mostrar
app.get('/mostrarDicas', async (req, res) => {
    try {
        const [resultado] = await pool.query(`SELECT * FROM dicas`)
        res.send(resultado)
    } catch (error) {
        console.log(error)
        res.status(500).json(error.message)
    }
})

// Inserir
app.post('/inserirDica', async (req, res) => {
    try {
        const { id_usuario, titulo, conteudo, categoria, imagem, data_publicacao } = req.body

        const sql = `INSERT INTO dicas (id_usuario, titulo, conteudo, categoria, imagem, data_publicacao) VALUES (?, ?, ?, ?, ?, ?)`

        const [resultado] = await pool.query(sql, [id_usuario, titulo, conteudo, categoria, imagem, data_publicacao])

        if (resultado.affectedRows === 1) {
            res.json({ resposta: "Dica cadastrada com sucesso!" })
        } else {
            res.json({ resposta: "Erro ao cadastrar dica!" })
        }

    } catch (error) {
        console.log(error)
        res.status(500).json(error.message)
    }
})

// Atualizar
app.put('/atualizarDica', async (req, res) => {
    try {
        const { id_dica, id_usuario, titulo, conteudo, categoria, imagem, data_publicacao } = req.body

        const sql = `UPDATE dicas SET id_usuario = ?, titulo = ?, conteudo = ?, categoria = ?, imagem = ?, data_publicacao = ? WHERE id_dica = ?`
        const [resultado] = await pool.query(sql, [id_usuario, titulo, conteudo, categoria, imagem, data_publicacao, id_dica])
        if (resultado.affectedRows === 1) {
            res.json({ resposta: "Dica atualizada com sucesso!" })
        } else {
            res.json({ resposta: "Erro ao atualizar dica!" })
        }
    } catch (error) {
        console.log(error)
        res.status(500).json(error.message)
    }
})

app.delete('/deletarAnimal', async (req, res) => {
    try {
        const { id_animal } = req.body
        const [resultado] = await pool.query(`DELETE FROM animais WHERE id_animal = ?`,[id_animal])
        if (resultado.affectedRows === 1) {
            res.json({ resposta: "Animal deletado com sucesso!" })
        } else {
            res.json({ resposta: "Erro ao deletar animal!" })
        }

    } catch (error) {
        console.log(error)
    }
})

// ================= DOACAO =========================================================================================================================================

// Mostrar
app.get('/mostrarDoacao', async (req, res) => {
    try {
        const [resultado] = await pool.query(`SELECT * FROM doacao`)
        res.send(resultado)
    } catch (error) {
        console.log(error)
        res.status(500).json(error.message)
    }
})

// Inserir
app.post('/inserirDoacao', async (req, res) => {
    try {
        const { id_ong, tipo_doacao, descricao, data_cadastro } = req.body
        const sql = ` INSERT INTO doacao (id_ong, tipo_doacao, descricao, data_cadastro) VALUES (?, ?, ?, ?) `

        const [resultado] = await pool.query(sql, [
            id_ong, tipo_doacao, descricao, data_cadastro
        ])

        if (resultado.affectedRows === 1) {
            res.json({ resposta: "Doação cadastrada com sucesso!" })
        } else {
            res.json({ resposta: "Erro ao cadastrar doação!" })
        }

    } catch (error) {
        console.log(error)
        res.status(500).json(error.message)
    }
})

// Atualizar
app.put('/atualizarDoacao', async (req, res) => {
    try {
        const { id_doacao, id_ong, tipo_doacao, descricao, data_cadastro } = req.body

        const sql = ` UPDATE doacao SET id_ong = ?, tipo_doacao = ?, descricao = ?, data_cadastro = ? WHERE id_doacao = ? `

        const [resultado] = await pool.query(sql, [
            id_ong, tipo_doacao, descricao, data_cadastro, id_doacao
        ])

        if (resultado.affectedRows === 1) {
            res.json({ resposta: "Doação atualizada com sucesso!" })
        } else {
            res.json({ resposta: "Erro ao atualizar doação!" })
        }

    } catch (error) {
        console.log(error)
        res.status(500).json(error.message)
    }
})

// Deletar
app.delete('/deletarDoacao', async (req, res) => {
    try {
        const { id_doacao } = req.body

        const [resultado] = await pool.query(`DELETE FROM doacao WHERE id_doacao = ?`, [id_doacao])

        if (resultado.affectedRows === 1) {
            res.json({ resposta: "Doação deletada com sucesso!" })
        } else {
            res.json({ resposta: "Erro ao deletar doação!" })
        }

    } catch (error) {
        console.log(error)
        res.status(500).json(error.message)
    }
})
