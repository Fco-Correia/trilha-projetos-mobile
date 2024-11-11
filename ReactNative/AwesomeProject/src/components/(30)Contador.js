import {React,useState} from "react";
import { Text,Button } from "react-native";
import Estilo from './Estilo'

export default (props)=>{
    const {passo} = props

    let numero = 0
    
    const [num,setNum] = useState(numero)
    function add(){
        //numero +=1 //não altera na tela
        setNum(num+passo)
    }
    function remove(){
        setNum(num-passo)
        //numero -=1
    }
    return (
        <>
            <Text style={Estilo.txtG}>{num}</Text>
            <Button title="+" onPress={add}/>
            <Button title="-" onPress={remove}/>
        </>
    )
}