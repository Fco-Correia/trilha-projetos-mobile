import { React } from 'react'
import { Text, SafeAreaView, StyleSheet } from 'react-native'
import Estilo from '../Estilo'

export default ({num}) =>{
    return(
        <SafeAreaView style ={style.Container}>
            <Text style = {[Estilo.txtG, style.Num]}>
                {num}
            </Text>
        </SafeAreaView>
    )
}

const style = StyleSheet.create({
    Container:{
        height: 50,
        width: 50,
        backgroundColor:'#000',
        margin: 5,
        borderRadius: 25
    },
    Num:{
        color: '#FFF'
    }
})