// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
  uint256 totalWaves;
  uint256 private seed; // generate a random number

  event NewWave(address indexed from, uint256 timestamp, string message);

  struct Wave {
    address waver;
    string message;
    uint256 timestamp;
  }

  Wave[] waves;

  // associate an address with a number
  // store the address with the last time the user waved at us
  mapping(address => uint256) public lastWavedAt;

  constructor() payable {
    console.log("We have been constructed!");

    // set the initial seed
    seed = (block.timestamp + block.difficulty) % 100;
  }

  function wave(string memory _message) public {
    // make sure the current timestamp is at least 15 minutes bigger
    // than the last timestamp we stored
    require(
      lastWavedAt[msg.sender] + 30 seconds < block.timestamp,
      "Wait 30s"
    );

    // update the current timestamp we have for the user
    lastWavedAt[msg.sender] = block.timestamp;

    totalWaves += 1;
    console.log("%s has waved w/ message %s!", msg.sender, _message);

    waves.push(Wave(msg.sender, _message, block.timestamp));

    // generate a new seed for the next user that sends a wave
    seed = (block.difficulty + block.timestamp + seed) % 100;
    console.log("Random # generated: %d", seed);

    // give a 50% chance that the user wins the prize
    if (seed <= 50) {
      console.log("%s won!", msg.sender);

      uint256 prizeAmount = 0.0001 ether;
      require(
        prizeAmount <= address(this).balance,
        "Trying to withdraw more money than the contract has."
      );
      (bool success, ) = (msg.sender).call{value: prizeAmount}("");
      require(success, "Failed to withdraw money from contract");
    }

    emit NewWave(msg.sender, block.timestamp, _message);
  }

  function getAllWaves() public view returns (Wave[] memory) {
    return waves;
  }

  function getTotalWaves() public view returns (uint256) {
    return totalWaves;
  }
}