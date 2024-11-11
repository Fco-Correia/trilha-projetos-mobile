import React, {Component} from 'react';
import {View, ActivityIndicator, StyleSheet} from 'react-native';

import axios from 'axios';
import AsyncStorage from '@react-native-async-storage/async-storage';

export default class AuthOrApp extends Component {
  componentDidMount = async () => {
    //sem chance de erro no this,async componentDidMount(){} talvez daria problema com o this
    const userDataJson = await AsyncStorage.getItem('userData');
    let userData = null;

    try {
      userData = JSON.parse(userDataJson);
    } catch (e) {}

    if (userData && userData.token) {
      axios.defaults.headers.common.Authorization = `bearer ${userData.token}`;
      //daqui pra frente todas minhas reqs na header vai ter o token
      this.props.navigation.navigate('TaskList', userData);
    } else {
      this.props.navigation.navigate('Auth');
    }
  };
  render() {
    return (
      <View style={styles.container}>
        <ActivityIndicator size="large" />
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#000',
  },
});
