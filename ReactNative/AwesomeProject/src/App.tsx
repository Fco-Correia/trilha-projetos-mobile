import React from 'react'
import { SafeAreaView, Text , StyleSheet} from 'react-native'

import CompPadrao,{Comp1,Comp2} from './components/Multi'
import Primeiro from './components/Primeiro'
import MinMax from './components/MinMax'

import Aleatorio from './components/(26)Aleatorio'
import Titulo from './components/Titulo'
import Botao from './components/(29)Botao'
import Contador30 from './components/(30)Contador'
import ParImpar from './components/(37)ParImpar'
import Familia from './components/relacao/(38)Familia'
import Membro from './components/relacao/Membro'
import UsuarioLogado from './components/(39)UsuarioLogado'
import Quadrado from './components/layout/(45)Quadrado'
import FlexboxV4 from './components/layout/(49)FlexboxV4'
import Mega from './components/mega/(50)Mega'
/*
function App(){
    const jsx = <Text>Primeiro componente</Text>
    return jsx
}

export default App
*/

/*
export default function(){
    return <Text>Primeiro componente</Text>
}
*/

export default() => (
    <SafeAreaView style={style.App}>
        <Mega qtdeNumeros = {7}></Mega>
        {
        /**
        <FlexboxV4></FlexboxV4>
        <UsuarioLogado usuario={{ nome: "Gui", email: "gui@gui.com" }} />
        <Familia>
            <Membro nome = "Ana" sobrenome = "Silva"></Membro>
            <Membro nome = "Julia" sobrenome = "Silva"></Membro>
        </Familia>
        <Familia>
            <Membro nome = "João" sobrenome = "Silva"></Membro>
            <Membro nome = "Pedro" sobrenome = "Silva"></Membro>
        </Familia>
        <ParImpar num = {2}></ParImpar>
        <Contador30 passo = {10}></Contador30>
        <Titulo principal ="Cadastro Produto" secundario ="Tela de Cadastro"/>
        <Botao/>
        <Aleatorio min = {1} max = {10}/>
        <Aleatorio min = {1} max = {10}/>
        <Aleatorio min = {1} max = {10}/>
        <MinMax min ="3" max = "5"/>
        <CompPadrao/>
        <Comp1/>
        <Comp2/>
        <Primeiro/>
        <Text>{1+1}</Text>     
         */
        }
    </SafeAreaView>
)

const style = StyleSheet.create({
    App : {
        flex:1,
        justifyContent: 'center',
        alignItems: "center",
        padding: 20,
    }
})