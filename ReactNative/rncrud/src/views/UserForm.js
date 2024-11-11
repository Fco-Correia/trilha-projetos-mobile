import React, { useContext, useState } from "react"
import { View, Text, TextInput, StyleSheet, Button } from "react-native"
import UsersContext from "../context/UsersContext"

export default props => {
    console.warn(Object.keys(props.route.params ? props.route.params : false))//no de adcionar nao vai parametros
    const [user, setUser] = useState(props.route.params ? props.route.params : {})
    const ctx = useContext(UsersContext)
    return (
        <View style={style.form}>
            <Text style={{ color: 'black' }}>Name</Text>
            <TextInput
                style={style.input}
                onChangeText={nameInput => setUser({ ...user, name: nameInput })}
                placeholder="Informe o nome"
                value={user.name}
            />
            <Text style={{ color: 'black' }}>Email</Text>
            <TextInput
                style={style.input}
                onChangeText={emailInput => setUser({ ...user, email: emailInput })}
                placeholder="Informe o nome"
                value={user.email}
            />
            <Text style={{ color: 'black' }}>Url do Avatar</Text>
            <TextInput
                style={style.input}
                onChangeText={avatarUrlInput => setUser({ ...user, avatarUrl: avatarUrlInput })}
                placeholder="Informe o nome"
                value={user.avatarUrl}
            />

            <Button
                title="Salvar"
                onPress={() => {
                    if (props.route.params) {
                        ctx.dispatch({
                            type: 'updateUser',
                            payload: user
                        })
                    } else {
                        ctx.dispatch({
                            type: 'createUser',
                            payload: user
                        })
                    }
                    props.navigation.goBack()
                }}
            />

        </View>
    )
}

const style = StyleSheet.create({
    form: {
        padding: 20
    },
    input: {
        height: 40,
        borderColor: 'grey',
        borderWidth: 1,
        color: 'black',
        marginBottom: 10
    }
})