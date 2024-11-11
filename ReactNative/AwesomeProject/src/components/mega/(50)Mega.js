import React, { Component } from 'react'
import { Button, Text, TextInput, View } from 'react-native'
import Estilo from '../Estilo'
import Numero from './Numero'

export default class Mega extends Component {
    state = {
        qtdeNumeros: (this.props.qtdeNumeros + 2),
        numeros: []
    }


    alterarQtdeNumero = (qtde) => {
        this.setState({ qtdeNumeros: qtde })
    }

    gerarNumeroNaoContido = nums => {
        const novo = parseInt(Math.random() * 60) + 1
        return nums.includes(novo) ? this.gerarNumeroNaoContido(nums) : novo
    }

    gerarNumeros = () => {
        const {qtdeNumeros} = this.state
        const numeros = []
        for(let i = 0;i<qtdeNumeros;i++){
            numeros.push(this.gerarNumeroNaoContido(numeros))
        }
        numeros.sort((a,b) => a - b)
        this.setState({numeros})
    }

    exibirNumeros = () => {
        const nums = this.state.numeros
        return nums.map(num =>{
            return <Numero num = {num}></Numero>
        })
    }

    render() {
        return (
            <>
                <Text style={Estilo.txtG}>
                    Gerador de Mega-Sena
                </Text>
                <TextInput
                    keyboardType={'numeric'}
                    style={{ borderBottomWidth: 1 }}
                    placeholder='Digite aqui'
                    value={this.state.qtdeNumeros}
                    onChangeText={qtde => this.alterarQtdeNumero(qtde)}
                />
                <Button title='Gerar' onPress={this.gerarNumeros}></Button>
                <View style={{
                    marginTop: 20,
                    flexDirection:'row',
                    flexWrap:'wrap',
                    justifyContent:'center'
                }}>
                    {this.exibirNumeros()}
                </View>
            </>
        )
    }
}
