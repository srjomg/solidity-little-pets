// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Counter {
    uint256 public count;

    constructor() {
        count = 0;
    }

    function setCount(uint256 newCount) public {
        count = newCount;
    }

    function increment() public {
        count++;
    }

    function decrement() public {
        count--;
    }
}