// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

interface RandomInterface {
  function getRandomNumber(uint256 userProvidedSeed) external returns (bytes32);
  function randomNumber() external view returns(uint256);
}

interface AccountInterface{
    function ownerOf(uint256 tokenId) external view returns (address);
}

contract CryptoMafiaCoin is ERC20, Ownable {
    address private _accountsHolder;
    
    address addressRandomGenerator;
    
    address contractAddress;
    
    RandomInterface RNG;
    
    AccountInterface AI;
    
    mapping(uint256=>uint256) roomStake;
    mapping(uint256=>mapping(uint256=>address)) playerID;
    mapping(uint256=>uint256) roomRandomNumber;
    mapping(uint256=>bool) randomNumIsTaken;
    
    constructor(address accountsHolder, uint256 initialSupply) ERC20("Crypto Mafia Coin Test", "CMC") {
        _mint(_msgSender(), initialSupply);
        _accountsHolder = accountsHolder;
        contractAddress = address(this);
        RequestRandomNumberCMC(0);
    }
    
    
    function setAccountAddress(address accountAddress) public {
        AI = AccountInterface(accountAddress);
    }
    
    function setRandomAddress(address accountAddress) public {
        RNG = RandomInterface(accountAddress);
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
    
    function createRoom(uint256 roomId) public {
        uint256 randomNum = GetRandomNumberCMC();
        require(randomNumIsTaken[randomNum] != true);
        roomRandomNumber[roomId] = randomNum;
        randomNumIsTaken[randomNum] = true;
        RequestRandomNumberCMC(roomId);
    }
    
    function getRandom(uint256 roomId) public view returns(uint256){
        return roomRandomNumber[roomId];
    }
    
    function joinRoom(uint256 roomId) public payable
    {   
        transfer(contractAddress,10);
        roomStake[roomId] = roomStake[roomId] + 10;
    }
    
    
    function distributeCoins(uint256 roomId, uint256[] memory playerId) public 
    {
        uint j;
        uint len = playerId.length;
        uint256 disbursalAmount;
        
        disbursalAmount = roomStake[roomId]/len;
        for (j = 0; j < len; j ++) {  
            increaseAllowance(AI.ownerOf(playerId[j]),disbursalAmount);
      }
      
      gameOver(roomId);
    }
    
    function gameOver(uint256 roomId) public{
        delete roomStake[roomId];
        delete randomNumIsTaken[roomRandomNumber[roomId]];
    } 
    
    function signUpReward(address userAddress,uint256 amount) public {
        _mint(userAddress,amount);
    }
    
    
}
