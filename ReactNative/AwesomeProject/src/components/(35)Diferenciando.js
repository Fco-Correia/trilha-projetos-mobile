import { React } from 'react'
import { Platform, Text } from 'react-native'
import Estilo from './Estilo'

export default props =>{
    if (Platform.OS ==="android"){
        return(
            <Text style = {Estilo.txtG}>Android</Text>
        )
    }else if(Platform.OS ==="ios"){
        return(
            <Text style = {Estilo.txtG}>Ios</Text>
        )
    }else{
        return(
            <Text style = {Estilo.txtG}>Nem Android nem IOS</Text>
        )
    }
}