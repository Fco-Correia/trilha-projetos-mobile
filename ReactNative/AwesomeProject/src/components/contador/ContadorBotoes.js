import { React, useState } from 'react'
import { Button, StyleSheet, View } from 'react-native'

export default props =>{
    return(
        <View style={style.separar}>
            <Button title='+' onPress={props.propriedadeInc}></Button>
            <Button title='-' onPress={props.propriedadeDec}></Button>
        </View>
    )
}

const style = StyleSheet.create({
    separar:{
        display:"flex",
        flexDirection:"row",
        justifyContent:"space-evenly",
    }
})
