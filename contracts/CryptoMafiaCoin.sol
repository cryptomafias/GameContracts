// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

interface RandomInterface {
  function getRandomNumber(uint256 userProvidedSeed) external returns (bytes32);
  function randomNumber(uint256 roomId) external view returns(uint256);
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
    
    
    constructor(address accountsHolder, uint256 initialSupply) ERC20("Crypto Mafia Coin Test", "CMC") {
        _mint(_msgSender(), initialSupply);
        _accountsHolder = accountsHolder;
        contractAddress = address(this);
        
    }
    
    
    function setAccountAddress(address accountAddress) public onlyOwner{
        AI = AccountInterface(accountAddress);
    }
    
    function setRandomAddress(address accountAddress) public onlyOwner{
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
    
    
    function RequestRandomNumberCMC() public returns(bytes32){
        uint256 seed = uint256(blockhash(block.number-1));
        return RNG.getRandomNumber(seed);
        
    }
    
    function GetRandomNumberCMC(uint256 roomId) public view returns(uint256) {
        return RNG.randomNumber(roomId);
    }
    

    function joinRoom() public payable
    {   
        transfer(contractAddress,10);
    }
    
    
    function distributeCoins(uint256[] memory playerId) public 
    {
        uint j;
        uint len = playerId.length;
        uint256 disbursalAmount;
        
        disbursalAmount = 80/len;
        for (j = 0; j < len; j ++) {  
            increaseAllowance(AI.ownerOf(playerId[j]),disbursalAmount);
      }
      
     
    }
    
    
    function signUpReward(address userAddress,uint256 amount) public {
        _mint(userAddress,amount);
    }
    
    
}
