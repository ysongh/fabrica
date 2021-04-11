const Fabrica = artifacts.require("fabrica");

module.exports = async function(deployer){
	deployer.deploy(Fabrica, 100000000);
};