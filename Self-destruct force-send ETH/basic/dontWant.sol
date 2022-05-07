// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.1;

contract dontWant { // no payable function, hence can't recieve eth
    function something() external pure returns(uint) {
        return 1;
    }

    function getBalance() external view returns(uint) {
        return address(this).balance;
    }
}
