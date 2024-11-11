import { React, useState } from 'react'
import { Text } from 'react-native'
import Estilo from '../Estilo'
import ContadorDisplay from './ContadorDisplay'
import ContadorBotoes from './ContadorBotoes'

export default props =>{
    const [num,setNum] = useState(0)
    function inc(){
        setNum(num+1)
    }
    function dec(){
        setNum(num-1)
    }
    return(
        <>
            <Text style = {Estilo.txtG}>
                Contador
            </Text>

            <ContadorDisplay propriedadeNum = {num}></ContadorDisplay>
            {/*comunicação direta do pai com filho*/}
            <ContadorBotoes propriedadeInc = {inc} propriedadeDec = {dec}></ContadorBotoes>
            {/*comunicação indireta do filho com pai , o filho chama uma das funções do pai*/}
        </>
    )
}