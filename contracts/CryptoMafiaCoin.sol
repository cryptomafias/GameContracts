// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CryptoMafiaCoin is ERC20, Ownable {
    address private _accountsHolder;

    constructor(address accountsHolder, uint256 initialSupply) ERC20("Crypto Mafia Coin", "CMC") {
        _mint(_msgSender(), initialSupply);
        _accountsHolder = accountsHolder;
    }

    modifier onlyAccountsHolder() {
        require(_accountsHolder == _msgSender(), "CryptoMafiaCoin: caller is not the accountsHolder contract");
        _;
    }

    function changeAccountsHolder(address newAccountHolder) onlyOwner public {
        _accountsHolder = newAccountHolder;
    }

    function mint(address receiver, uint amount) onlyAccountsHolder public {
        _mint(receiver, amount);
    }
}
