import { React } from 'react'
import { SafeAreaView, Text } from 'react-native'
import Estilo from './Estilo'

export default props => {

    return (
        <SafeAreaView>
            <Text>O resultado é:</Text>
            {props.num % 2 === 0
                ? <Text style={Estilo.txtG}>Par</Text>
                : <Text style={Estilo.txtG}>Impar</Text>
            }
        </SafeAreaView>
    )

}