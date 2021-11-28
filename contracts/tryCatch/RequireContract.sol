
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;


contract RequireContract {
    uint errorCount;

    function errorFunction() public pure {
        require(false, "Require");
    }
}