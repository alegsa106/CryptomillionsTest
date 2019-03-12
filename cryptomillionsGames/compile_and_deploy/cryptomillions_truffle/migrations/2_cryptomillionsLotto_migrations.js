var cryptomillionsLotto = artifacts.require("./cryptomillionsLotto.sol");

module.exports = function(deployer) {
  deployer.deploy(cryptomillionsLotto);
}

/*
var cryptomillionsLotto = artifacts.require("cryptomillionsLotto");
var draw = artifacts.require("draw");

module.exports = function(deployer) {
  deployer.deploy(cryptomillionsLotto);
  deployer.then(function() {
    return cryptomillionsLotto.deployed();
  }).then(function(instance) {
    deployer.deploy(draw, instance.address);// <-- note address here
  });
  }
  */