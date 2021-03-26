pragma solidity ^0.8.0;


import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract Accounts is ERC721URIStorage {
    
    
    
    constructor() public ERC721("Game Profile Token","GPT"){
        
    }
    
    function signUp(string memory accountURI,uint256 AccountId) public returns (uint256){
       
        uint256 newAccountId = AccountId;
        _safeMint(msg.sender,newAccountId);
        _setTokenURI(newAccountId,accountURI);
        
        return newAccountId;
    }
    
    function signIn(uint256 accountID) public view returns (bool)
    {
        if(_exists(accountID))
        {
            return true;
        }
        return false;
    }
    
    function deleteAccount(uint accountID) public {
        burn(accountID);
    }
    
    
    function burn(uint256 accountID) public virtual {
        //solhint-disable-next-line max-line-length
        require(_isApprovedOrOwner(_msgSender(), accountID), "ERC721Burnable: caller is not owner nor approved");
        _burn(accountID);
    }
    
}