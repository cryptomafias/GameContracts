let Accounts = artifacts.require("Accounts");

module.exports = function (deployer) {
    // deployment steps
    deployer.deploy(Accounts);
};