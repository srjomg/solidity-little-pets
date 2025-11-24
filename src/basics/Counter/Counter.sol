// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Counter {
    uint256 public count = 0;
    bool public cyclical = false;

    function setCount(uint256 newCount) public {
        count = newCount;
    }

    function setCyclical(bool newCyclical) public {
        cyclical = newCyclical;
    }

    function increment() public {
        if (cyclical) {
            if (count == type(uint256).max) {
                count = 0;
                return;
            }
        }

        require(count < type(uint256).max, "Counter cannot be SO big");
        count++;
    }

    function decrement() public {
        if (cyclical) {
            if (count == type(uint256).min) {
                count = type(uint256).max;
                return;
            }
        }

        require(count > type(uint256).min, "Counter cannot be negative");
        count--;
    }
}