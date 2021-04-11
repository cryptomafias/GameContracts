// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./IAccounts.sol";
import "./IAddressBook.sol";

contract CryptoMafiaCoin is ERC20, Ownable {

    address public addressBookAddress;

    constructor(uint256 initialSupply) ERC20("Crypto Mafia Coin Test", "CMC") {
        _mint(_msgSender(), initialSupply);
    }

    modifier onlyAccountsContract() {
        address GPTAddress = IAddressBook(addressBookAddress).getGPTAddress();
        require(GPTAddress == _msgSender(), "CryptoMafiaCoin: caller is not the accounts contract");
        _;
    }

    modifier onlyGameMaster() {
        address GMAddress = IAddressBook(addressBookAddress).getGMAddress();
        require(GMAddress == _msgSender(), "CryptoMafiaCoin: caller is not the Game Master");
        _;
    }

    function changeAddressBookAddress(address _addressBookAddress) public onlyOwner {
        addressBookAddress = _addressBookAddress;
    }

    function joinRoom() public {
        transfer(address(this), 10);
    }

    function distributeReward(uint256[] memory playerIds) public onlyGameMaster {
        uint256 len = playerIds.length;
        uint256 disbursalAmount;
        address GPTAddress = IAddressBook(addressBookAddress).getGPTAddress();
        IAccounts GPT = IAccounts(GPTAddress);

        disbursalAmount = 80 / len;
        for (uint j = 0; j < len; j ++) {
            increaseAllowance(GPT.ownerOf(playerIds[j]), disbursalAmount);
        }
    }
}
