let Accounts = artifacts.require("Accounts");
let CryptoMafiaCoin = artifacts.require("CryptoMafiaCoin");
let RandomNumberGenerator = artifacts.require("RandomNumberGenerator");
let AddressBook = artifacts.require("AddressBook");

module.exports = async function (deployer, network, accounts) {
    // deployment steps
    const GameMasterAddress = accounts[0];

    await Promise.all([
        deployer.deploy(Accounts),
        deployer.deploy(CryptoMafiaCoin, 1000000000),
        deployer.deploy(RandomNumberGenerator)
    ])
    await deployer.deploy(
        AddressBook,
        CryptoMafiaCoin.address,
        Accounts.address,
        RandomNumberGenerator.address,
        GameMasterAddress
    )
    let AccountsInstance = await Accounts.deployed();
    let CryptoMafiaCoinInstance = await CryptoMafiaCoin.deployed();
    let RandomNumberGeneratorInstance = await RandomNumberGenerator.deployed();

    console.log("Initializing contracts with addressBookAddress")
    console.log("==============================================")

    await Promise.all([
        AccountsInstance.changeAddressBookAddress(AddressBook.address),
        CryptoMafiaCoinInstance.changeAddressBookAddress(AddressBook.address),
        RandomNumberGeneratorInstance.changeAddressBookAddress(AddressBook.address)
    ]);
};