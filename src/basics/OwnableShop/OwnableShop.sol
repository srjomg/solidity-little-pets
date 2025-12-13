// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;


contract Ownable {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(
            msg.sender == owner,
            "Only owner can do that."
        );
        _;
    }
}

contract OwnableShop is Ownable {
    uint256 public fee;
    mapping(uint256 id => uint256 price) public products;

    constructor(uint256 initFee) {
        fee = initFee;
    }

    function editProduct(uint256 id, uint256 price) public onlyOwner {
        products[id] = price;
    }

    function editFee(uint256 newFee) public onlyOwner {
        fee = newFee;
    }

    function buy(uint256 id) public payable {
        require(
            products[id] != 0,
            "The product doesn't exists."
        );

        require(
            msg.value == products[id] + fee,
            "Not enough money sent."
        );
    }
}