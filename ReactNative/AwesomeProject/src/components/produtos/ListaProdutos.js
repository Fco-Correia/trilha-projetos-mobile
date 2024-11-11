import { React, useState } from 'react'
import { View, Text } from 'react-native'
import Estilo from '../Estilo'

import Produtos from './(40)produtos'

export default props => {
    function obterLista() {
        return Produtos.map(p => {
            return (
                <Text key={p.id}>
                    {p.id} {p.nome} {p.preco}
                </Text>)
        }
        )
    }
    return (
        <>
            <Text style={Estilo.txtG}>
                Lista de produtos
            </Text>
            {obterLista()}
        </>
    )
}