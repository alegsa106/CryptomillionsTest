module.exports = {
  networks: {
    development: {
      host: 'localhost',
      port: 7545,
      network_id: '*',
      gas: 100000000
    }
  }
}

/*
const HDWalletProvider = require('truffle-hdwallet-provider');

const mnemonic = 'spider noodle pull annual legal they front cabbage taste music elephant patient';

module.exports = {
  networks: {
    development: {
      host: 'localhost',
      port: 7545,
      network_id: '*',
      gas: 5000000
    },

    rinkeby: {
      provider: () => new HDWalletProvider(mnemonic, "https://rinkeby.infura.io/6f16f0b6f81c44c096abe4beaa6eb090"),
      network_id: 4
    }
  }
}
*/