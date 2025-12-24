pragma solidity ^0.8.22;
// SPDX-License-Identifier: UNLICENSED

import "./Taxpayer.sol";

contract FuzzTaxpayer is Taxpayer {
    constructor() Taxpayer(address(1), address(2)) {}

    function echidna_check_spouse_exists() public view returns (bool) {
        return (!isMarried || isMarried && spouse != address(0)); 
    }
}