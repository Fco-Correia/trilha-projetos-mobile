const { authSecret } = require('../.env')
const passport = require ('passport')
const passportJwt = require('passport-jwt')

//extractJwt le a requisição procurando o jwt  e o FromRequest fala que é pra procurar o token do header
//estrategia pra fazer a validação
const {Strategy, ExtractJwt} = passportJwt
module.exports = app => {
    const params = {
        secretOrKey: authSecret,
        jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
    }

    const strategy = new Strategy(params,(payload,done) =>{
        //done(erro,usuarioAutenticado)
        app.db('users')
            .where({id:payload.id})
            .first()
            .then(user => {
                if(user){
                    //isso vai la pra req.user que usamos pra salvar tasks
                    done(null,{id:user.id,email:user.email})
                }else {
                    done(null,false)
                }
            })
            .catch(err=> done(err,false))
    })

    passport.use(strategy)

    return {
        initialize: () => passport.initialize(),
        authenticate: () => passport.authenticate('jwt', {session:false})
    }
}