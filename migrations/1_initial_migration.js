const Migrations = artifacts.require("Migrations");
const WorkAccount = artifacts.require("WorkAccount");

module.exports = function (deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(WorkAccount);  

};
