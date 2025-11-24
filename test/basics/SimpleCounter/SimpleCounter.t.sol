// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {stdError} from "forge-std/StdError.sol";
import {SimpleCounter} from "src/basics/SimpleCounter/SimpleCounter.sol";

contract SimpleCounterTest is Test {
    SimpleCounter public counter;

    function setUp() public {
        counter = new SimpleCounter();
    }

    function test_InitialCount() public view {
        assertEq(counter.count(), 0);
    }

    function test_SetCount() public {
        uint256 newCount = 999999;
        counter.setCount(newCount);
        assertEq(counter.count(), newCount);
    }

    function test_Increment() public {
        uint256 initCount = 123;
        counter.setCount(initCount);

        counter.increment();

        assertEq(counter.count(), initCount + 1);
    }

    function test_Decrement() public {
        uint256 initCount = 123;
        counter.setCount(initCount);

        counter.decrement();

        assertEq(counter.count(), initCount - 1);
    }

    function test_CannotDecrementBelowMin() public {
        counter.setCount(type(uint256).min);

        vm.expectRevert(stdError.arithmeticError);
        counter.decrement();
    }

    function test_CannotIncrementBeyondMax() public {
        counter.setCount(type(uint256).max);

        vm.expectRevert(stdError.arithmeticError);
        counter.increment();
    }
}
