import React, { useContext } from "react"
import { Alert, FlatList, SafeAreaView } from "react-native"
import users from '../data/users'
import { Avatar, Button, ListItem } from "@rneui/themed"
import Icon from 'react-native-vector-icons/Ionicons'
import UsersContext from "../context/UsersContext"

export default props => {
    //console.warn(Object.keys(props))
    const ctx = useContext(UsersContext)
    console.warn(Object.keys(ctx.state.users))
    return (
        <SafeAreaView>
            <FlatList
                data ={ctx.state.users}
                //data={users}
                keyExtractor={user => user.id.toString()}
                renderItem={getUserItem}
            >
            </FlatList>
        </SafeAreaView>
    )

    function getUserItem({item:user}){
        return (
            <ListItem bottomDivider onPress={() => props.navigation.navigate('UserForm')}>
                <Avatar
                    rounded
                    source={{uri:user.avatarUrl}}
                />
                <ListItem.Content>
                    <ListItem.Title>{user.name}</ListItem.Title>
                    <ListItem.Subtitle>{user.email}</ListItem.Subtitle>
                </ListItem.Content>
                {getActions(user)}
            </ListItem>
        )
    }

    function getActions(user) {
        return (
            <>
                <Button
                    onPress={() => props.navigation.navigate('UserForm', user)}
                    type="clear"
                    icon={<Icon name="create-outline" size={25} color='orange' />}
                />
                <Button
                    onPress={() => confirmUserDeletion(user)}
                    type="clear"
                    icon={<Icon name="trash-outline" size={25} color='red' />}
                />
            </>
        )
    }

    function confirmUserDeletion(user){
        Alert.alert("Excluir Usuário","Deseja excluir o usuário?",[
            {
                text: 'sim',
                onPress(){
                    ctx.dispatch({
                        type:'deleteUser',
                        payload: user
                    })
                }
            },
            {
                text:'Não'
            }
        ])
    }
}