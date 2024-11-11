import { React, useState } from 'react'
import { View, Text, FlatList } from 'react-native'
import Estilo from '../Estilo'

import Produtos from './(40)produtos'

export default props => {
    const produtoRender = ({item:p})=>{
        return <Text>{p.id} {p.nome}</Text>
    }
    return (
        <>
            <Text style={Estilo.txtG}>
                Lista de produtos V2
            </Text>
            <FlatList 
                data = {Produtos}
                keyExtractor={i=>i.id}
                renderItem={produtoRender}>

            </FlatList>
        </>
    )
}