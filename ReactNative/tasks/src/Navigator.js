import React from 'react';
import {NavigationContainer} from '@react-navigation/native';
import {createDrawerNavigator} from '@react-navigation/drawer';
import {createStackNavigator} from '@react-navigation/stack';
import TaskList from './screens/TaskList';
import Auth from './screens/Auth';
import AuthOrApp from './screens/AuthOrApp';
import Menu from './screens/Menu';
import commonStyles from './commonStyles';

const Drawer = createDrawerNavigator();
const Stack = createStackNavigator();

const menuConfig = {
  initialRouteName: 'Today',
  screenOptions: {
    headerShown: false, // Oculta as três barras
    swipeEnabled: true, // Habilita o gesto de arrastar
    drawerActiveTintColor: '#080',
    drawerLabelStyle: {
      fontFamily: commonStyles.fontFamily,
      fontWeight: 'normal',
      fontSize: 20,
    },
    drawerActiveLabelStyle: {
      fontWeight: 'bold',
    },
  },
};

const TodayScreen = props => <TaskList {...props} title="Hoje" daysAhead={0} />;
const TomorrowScreen = props => (
  <TaskList {...props} title="Amanhã" daysAhead={1} />
);
const WeekScreen = props => (
  <TaskList {...props} title="Semana" daysAhead={7} />
);
const MonthScreen = props => <TaskList {...props} title="Mês" daysAhead={30} />;

const renderMenu = (drawerProps, email, name) => (
  <Menu {...drawerProps} email={email} name={name} />
);

function DrawerNavigator(props) {
  const email = props.route?.params?.email;
  const name = props.route?.params?.name;

  return (
    <Drawer.Navigator
      initialRouteName={menuConfig.initialRouteName}
      drawerContent={drawerProps => renderMenu(drawerProps, email, name)}
      screenOptions={menuConfig.screenOptions}>
      <Drawer.Screen
        name="Today"
        component={TodayScreen}
        options={{title: 'Hoje'}}
      />
      <Drawer.Screen
        name="Tomorrow"
        component={TomorrowScreen}
        options={{title: 'Amanhã'}}
      />
      <Drawer.Screen
        name="Week"
        component={WeekScreen}
        options={{title: 'Semana'}}
      />
      <Drawer.Screen
        name="Month"
        component={MonthScreen}
        options={{title: 'Mês'}}
      />
    </Drawer.Navigator>
  );
}

function StackNavigator() {
  return (
    <Stack.Navigator
      initialRouteName="AuthOrApp"
      screenOptions={{headerShown: false}}>
      <Stack.Screen name="AuthOrApp" component={AuthOrApp} />
      <Stack.Screen name="Auth" component={Auth} />
      <Stack.Screen name="TaskList" component={DrawerNavigator} />
    </Stack.Navigator>
  );
}

export default function App() {
  return (
    <NavigationContainer>
      <StackNavigator />
    </NavigationContainer>
  );
}
