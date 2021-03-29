// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

// Matic Mumbai: 0xB4341D98e12B6e93dcf231dd615B16d8b208C83c
contract Accounts is ERC721URIStorage {
    
    constructor() ERC721("Game Profile Token","GPT"){}
    
    function signUp(string memory accountURI, uint256 accountID) external{
        _safeMint(_msgSender(), accountID);
        _setTokenURI(accountID, accountURI);
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