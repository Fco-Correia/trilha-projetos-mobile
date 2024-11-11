//Componentes controlados
import { React, useState } from 'react'
import { SafeAreaView, Text, TextInput } from 'react-native'
import Estilo from './Estilo'

export default props =>{
    const [nome,setNome] = useState('')
    return(
        <SafeAreaView>
            <TextInput 
                placeholder='Digite seu Nome'
                value={nome}
                onChangeText={nome => setNome(nome)}
            />
        </SafeAreaView>    
    )
}