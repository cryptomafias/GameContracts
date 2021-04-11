// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IRandomNumberGenerator {
    function requestRandomNumber(uint256 userProvidedSeed, uint256 roomId) external returns (bytes32 requestId);

    function getRandomNumber(uint256 roomNumber) external view returns (uint256);
}
