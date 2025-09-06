// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Faucet {
    address public owner;

    uint256 public constant FAUCET_AMOUNT = 1e16; // 0.01 ether

    // The cooldown period between requests.
    uint256 public constant COOLDOWN_PERIOD = 1 days;

    mapping(address => uint256) private lastRequestTime;

    constructor() {
        owner = msg.sender;
    }

    modifier checkCooldown() {
        require(
            block.timestamp >= lastRequestTime[msg.sender] + COOLDOWN_PERIOD,
            "You must wait before requesting again."
        );
        _;
    }

    // A modifier to ensure the contract has enough funds.
    modifier checkBalance() {
        require(
            address(this).balance >= FAUCET_AMOUNT,
            "The faucet is empty. Please check back later."
        );
        _;
    }

    receive() external payable {}

    // A function for a user to request tokens from the faucet.
    function requestTokens() public checkCooldown checkBalance {
  
        (bool sent, ) = msg.sender.call{value: FAUCET_AMOUNT}("");
        require(sent, "Failed to send Ether.");
        lastRequestTime[msg.sender] = block.timestamp;
    }
}