const Migrations = artifacts.require("Migrations");
const Playground = artifacts.require("Playground");

module.exports = function (deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(Playground);  

};
