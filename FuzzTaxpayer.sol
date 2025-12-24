pragma solidity ^0.8.22;
// SPDX-License-Identifier: UNLICENSED

import "./Taxpayer.sol";

contract FuzzTaxpayer is Taxpayer {
    constructor() Taxpayer(address(1), address(2)) {}

    // If person is married to someeone, that someone mustn't be NULL address
    function echidna_check_spouse_exists() public view returns (bool) {
        return (!isMarried || isMarried && spouse != address(0)); 
    }

    // isContract should always be true
    function echidna_is_contract() public view returns (bool) {
        return (iscontract);
    }
}