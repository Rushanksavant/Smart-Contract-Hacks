// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.1;

contract Victim{
    mapping(address => uint) public balances;

    receive() external payable{

    }

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() external {
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
