import React from 'react';
import {Platform, View, Text, StyleSheet, TouchableOpacity} from 'react-native';
import {
  DrawerContentScrollView,
  DrawerItemList,
} from '@react-navigation/drawer';
import commonStyles from '../commonStyles';

import axios from 'axios';
import AsyncStorage from '@react-native-async-storage/async-storage';
import Icon from 'react-native-vector-icons/Ionicons';
import Gravatar from 'react-native-avatar-gravatar';

export default function CustomDrawerContent(props) {
  const email = props.email;
  const name = props.name;

  const logout = () => {
    delete axios.defaults.headers.common.Authorization;
    AsyncStorage.removeItem('userData');
    props.navigation.navigate('AuthOrApp');
    props.navigation.reset({
      index: 0,
      routes: [{name: 'AuthOrApp'}],
    });
  };
  return (
    <DrawerContentScrollView {...props}>
      <View style={styles.header}>
        <Text style={styles.title}>Tasks</Text>
        <View style={styles.avatar}>
          <Gravatar emailAddress={props.email} size={80} mask="circle" />
        </View>
        <View style={styles.userInfo}>
          <Text style={[{color: 'black'}, styles.name]}>{name}</Text>
          <Text style={[{color: 'black'}, styles.email]}>{email}</Text>
        </View>
        <TouchableOpacity onPress={logout}>
          <View style={styles.logoutIcon}>
            <Icon name="log-out" size={30} color="#800" />
          </View>
        </TouchableOpacity>
      </View>
      <DrawerItemList {...props} />
    </DrawerContentScrollView>
  );
}

const styles = StyleSheet.create({
  header: {
    borderBottomWidth: 1,
    borderColor: '#DDD',
  },
  title: {
    color: '#000',
    fontFamily: commonStyles.fontFamily,
    marginLeft: 15,
    fontSize: 30,
    marginTop: Platform.OS === 'ios' ? 50 : 5,
  },
  avatar: {
    margin: 10,
  },
  userInfo: {
    marginLeft: 15,
    marginBottom: 10,
  },
  name: {
    fontFamily: commonStyles.fontFamily,
    fontSize: 20,
  },
  email: {
    fontFamily: commonStyles.fontFamily,
    fontSize: 15,
    color: commonStyles.colors.subText,
  },
  logoutIcon: {
    marginLeft: 15,
    marginBottom: 10,
  },
  avatar: {
    width: 30,
    height: 40,
    borderRadius: 15,
    marginHorizontal: 15,
    justifyContent: 'center',
    alignItems: 'center',
  },
});
