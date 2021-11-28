
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;


contract RevertContract {
    uint errorCount;

    function errorFunction() public pure {
        revert("reverting...");
    }
}