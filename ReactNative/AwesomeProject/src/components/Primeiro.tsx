import React from 'react'
import { Text } from 'react-native'
import Estilo from "./Estilo";
// nao da pra retornar mais de um componente de uma vez, tem que envolver varios em um unico, tipo usando view, tal do fragment
export default() => {
    //console.warn("Opa")
    return <Text style={Estilo.txtG}>Primeiro</Text>
}