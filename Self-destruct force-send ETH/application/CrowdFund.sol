// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.1;

contract Crowdfund {
    // this contract only accepts a certain amount of funds
    // if someone tries to send an amount that exceeds contract balance more than the limit, tnx fails
    // funds are transfered to an address only when contract balance equals fund limit

    uint fundLimit = 3 ether;
    bool contractOpen = true;

    function donate() external payable { // for others to donate eth to this contract
        require(contractOpen, "Contract has stopped recieving funds");
        require(address(this).balance <= fundLimit, "Can't send specified amount");
        // note: we cannot do address(this).balance + msg.value, because address(this).balance already takes msg.value
    }

    function getBalance() external view returns(uint) { // to get current balance of this contract
        return address(this).balance;
    } 

    function sendFunds() external { // to send all collected funds
        require(contractOpen, "Contract has stopped recieving funds");
        require(address(this).balance == fundLimit, "Fund limit not reached yet");
        contractOpen = false; // contract closed
        payable(address(0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB)).transfer(address(this).balance);
    }
}
