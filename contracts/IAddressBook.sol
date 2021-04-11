// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IAddressBook {
    function getCMCAddress() external view returns (address);

    function getGPTAddress() external view returns (address);

    function getRNGAddress() external view returns (address);

    function getGMAddress() external view returns (address);
}
