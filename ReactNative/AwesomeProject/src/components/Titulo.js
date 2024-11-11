import React from "react";
import { SafeAreaView ,Text } from "react-native";
import Estilo from './Estilo'

export default(props) =>{
    return (
        <SafeAreaView>
            <Text style= {Estilo.txtG}>
                {props.principal}
            </Text>
            <Text>
                {props.secundario}
            </Text>
        </SafeAreaView>
    )
}