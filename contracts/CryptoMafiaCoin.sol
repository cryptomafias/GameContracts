// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

interface RandomInterface {
  function getRandomNumber(uint256 userProvidedSeed) external returns (bytes32);
  function randomNumber() external view returns(uint256);
}

contract CryptoMafiaCoin is ERC20, Ownable {
    address private _accountsHolder;
    
    address addressRandomGenerator;
    
    address contractAddress;
    
    RandomInterface RNG;
    
    mapping(uint256=>uint256) roomStake;
    mapping(uint256=>mapping(uint256=>address)) playerID;
    
    
    constructor(address accountsHolder, uint256 initialSupply) ERC20("Crypto Mafia Coin Test", "CMC") {
        _mint(_msgSender(), initialSupply);
        _accountsHolder = accountsHolder;
        RNG = RandomInterface(0x3635b24a11E8dE3F2246847cC0c55658344Ae0C7); 
        contractAddress = address(this);
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
    
    
    function RequestRandomNumberCMC(uint256 seed) public returns(bytes32){
        return RNG.getRandomNumber(seed);
        
    }
    
    function GetRandomNumberCMC() public view returns(uint256) {
        return RNG.randomNumber();
    }
    
    
    function joinRoom(uint256 roomId, uint256 playerId,uint256 amount) public payable
    {
        playerID[roomId][playerId] = msg.sender;
        transfer(contractAddress,amount);
        roomStake[roomId] = roomStake[roomId] + amount;
    }
    
    
    function distributeCoins(uint256 roomId, uint256[] memory playerId) public 
    {
        uint j;
        uint len = playerId.length;
        uint256 disbursalAmount;
        
        disbursalAmount = roomStake[roomId]/len;
        for (j = 0; j < len; j ++) {  
            
            increaseAllowance(playerID[roomId][playerId[j]],disbursalAmount);
            delete playerID[roomId][playerId[j]];
      }
    }
    
    function deductCoins(uint256 roomId, uint256[] memory playerId) public 
    {
        uint j;
        uint len = playerId.length;
        uint256 deductionAmount;
        deductionAmount = roomStake[roomId]/8;
        for (j = 0; j < len; j ++) {  
            
            decreaseAllowance(playerID[roomId][playerId[j]],deductionAmount);
            delete playerID[roomId][playerId[j]];
      }
    }
    
    function gameOver(uint256 roomId) public{
        delete roomStake[roomId];
    } 
}
