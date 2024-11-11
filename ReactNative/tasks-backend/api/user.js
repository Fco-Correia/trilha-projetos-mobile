const bcrypt = require('bcrypt-nodejs')//vamos usar pra armazenar a senha em hash

module.exports = app => {
    const obterHash = (password,callback) =>{
        bcrypt.genSalt(10,(err,salt) => {
            bcrypt.hash(password,salt,null,(err,hash) => callback(hash))
        })
    }

    //é um middleware... ta com req e res
    const save = (req,res) => {
        obterHash(req.body.password, hash =>{
            const password = hash

            app.db('users').insert({
                name: req.body.name, 
                email: req.body.email.toLowerCase(),
                password
            })
            .then(_ => res.status(204).send())
            .catch(err => res.status(400).json(err))
            //400 erro do cliente
        })
    }

    return { save }
}