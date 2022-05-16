// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.1;

contract VictimSafe {
    address owner;

    constructor() {
        owner = msg.sender;
    }

    receive() external payable {

    }

    function transfer(address _to, uint amount) external payable {
        require(msg.sender == owner, "Only owner can cause this txn");
        // changing tx.origin to msg.sender, to avoid phishing attack

        (bool sent,) = _to.call{value: amount}("");
        require(sent, "Send txn failed");
    }

    function getBalance() external view returns(uint) {
        return address(this).balance;
    }
}
