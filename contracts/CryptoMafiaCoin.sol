// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

interface RandomInterface {

  function getRandomNumber(uint256 seed,uint256 roomId) external returns (bytes32);
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
    
    address gameMaster;
    
    
    constructor(uint256 initialSupply) ERC20("Crypto Mafia Coin Test", "CMC") {
        _mint(_msgSender(), initialSupply);
        contractAddress = address(this);

    }
    
    
    function setAccountAddress(address accountAddress) public onlyOwner{
        AI = AccountInterface(accountAddress);

        _accountsHolder = accountAddress;
    }
    
    function setRandomAddress(address accountAddress) public onlyOwner{
        RNG = RandomInterface(accountAddress);

    }
    
    function setGameMasterAddress(address accountAddress) public onlyOwner{
        gameMaster = accountAddress;
    }

    modifier onlyAccountsHolder() {
        require(_accountsHolder == _msgSender(), "CryptoMafiaCoin: caller is not the accountsHolder contract");
        _;
    }
    
    modifier onlyGameMaster() {
        require(gameMaster == _msgSender(), "CryptoMafiaCoin: caller is not the Game Master");
        _;
    }

    function mint(address receiver, uint amount) onlyAccountsHolder public {
        _mint(receiver, amount);
    }
    
    

    function RequestRandomNumberCMC(uint256 roomId) public returns(bytes32){
        uint256 seed = uint256(blockhash(block.number-1));
        return RNG.getRandomNumber(seed,roomId);

        
    }
    
    function GetRandomNumberCMC(uint256 roomId) public view returns(uint256) {
        return RNG.randomNumber(roomId);
    }
    

    function joinRoom() public payable
    {   
        transfer(contractAddress,10);
    }
    
    

    function distributeCoins(uint256[] memory playerId) public onlyGameMaster

    {
        uint j;
        uint len = playerId.length;
        uint256 disbursalAmount;
        
        disbursalAmount = 80/len;
        for (j = 0; j < len; j ++) {  
            increaseAllowance(AI.ownerOf(playerId[j]),disbursalAmount);
      }
      
     
    }
    
    
}
