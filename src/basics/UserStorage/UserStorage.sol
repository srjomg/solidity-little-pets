// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract UserStorage {
    struct User {
        string name;
        uint8 age;
        uint256 createTime;
        uint256 updateTime; 
    }

    uint256 userCount;
    mapping(address => User) users;

    function createUser() {
        
    }
}