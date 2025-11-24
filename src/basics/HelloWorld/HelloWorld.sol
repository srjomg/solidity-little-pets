// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract HelloWorld {
    string text;

    constructor() {
        text = "Hello, World!";
    }

    function setText(string calldata newText) public {
        text = newText;
    }
}