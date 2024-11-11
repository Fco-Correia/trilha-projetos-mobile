//Comunicação direta pai-filho
import {React,useState} from 'react'
import { Text } from 'react-native'
import Estilo from '../Estilo'
import Filho from './Filho'

export default props =>{
    const [num,setNum] = useState(0)
    function exibirValor(numero){
        console.warn(numero)
        setNum(numero)
    }
    return(
        <>
            <Text style={Estilo.txtG}>{num}</Text>
            <Filho min ={1} max={60} funcao={exibirValor}></Filho>
        </>
    )
}
