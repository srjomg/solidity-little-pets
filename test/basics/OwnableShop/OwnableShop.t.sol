// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {OwnableShop} from "src/basics/OwnableShop/OwnableShop.sol";

contract OwnableShopTest is Test {
    OwnableShop public ownableshop;
    address public owner;
    uint256 initialFee = 0.0001 ether;

    function setUp() public {
        owner = address(0x11111);
        vm.deal(owner, 100 ether);

        vm.startPrank(owner);
        ownableshop = new OwnableShop(initialFee);
        ownableshop.editProduct(1, 0.5 ether);
    }

    function test_InitialFee() public view {
        assertEq(initialFee, ownableshop.fee());
    }

    function test_InitialOwner() public view {
        assertEq(ownableshop.owner(), owner);
    }

    function test_EditFeeAsOwner() public {
        uint256 newFee = 9090 ether;

        vm.startPrank(owner);
        ownableshop.editFee(newFee);
        assertEq(newFee, ownableshop.fee());
    }

    function test_EditProductAsOwner() public {
        uint256 id = 123;
        uint256 newPrice = 222 ether;
        
        vm.startPrank(owner);
        ownableshop.editProduct(id, newPrice);
        assertEq(ownableshop.products(id), newPrice);
    }

    function test_CannotEditFeeAsNotOwner() public {
        vm.startPrank(address(0xffff));
        vm.expectRevert("Only owner can do that.");
        ownableshop.editFee(1 ether);
    }

    function test_CannotEditProductAsNotOwner() public {
        vm.startPrank(address(0xffff));
        vm.expectRevert("Only owner can do that.");
        ownableshop.editProduct(1, 1 ether);
    }

    function test_Buy() public {
        address buyer = address(0xffff);
        vm.deal(buyer, 1 ether);

        vm.startPrank(buyer);

        uint256 value_ = 0.5 ether + initialFee;
        ownableshop.buy{value: value_}(1);

        vm.stopPrank();
    }

    function test_CannotBuyBecauseNotEnoughMoneySent() public {
        address buyer = address(0xffff);
        vm.deal(buyer, 1 ether);

        vm.startPrank(buyer);

        vm.expectRevert("Not enough money sent.");
        ownableshop.buy{value: 0.00001 ether}(1);

        vm.stopPrank();
    }

    function test_CannotBuyBecauseProductNotExist() public {
        address buyer = address(0xffff);
        vm.deal(buyer, 1 ether);

        vm.startPrank(buyer);

        vm.expectRevert("The product doesn't exists.");
        ownableshop.buy{value: 0.00001 ether}(999999);

        vm.stopPrank();
    }
}
