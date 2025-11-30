// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract UserStorage {
    struct User {
        string name;
        uint8 age;
    }

    mapping(address => User) public users;

    function updateUser(string calldata newName, uint8 newAge) public {
        users[msg.sender] = User(newName, newAge);
    }

    function getUser(address addr) public view returns (string memory, uint8) {
        User memory user = users[addr];
        return (user.name, user.age);
    }
}