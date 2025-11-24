// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {stdError} from "forge-std/StdError.sol";
import {Counter} from "src/basics/Counter/Counter.sol";

contract CounterTest is Test {
    Counter public counter;

    function setUp() public {
        counter = new Counter();
    }

    function test_InitialCount() public view {
        assertEq(counter.count(), 0);
    }

    function test_InitialCyclical() public view {
        assertEq(counter.cyclical(), false);
    }

    function test_SetCount() public {
        uint256 newCount = 999999;
        counter.setCount(newCount);
        
        assertEq(counter.count(), newCount);
    }

    function test_NotCyclicalIncrement() public {
        uint256 initCount = 123;
        counter.setCount(initCount);

        counter.increment();

        assertEq(counter.count(), initCount + 1);
    }

    function test_NotCyclicalDecrement() public {
        uint256 initCount = 123;
        counter.setCount(initCount);

        counter.decrement();

        assertEq(counter.count(), initCount - 1);
    }

    function test_CyclicalIncrement() public {
        counter.setCyclical(true);
        counter.setCount(type(uint256).max);

        counter.increment();

        assertEq(counter.count(), type(uint256).min);
    }

    function test_CyclicalDecrement() public {
        counter.setCyclical(true);
        counter.setCount(type(uint256).min);

        counter.decrement();

        assertEq(counter.count(), type(uint256).max);
    }
}
