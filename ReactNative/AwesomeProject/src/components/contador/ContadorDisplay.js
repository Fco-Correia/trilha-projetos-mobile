import React from 'react'
import { SafeAreaView,StyleSheet,Text } from 'react-native'
import Estilo from '../Estilo'

export default props =>{
    return(
        <SafeAreaView style={style.Display}>
            <Text style = {[Estilo.txtG,style.DisplayText]}>
                {props.propriedadeNum}
            </Text>
        </SafeAreaView>
    )
}

const style = StyleSheet.create({
    Display:{
        backgroundColor:'#000'
    },
    DisplayText:{
        color: 'red'
    }
})