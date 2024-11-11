import React from "react";
import { Text } from "react-native";

export default (props) => { 
  //props = {min: ,max:} //usamos props so pra leitura
  
  const {min,max} = props
    console.warn(props)
    var valor = Math.floor(Math.random() * (max - min) + min);
    return (
    <Text>
        Valor aleatório: {valor}
    </Text>)
}