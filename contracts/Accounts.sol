// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
interface TokenInterface {
  function mint(address userAddress,uint256 amount) external ;
}

contract Accounts is ERC721URIStorage,Ownable {
    
    TokenInterface TI;
    
    constructor() ERC721("Game Profile Token","GPT"){
        
    }
    
    function signUp(string memory accountURI, uint256 accountID) external{
        _safeMint(_msgSender(), accountID);
        _setTokenURI(accountID, accountURI);
        TI.mint(msg.sender, 100);
    }
    
    function AddTIAddress(address tokenAddress) public onlyOwner{
        TI = TokenInterface(tokenAddress);
    }
    
    function signIn(uint256 accountID) external view returns (string memory){
        require(_isApprovedOrOwner(_msgSender(), accountID), "Accounts: caller is not owner nor approved");
        return tokenURI(accountID);
    }
    
    function deleteAccount(uint accountID) external {
        require(_isApprovedOrOwner(_msgSender(), accountID), "Accounts: caller is not owner nor approved");
        _burn(accountID);
    }
    
}