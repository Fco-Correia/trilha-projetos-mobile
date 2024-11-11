//Comunicação direta pai-filho
import React from 'react'
import { View, Text } from 'react-native'
import Estilo from '../Estilo'

import Filho from './Filho'

export default props =>{
    let x = 13
    let y = 100
    return(
        <>
            <Filho a={x} b={y}></Filho>
        </>
    )
}