// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.1;

contract Victim {
    address owner;

    constructor() {
        owner = msg.sender;
    }

    receive() external payable {

    }

    function transfer(address _to, uint amount) external payable {
        require(tx.origin == owner, "Only owner can cause this txn");

        (bool sent,) = _to.call{value: amount}("");
        require(sent, "Send txn failed");
    }

    function getBalance() external view returns(uint) {
        return address(this).balance;
    }
}
