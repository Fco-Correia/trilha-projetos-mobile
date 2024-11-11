import React, {createContext, useReducer} from "react";
import users from "../data/users";

const initialState = { users };
const UsersContext = createContext({});

export const UsersProvider = props => {
    function reducer(state, action) {
        console.warn(action);
        switch (action.type) {
            case 'deleteUser':
                return {
                    ...state,
                    users: state.users.filter(user => user.id !== action.payload.id)
                }
            case 'createUser':
                const user = action.payload
                user.id = Math.random()
                return {
                    ...state,
                    users:[...state.users,user]
                }
            case 'updateUser':
                return{
                    ...state,
                    users: state.users.map(user => user.id === action.payload.id ? action.payload : user)
                }
            default:
                return state;
        }
    }

    const [state, dispatch] = useReducer(reducer, initialState);

    return (
        <UsersContext.Provider value={{
            state, dispatch
        }}>
            {props.children}
        </UsersContext.Provider>
    );
}

export default UsersContext;