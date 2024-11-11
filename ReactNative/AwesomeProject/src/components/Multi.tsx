//Sistema de módulos do ECMAScript
import React from 'react'
import {Text} from 'react-native'

export default function(){
    return <Text>Comp #Oficial</Text>
}

function Comp1(){
    return <Text>Comp #01</Text>
}

function Comp2(){
    return <Text>Comp #02</Text>
}

export {Comp1,Comp2}// n precisa colocar o export em cada uma função