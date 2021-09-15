// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract LovePortal {
    uint256 totalLoves;
    uint256 private seed;

    event NewLove(address indexed from, uint256 timestamp, string message);

    struct Love {
        address sender;
        string message;
        uint256 timestamp;
    }

    Love[] loves;

    mapping(address => uint256) public lastSendLoveAt;

    constructor() payable {
        console.log("Love constructor");
    }

    function sendLove(string memory _message) public {
        //check for 15 minutes to next love
        require(
            lastSendLoveAt[msg.sender] + 15 minutes < block.timestamp,
            "Wait 15m"
        );

        //update the current stamp
        lastSendLoveAt[msg.sender] = block.timestamp;

        totalLoves += 1;
        console.log("%s send love & msg: %s", msg.sender, _message);

        //save into the array
        loves.push(Love(msg.sender, _message, block.timestamp));

        emit NewLove(msg.sender, block.timestamp, _message);

        /*
        uint256 randomNumber = (block.difficulty + block.timestamp + seed) %
            100;
        console.log("Random # generated %s", randomNumber);

        seed = randomNumber;
        if (randomNumber < 50) {
            // Send prize
            uint256 prizeAmount = 0.000001 ether;
            require(
                prizeAmount <= address(this).balance,
                "trying to withraw more money to the contract has"
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contact.");
        }
        */
    }

    function getAllLoves() public view returns (Love[] memory) {
        return loves;
    }

    function getTotalLoves() public view returns (uint256) {
        console.log("total loves: %d", totalLoves);
        return totalLoves;
    }
}
