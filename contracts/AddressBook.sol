// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// In future make it proxy contract so address don't change
contract AddressBook {
    address public CMCAddress;
    address public GPTAddress;
    address public RNGAddress;
    address public GMAddress;

    constructor(address _CMCAddress, address _GPTAddress, address _RNGAddress, address _GMAddress) {
        CMCAddress = _CMCAddress;
        GPTAddress = _GPTAddress;
        RNGAddress = _RNGAddress;
        GMAddress = _GMAddress;
    }

    function getCMCAddress() public view returns (address) {
        return CMCAddress;
    }

    function getGPTAddress() public view returns (address) {
        return GPTAddress;
    }

    function getRNGAddress() public view returns (address) {
        return RNGAddress;
    }

    function getGMAddress() public view returns (address) {
        return GMAddress;
    }
}
