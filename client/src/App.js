import React, { Component } from 'react';
import Web3 from 'web3';

import './App.css';
import Fabrica from './abis/Fabrica.json';
import Dashboard from './components/dashboard/Dashboard';

class App extends Component{
  constructor(props) {
    super(props)
    this.state = {
      account: '',
      blockchain: null,
      postcount: -1
    }
  }

  async componentDidMount(){
    if (window.ethereum) {
      window.web3 = new Web3(window.ethereum);

      await window.ethereum.enable();
    }
    else if (window.web3) {
      window.web3 = new Web3(window.web3.currentProvider);
    }
    else {
      window.alert('Non-Ethereum browser detected. You should consider trying MetaMask!');
    }

    const web3 = window.web3;

    const accounts = await web3.eth.getAccounts();
    this.setState({ account: accounts[0] });

    const networkId = await web3.eth.net.getId();
    const networkData = Fabrica.networks[networkId];

    if(networkData){
      const abi = Fabrica.abi;
      const address = Fabrica.networks[networkId].address;

      const blockchain = new web3.eth.Contract(abi, address);
      this.setState({ blockchain });

      const postcount = await blockchain.methods.currentId().call();
      this.setState({ postcount });
    }else{
      window.alert('Contract is not deployed to detected network')
    }
  }
  render(){
    return (
      <div className="App">
        <Dashboard
          blockchain={this.state.blockchain}
          postcount={this.state.postcount} />
      </div>
    );
  }
}

export default App;
