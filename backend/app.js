const express = require('express')
const cors = require('cors')
const pool = require("./db.js")


const swaggerUi = require('swagger-ui-express')
const swaggerDocument = require('./swagger.json')
const path = require('path')
const crypto = require('crypto');

const app = express()
const porta = 3000

app.use(cors())
app.use(express.json())

app.use(express.static('public'))
app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerDocument))

app.listen(porta, () => {
    console.log(`Servidor rodando em: http://localhost:${porta}`)
    console.log(`Swagger em: http://localhost:${porta}/api-docs`)
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
        const [resultado] = await pool.query(`DELETE FROM cadastro WHERE id_usuario = ?`,[id_usuario]
        )
        res.json({ resposta: resultado.affectedRows ? "Deletado!" : "Erro ao deletar!" })

    } catch (error) {
        res.status(500).json("erro no servidor")
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

// ================= ROTA DE RECUPERAÇÃO E ATUALIZAÇÃO DE SENHA =============================================================

app.put('/recuperar-senha', async (req, res) => {
    try {
        const { email, senha, confirmar_senha } = req.body;

        if (!email || !senha || !confirmar_senha) {
            return res.status(400).json({ erro: "Todos os campos são obrigatórios." });
        }

        if (senha !== confirmar_senha) {
            return res.status(400).json({ erro: "A senha e a confirmação não coincidem." });
        }

        const emailLimpo = email.trim().toLowerCase();

        const hash = crypto.createHash("sha256").update(senha.trim()).digest("base64");

        const sql = `UPDATE cadastro SET senha = ? WHERE LOWER(email) = ?`;
        const [resultado] = await pool.query(sql, [hash, emailLimpo]);

        if (resultado.affectedRows > 0) {
            return res.json({ resposta: "Senha atualizada com sucesso!" });
        } else {
            return res.status(404).json({ erro: "Este e-mail não está registrado no sistema." });
        }

    } catch (error) {
        console.error("Erro no Servidor:", error);
        res.status(500).json({ erro: "Erro interno no servidor." });
    }
});
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
        const [resultado] = await pool.query(sql, [id_ong, nome, especie, raca, porte, idade, sexo, descricao, status, imagem, ong, cidade, estado])
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

app.put('/atualizarAnimal', async (req, res) => {
    try {
        const { id_animal, id_ong, nome, especie, raca, porte, idade, sexo, descricao, status, imagem, ong, cidade, estado } = req.body

        if (!id_animal) {
            return res.status(400).json({ erro: "id_animal é obrigatório" })
        }

        const sql = `
        UPDATE animais 
        SET id_ong = ?, nome = ?, especie = ?, raca = ?, porte = ?, idade = ?, sexo = ?, descricao = ?, status = ?, imagem = ?, ong = ?, cidade = ?,
         estado = ? WHERE id_animal = ?`

        const [resultado] = await pool.query(sql, [
            id_ong, nome, especie, raca, porte, idade, sexo, descricao, status, imagem, ong, cidade, estado, id_animal
        ])

        if (resultado.affectedRows === 1) {
            res.json({ resposta: "Animal atualizado com sucesso!" })
        } else {
            res.status(404).json({ erro: "Animal não encontrado ou nada foi alterado" })
        }

    } catch (error) {
        console.log(error)
        res.status(500).json({ erro: "erro no servidor" })
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
// ================= ANIMAIS (LISTAGEM, FILTROS E DETALHES) =================
app.get("/animais", async (req, res) => {
    try {
        const { id, especie, sexo, porte } = req.query;

        // Se for busca por ID (página de detalhes)
        if (id) {
            const [dados] = await pool.query("SELECT * FROM animais WHERE id_animal = ?", [id]);
            return res.json(dados[0]);
        }

        let sql = "SELECT * FROM animais WHERE status = 'disponivel'";
        let valores = [];

        // Filtro de Espécie (Cachorro/Gato)
        if (especie && especie !== "") {
            sql += " AND LOWER(especie) = LOWER(?)";
            valores.push(especie);
        }

        // Filtro de Sexo (Macho/Fêmea)
        if (sexo && sexo !== "") {
            // Esta linha aceita 'femea' ou 'fêmea' automaticamente
            if (sexo.toLowerCase().includes('feme') || sexo.toLowerCase().includes('fême')) {
                sql += " AND (LOWER(sexo) LIKE 'feme%' OR LOWER(sexo) LIKE 'fême%')";
            } else {
                sql += " AND LOWER(sexo) = LOWER(?)";
                valores.push(sexo);
            }
        }

        // Filtro de Porte
        if (porte && porte !== "") {
            if (porte.toLowerCase().includes('medi')) {
                sql += " AND (LOWER(porte) LIKE 'medi%')";
            } else {
                sql += " AND LOWER(porte) = LOWER(?)";
                valores.push(porte);
            }
        }

        sql += " ORDER BY id_animal DESC";

        const [resultado] = await pool.query(sql, valores);
        res.json(resultado);

    } catch (error) {
        console.log(error);
        res.status(500).send("Erro no servidor");
    }
});
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

//deletar
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

// ================= NECESSIDADES =============================================================================================================================

// Mostrar 
app.get('/mostrarNecessidades', async (req, res) => {
    try {
        const [resultado] = await pool.query(` SELECT n.*, a.nome AS animal FROM necessidades n JOIN animais a ON n.id_animal = a.id_animal`)
        res.send(resultado)
    } catch (error) {
        console.log(error)
        res.status(500).json(error.message)
    }
})

// Inserir
app.post('/inserirNecessidade', async (req, res) => {
    try {
        const { id_animal, nome, categoria, grau_importancia, descricao, botao } = req.body
        const sql = `INSERT INTO necessidades (id_animal, nome, categoria, grau_importancia, descricao, botao)VALUES (?, ?, ?, ?, ?, ?)`

        const [resultado] = await pool.query(sql, [id_animal, nome, categoria, grau_importancia, descricao, botao])

        if (resultado.affectedRows === 1) {
            res.json({ resposta: "Necessidade cadastrada!" })
        } else {
            res.json({ resposta: "Erro ao cadastrar!" })
        }

    } catch (error) {
        console.log(error)
        res.status(500).json(error.message)
    }
})

// Atualizar
app.put('/atualizarNecessidade', async (req, res) => {
    try {
        const { id_necessidade, id_animal, nome, categoria, grau_importancia, descricao, botao } = req.body
        const sql = `UPDATE necessidades SET id_animal = ?, nome = ?, categoria = ?, grau_importancia = ?, descricao = ?, botao = ?WHERE id_necessidade = ?`

        const [resultado] = await pool.query(sql, [id_animal, nome, categoria, grau_importancia, descricao, botao, id_necessidade])

        if (resultado.affectedRows === 1) {
            res.json({ resposta: "Atualizado com sucesso!" })
        } else {
            res.json({ resposta: "Erro ao atualizar!" })
        }

    } catch (error) {
        console.log(error)
        res.status(500).json(error.message)
    }
})

// Deletar
app.delete('/deletarNecessidade', async (req, res) => {
    try {
        const { id_necessidade } = req.body
        const [resultado] = await pool.query(`DELETE FROM necessidades WHERE id_necessidade = ?`, [id_necessidade])
        if (resultado.affectedRows === 1) {
            res.json({ resposta: "Deletado com sucesso!" })
        } else {
            res.json({ resposta: "Erro ao deletar!" })
        }

    } catch (error) {
        console.log(error)
    }
})
// ================= EVENTOS ==================================================================================================================================

// Mostrar 
app.get('/mostrarEventos', async (req, res) => {
    try {
        const [resultado] = await pool.query(`
            SELECT e.*, o.nome AS ong
            FROM eventos e
            JOIN ong o ON e.id_ong = o.id_ong
        `)
        res.send(resultado)
    } catch (error) {
        console.log(error)
        res.status(500).json(error.message)
    }
})

// Inserir
app.post('/inserirEvento', async (req, res) => {
    try {
        const { id_ong, nome_evento, hora, data, endereco, categoria, localizacao } = req.body

        const sql = ` INSERT INTO eventos (id_ong, nome_evento, hora, data, endereco, categoria, localizacao) VALUES (?, ?, ?, ?, ?, ?, ?)`

        const [resultado] = await pool.query(sql, [id_ong, nome_evento, hora, data, endereco, categoria, localizacao])

        if (resultado.affectedRows === 1) {
            res.json({ resposta: "Evento cadastrado!" })
        } else {
            res.json({ resposta: "Erro ao cadastrar evento!" })
        }

    } catch (error) {
        console.log(error)
        res.status(500).json(error.message)
    }
})

// Atualizar
app.put('/atualizarEvento', async (req, res) => {
    try {
        const { id_evento, id_ong, nome_evento, hora, data, endereco, categoria, localizacao } = req.body

        const sql = `UPDATE eventos SET id_ong = ?, nome_evento = ?, hora = ?, data = ?, endereco = ?, categoria = ?, localizacao = ? WHERE id_evento = ? `

        const [resultado] = await pool.query(sql, [id_ong, nome_evento, hora, data, endereco, categoria, localizacao, id_evento])

        if (resultado.affectedRows === 1) {
            res.json({ resposta: "Evento atualizado!" })
        } else {
            res.json({ resposta: "Erro ao atualizar evento!" })
        }

    } catch (error) {
        console.log(error)
        res.status(500).json(error.message)
    }
})

// Deletar
app.delete('/deletarEvento', async (req, res) => {
    try {
        const { id_evento } = req.body

        const [resultado] = await pool.query(`DELETE FROM eventos WHERE id_evento = ?`, [id_evento])

        if (resultado.affectedRows === 1) {
            res.json({ resposta: "Evento deletado!" })
        } else {
            res.json({ resposta: "Erro ao deletar evento!" })
        }

    } catch (error) {
        console.log(error)
    }
})