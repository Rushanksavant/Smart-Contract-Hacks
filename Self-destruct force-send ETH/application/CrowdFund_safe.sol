// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.1;

contract CrowdFund_safe{
    uint fundLimit = 3 ether;
    bool contractOpen = true;
    uint balance = 0;

    function donate() external payable { // for others to donate eth to this contract
        require(contractOpen, "Contract has stopped recieving funds");
        require(balance + msg.value <= fundLimit, "Can't send specified amount");
        balance += msg.value;
    }

    function getBalance() external view returns(uint) { // to get current balance of this contract
        return address(this).balance;
    } 

    function sendFunds() external { // to send all collected funds
        require(contractOpen, "Contract has stopped recieving funds");
        require(balance == fundLimit, "Fund limit not reached yet");
        contractOpen = false; // contract closed
        payable(address(0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB)).transfer(balance);
    }
}
