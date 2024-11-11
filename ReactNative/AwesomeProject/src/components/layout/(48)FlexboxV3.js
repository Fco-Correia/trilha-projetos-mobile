import { React } from 'react'
import { SafeAreaView, Text, StyleSheet } from 'react-native'
import Quadrado from './(45)Quadrado'

export default props =>{
    return(
        <SafeAreaView style={style.FlexV3}>
            <Quadrado color="#ff801a" lado={20}></Quadrado>
            <Quadrado color="#50d1f6" lado={30}></Quadrado>
            <Quadrado color="#dd22c1" lado={40}></Quadrado>
            <Quadrado color="#8312ed" lado={50}></Quadrado>
            <Quadrado color="#36c9a7" lado={60}></Quadrado>
        </SafeAreaView>
    )
}

const style = StyleSheet.create({
    FlexV3:{
        flexDirection:'row',
        justifyContent:'space-evenly',
        alignItems:'flex-start',
        height: 350,
        width:'100%',
        backgroundColor:'#000'
    }
})