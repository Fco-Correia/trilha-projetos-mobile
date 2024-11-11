const express = require('express')
const app = express()
const db = require('./config/db')
const consign = require('consign')

app.db = db //aqui tenho acesso ao knex pra mudar o db

consign()
    .include('./config/passport.js')
    .then('./config/middlewares.js')
    .then('./api')
    .then('./config/routes.js')
    .into(app)

app.listen(3000,() =>{
    console.log('backend executando...')
})
