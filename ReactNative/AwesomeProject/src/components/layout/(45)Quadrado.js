import { React } from 'react'
import { SafeAreaView, Text} from 'react-native'


export default props =>{
    const lado = props.lado || 50
    return(
        <SafeAreaView style={
            {
                height:lado,
                width:lado,
                backgroundColor:props.color || '#000'
            }
        }>
            
        </SafeAreaView>
    )
}
