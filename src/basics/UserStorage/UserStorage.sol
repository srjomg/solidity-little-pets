// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

/**
 */
contract UserStorage {
    struct User {
        string name;
        uint8 age;
    }

    mapping(address => User) public users;

    function updateUser(string calldata newName, uint8 newAge) public {
        require(bytes(newName).length > 0, "Name cannot be empty");
        require(newAge > 0, "Age cannot be equal zero");
        users[msg.sender] = User(newName, newAge);
    }

    function getUser(address addr) public view returns (string memory, uint8) {
        User memory user = users[addr];
        if (user.age == 0 && bytes(user.name).length == 0) {
            revert("User don't exist");
        }

        return (user.name, user.age);
    }
}