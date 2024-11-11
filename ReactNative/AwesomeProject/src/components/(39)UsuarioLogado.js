import React from 'react'
import { View, Text } from 'react-native'
import Estilo from './Estilo'
import If from './(39)if'

export default ({ usuario = {} }) => {
    return (
        <>
            <If teste = {usuario.nome && usuario.email}>
                <Text style={Estilo.txtG}>
                    {usuario.nome} - {usuario.email}
                </Text>
            </If>
        </>
    )
}
