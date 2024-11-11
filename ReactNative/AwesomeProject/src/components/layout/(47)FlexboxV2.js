import { React } from 'react'
import { SafeAreaView, Text, StyleSheet } from 'react-native'
import Quadrado from './(45)Quadrado'

export default props =>{
    return(
        <SafeAreaView style={style.FlexV2}>
            <Quadrado color="#ff801a"></Quadrado>
            <Quadrado color="#50d1f6"></Quadrado>
            <Quadrado color="#dd22c1"></Quadrado>
            <Quadrado color="#8312ed"></Quadrado>
            <Quadrado color="#36c9a7"></Quadrado>
        </SafeAreaView>
    )
}

const style = StyleSheet.create({
    FlexV2:{
        flex:1,
        width:'100%',
        alignItems:'center',
        justifyContent:"space-between",
        backgroundColor:'#000'
    }
})