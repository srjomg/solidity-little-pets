// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {UserStorage} from "src/basics/UserStorage/UserStorage.sol";

contract UserStorageTest is Test {
    UserStorage public userstorage;

    function setUp() public {
        userstorage = new UserStorage();
    }

    function test_UpdateAndGetUser() public {
        address creator = address(0x11111);
        string memory creatorName = "Alex";
        uint8 creatorAge = 25;

        vm.deal(creator, 1 ether);
        vm.startPrank(creator);
        userstorage.updateUser(creatorName, creatorAge);

        (string memory actualName, uint8 actualAge) = userstorage.getUser(creator);
        assertEq(actualName, creatorName);
        assertEq(actualAge, creatorAge);

        vm.stopPrank();
    }
}
