// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;


interface ErrorContract {
    function errorFunction() external;
}
contract TryCatch {

    ErrorContract errorContract;
    uint errorCount;

    constructor(ErrorContract _errorContract){
        errorContract = _errorContract;
    }

    function setErrorContract(ErrorContract _errorContract) public {
        errorContract = _errorContract;
    }

    function resetCount() public {
        errorCount = 0;
    }

    function TryFunction() public returns (uint value, bool success) {
        require(errorCount < 10);
        try errorContract.errorFunction() {
            return (0, true);
        } catch Error(string memory /*reason*/) {
            errorCount++;
            return (0, false);
        } catch (bytes memory /*lowLevelData*/) {
            errorCount++;
            return (0, false);
        }
    }
}


