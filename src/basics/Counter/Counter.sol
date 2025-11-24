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
        uint256 max = type(uint256).max;

        if (cyclical) {
            if (count == max) {
                count = 0;
                return;
            }
        }

        require(count < max, "Counter cannot be SO big");
        count++;
    }

    function decrement() public {
        uint256 min = type(uint256).min;

        if (cyclical) {
            if (count == min) {
                count = type(uint256).max;
                return;
            }
        }

        require(count > 0, "Counter cannot be negative");
        count--;
    }
}