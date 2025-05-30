import {React, Component} from 'react';
import {
  View,
  Text,
  ImageBackground,
  StyleSheet,
  FlatList,
  TouchableOpacity,
  Platform,
  Alert,
} from 'react-native';
import commonStyles from '../commonStyles';

import todayImage from '../../assets/imgs/today.jpg';
import tomorrowImage from '../../assets/imgs/tomorrow.jpg';
import weekImage from '../../assets/imgs/week.jpg';
import monthImage from '../../assets/imgs/month.jpg';

import moment from 'moment';
import Task from '../components/Task';

import Icon from 'react-native-vector-icons/Ionicons';
import axios from 'axios';
import {server, showError} from '../common';
import AddTask from './AddTask';
import {GestureHandlerRootView} from 'react-native-gesture-handler';
import AsyncStorage from '@react-native-async-storage/async-storage';

const initialState = {
  showDoneTasks: true,
  visibleTasks: [],
  showAddTask: false,
  tasks: [],
};

export default class TaskList extends Component {
  state = {
    ...initialState,
  };

  componentDidMount = async () => {
    // Carrega o estado salvo e as tasks
    const stateString = await AsyncStorage.getItem('tasksState');
    const savedState = JSON.parse(stateString) || initialState;
    this.setState(
      {
        showDoneTasks: savedState.showDoneTasks,
      },
      this.filterTasks,
    );
    this.loadTasks();

    // Listener para recarregar as tarefas ao focar na tela
    this.focusListener = this.props.navigation.addListener(
      'focus',
      this.loadTasks,
    );
  };

  componentWillUnmount() {
    // Remover o listener ao desmontar o componente
    if (this.focusListener) {
      this.focusListener();
    }
  }

  componentDidUpdate(prevProps, prevState) {
    // Atualiza a lista visível ao mudar o estado das tarefas
    if (prevState.tasks !== this.state.tasks) {
      this.filterTasks();
    }
  }

  loadTasks = async () => {
    try {
      const maxDate = moment()
        .add(this.props.daysAhead, 'days')
        .endOf('day')
        .toISOString();

      const res = await axios.get(`${server}/tasks?date=${maxDate}`);
      this.setState({tasks: res.data}, this.filterTasks);
    } catch (e) {
      showError(e);
    }
  };

  toggleFilter = () => {
    this.setState({showDoneTasks: !this.state.showDoneTasks}, this.filterTasks);
  };

  toggleTask = async taskId => {
    try {
      await axios.put(`${server}/tasks/${taskId}/toggle`);
      await this.loadTasks();
    } catch (e) {
      showError(e);
    }
  };

  filterTasks = () => {
    let visibleTasks = null;
    if (this.state.showDoneTasks) {
      visibleTasks = [...this.state.tasks];
    } else {
      visibleTasks = this.state.tasks.filter(task => task.doneAt === null);
    }
    this.setState({visibleTasks: visibleTasks});
    AsyncStorage.setItem(
      'tasksState',
      JSON.stringify({
        showDoneTasks: this.state.showDoneTasks,
      }),
    );
  };

  addTask = async newTask => {
    if (!newTask.desc || !newTask.desc.trim()) {
      Alert.alert('Dados Inválidos', 'Descrição não informada');
      return;
    }
    try {
      await axios.post(`${server}/tasks`, {
        desc: newTask.desc,
        estimateAt: newTask.date,
      });
      this.setState({showAddTask: false}, this.loadTasks);
    } catch (e) {
      showError(e);
    }
  };

  deleteTask = async taskId => {
    try {
      await axios.delete(`${server}/tasks/${taskId}`);
      this.loadTasks();
    } catch (e) {
      showError(e);
    }
  };

  getImage = () => {
    switch (this.props.daysAhead) {
      case 0:
        return todayImage;
      case 1:
        return tomorrowImage;
      case 7:
        return weekImage;
      default:
        return monthImage;
    }
  };

  getColor = () => {
    switch (this.props.daysAhead) {
      case 0:
        return commonStyles.colors.today;
      case 1:
        return commonStyles.colors.tomorrow;
      case 7:
        return commonStyles.colors.week;
      default:
        return commonStyles.colors.month;
    }
  };

  render() {
    const today = moment().locale('pt-br').format('ddd, D [de] MMMM');
    return (
      <GestureHandlerRootView>
        <View style={styles.container}>
          <AddTask
            isVisible={this.state.showAddTask}
            onCancel={() => this.setState({showAddTask: false})}
            onSave={this.addTask}
          />

          <ImageBackground style={styles.background} source={this.getImage()}>
            <View style={styles.iconBar}>
              <TouchableOpacity
                onPress={() => this.props.navigation.openDrawer()}>
                <Icon
                  name="menu"
                  size={30}
                  color={commonStyles.colors.secondary}
                />
              </TouchableOpacity>
              <TouchableOpacity onPress={this.toggleFilter}>
                <Icon
                  name={this.state.showDoneTasks ? 'eye' : 'eye-off'}
                  size={30}
                  color={commonStyles.colors.secondary}
                />
              </TouchableOpacity>
            </View>
            <View style={styles.titleBar}>
              <Text style={styles.title}>{this.props.title}</Text>
              <Text style={styles.subTitle}>{today}</Text>
            </View>
          </ImageBackground>

          <View style={styles.taskList}>
            <FlatList
              data={this.state.visibleTasks}
              keyExtractor={item => item.id.toString()}
              renderItem={obj => (
                <Task
                  {...obj.item}
                  onToggleTask={this.toggleTask}
                  onDelete={this.deleteTask}
                />
              )}
            />
          </View>

          <TouchableOpacity
            activeOpacity={0.7}
            style={[styles.addButton, {backgroundColor: this.getColor()}]}
            onPress={() => this.setState({showAddTask: true})}>
            <Icon name="add" size={25} color={commonStyles.colors.secondary} />
          </TouchableOpacity>
        </View>
      </GestureHandlerRootView>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: 'white',
  },
  background: {
    flex: 3,
  },
  taskList: {
    flex: 7,
  },
  titleBar: {
    flex: 1,
    justifyContent: 'flex-end',
  },
  title: {
    fontFamily: commonStyles.fontFamily,
    color: commonStyles.colors.secondary,
    fontSize: 50,
    marginLeft: 20,
    marginBottom: 20,
  },
  subTitle: {
    fontFamily: commonStyles.fontFamily,
    color: commonStyles.colors.secondary,
    fontSize: 20,
    marginLeft: 20,
    marginBottom: 20,
  },
  iconBar: {
    flexDirection: 'row',
    marginHorizontal: 20,
    justifyContent: 'space-between',
    marginTop: Platform.OS === 'ios' ? 40 : 10,
  },
  addButton: {
    position: 'absolute',
    right: 30,
    bottom: 30,
    width: 50,
    height: 50,
    borderRadius: 25,
    alignItems: 'center',
    justifyContent: 'center',
  },
});
