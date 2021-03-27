// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract Accounts is ERC721URIStorage {
    
    constructor() ERC721("Game Profile Token","GPT"){}
    
    function signUp(string memory accountURI, uint256 accountID) external returns (uint256){
        _safeMint(msg.sender, accountID);
        _setTokenURI(accountID,accountURI);
        return accountID;
    }
    
    function signIn(uint256 accountID) external view returns (bool){
        if(_exists(accountID)){
            return true;
        }
        return false;
    }
    
    function deleteAccount(uint accountID) external {
        require(_isApprovedOrOwner(_msgSender(), accountID), "ERC721Burnable: caller is not owner nor approved");
        _burn(accountID);
    }
    
}