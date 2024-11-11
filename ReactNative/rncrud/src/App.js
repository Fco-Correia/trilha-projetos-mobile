import React from "react"
import { NavigationContainer } from '@react-navigation/native'
import { createNativeStackNavigator } from '@react-navigation/native-stack'
import UserList from "./views/UserList"
import UserForm from "./views/UserForm"

import { Button } from "@rneui/themed"
import Icon from 'react-native-vector-icons/Ionicons'
import { UsersProvider } from "./context/UsersContext"

const Stack = createNativeStackNavigator()
export default props => {
    return (
        <UsersProvider>
            <NavigationContainer>
                <Stack.Navigator
                    initialRouteName="UserList"
                    screenOptions={screenOptions}>
                    <Stack.Screen
                        name="UserList"
                        component={UserList}
                        options={(props) => {
                            return {
                                title: "Lista de Usuários",
                                headerRight: () => (
                                    <Button
                                        onPress={() => props.navigation.navigate("UserForm")}
                                        type="clear"
                                        icon={<Icon name="add" size={25} color="white"></Icon>}
                                    ></Button>
                                )
                            }
                        }}
                    />
                    <Stack.Screen
                        name="UserForm"
                        component={UserForm}
                        options={{
                            title: "Formulario de Usuários"
                        }}
                    />
                </Stack.Navigator>
            </NavigationContainer>
        </UsersProvider>

    )
}

const screenOptions = {
    headerStyle: {
        backgroundColor: '#f4511e'
    },
    headerTintColor: '#fff',
    headerTitleStyle: {
        fontWeight: 'bold'
    }
}