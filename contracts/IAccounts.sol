// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

interface IAccounts is IERC721 {
    function mint(address receiver, uint amount) external;

    function signUp(string memory accountURI, uint256 accountID) external;

    function signIn(uint256 accountID) external view returns (string memory);

    function deleteAccount(uint accountID) external;

    function changeAddressBookAddress(address _addressBookAddress) external;
}
