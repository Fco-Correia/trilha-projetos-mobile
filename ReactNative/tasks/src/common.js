/* eslint-disable prettier/prettier */
import { Alert, Platform } from 'react-native';
const server = Platform.OS === 'ios'
    ? 'http://localhost:3000' : 'http://10.0.0.145:3000';

function showError(err) {

    Alert.alert('Ocorreu um problema!',`Mensagem: ${err}`);
}

function showSucess(msg) {
    Alert.alert('Sucesso', msg);
}

export {server,showError,showSucess};
