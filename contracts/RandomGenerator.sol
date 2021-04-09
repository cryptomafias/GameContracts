// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "@chainlink/contracts/src/v0.6/VRFConsumerBase.sol";


contract RandomGenerator is VRFConsumerBase  {
    
    bytes32 internal keyHash;
    uint256 internal fee;
    
    mapping (uint256=>uint256) randomResult; //room number to random number
    
    address private _owner;

    mapping(bytes32=>uint256) roomRequest; //request ID to room number
    

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * Constructor inherits VRFConsumerBase
     * 
     * Network: Mumbai Testnet
     * Chainlink VRF Coordinator address: 0x8C7382F9D8f56b33781fE506E897a4F1e2d17255
     * LINK token address:                0x326C977E6efc84E512bB9C30f76E30c160eD06FB
     * Key Hash: 0x6e75b569a01ef56d18cab6a8e71e6600d6ce853834d4a5748b720d06f878b3a4
     */
    constructor() 
        VRFConsumerBase(
            0x8C7382F9D8f56b33781fE506E897a4F1e2d17255, // VRF Coordinator
            0x326C977E6efc84E512bB9C30f76E30c160eD06FB  // LINK Token
        ) public
    {
        keyHash = 0x6e75b569a01ef56d18cab6a8e71e6600d6ce853834d4a5748b720d06f878b3a4;
        fee = 0.0001 * 10 ** 18; // 0.0001 LINK (varies by network)
        address msgSender = msg.sender;
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }
    
    modifier onlyOwner() {
        require(_owner == msg.sender, "Ownable: caller is not the owner");
        _;
    }
    
    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }
    
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
    
    function getRandomNumber(uint256 userProvidedSeed,uint256 roomId) public returns (bytes32 requestId) {
        require(LINK.balanceOf(address(this)) >= fee, "Not enough LINK - fill contract with faucet");
        bytes32 reqId = requestRandomness(keyHash, fee, userProvidedSeed);
        roomRequest[reqId] = roomId; 
        return reqId;
    }

    /**
     * Callback function used by VRF Coordinator
     */
     
    function fulfillRandomness(bytes32 requestId, uint256 randomness) internal override {
        randomResult[roomRequest[requestId]] = randomness;
}

    function randomNumber(uint256 roomNumber) public view returns(uint256){
        return randomResult[roomNumber];
    }
    
    
}