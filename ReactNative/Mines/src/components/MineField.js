import React from "react"
import { View, StyleSheet } from "react-native"
import Field from "./Field"
// array de objetos em jsx
export default props => {
    const rows = props.board.map((row,r)=>{
        const columns = row.map((field,c) => {
            return <Field {...field} key={c}
                onOpen={()=>props.onOpenField(r,c)}
                onSelect={e=>props.onSelectField(r,c)}/>
            //sempre que retorno um array de jsx eu preciso do key
        })
        return <View key = {r} style={{flexDirection: 'row'}}>{columns}</View>
    })
    return <View style={styles.container}>{rows}</View>
}

const styles = StyleSheet.create({
    container:{
        backgroundColor: ' #EEE'
    }
})