// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.1;

contract VictimGaurded{
    mapping(address => uint) public balances;
    bool internal lock;

    modifier ReentrancyGaurd() {
        require(!lock, "Bad luck Attacker!");
        lock = true;
        _;
        lock = false;
    }

    receive() external payable{

    }

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() external ReentrancyGaurd {
        uint bal = balances[msg.sender];
        require(bal > 0, "Your acc balance zero!");

        (bool sent,) = msg.sender.call{value: bal}("");
        require(sent == true, "Send failed");

        balances[msg.sender] =0;
    }

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
}
