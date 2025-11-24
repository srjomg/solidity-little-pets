// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {HelloWorld} from "src/basics/HelloWorld/HelloWorld.sol";

contract HelloWorldTest is Test {
    HelloWorld public helloworld;

    function setUp() public {
        helloworld = new HelloWorld();
    }

    function test_InitialText() public view {
        assertEq(helloworld.text(), "Hello, World!");
    }

    function test_SetText() public {
        string memory newText = "Testik...";
        helloworld.setText(newText);
        assertEq(helloworld.text(), newText);
    }
}
