var Poll = artifacts.require("./Poll.sol");

module.exports = function(deployer) {
  deployer.deploy(Poll);
};
