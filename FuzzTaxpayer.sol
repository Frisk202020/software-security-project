pragma solidity ^0.8.22;
// SPDX-License-Identifier: UNLICENSED

import "./Taxpayer.sol";

contract FuzzTaxpayer is Taxpayer {
    constructor() Taxpayer(address(0), address(0)) {}

    // If person is married to someeone, that someone mustn't be NULL address
    function echidna_check_spouse_exists() public view returns (bool) {
        return (!isMarried || isMarried && spouse != address(0)); 
    }

    // If person is single, they shoudn't have a spouse
    function echidna_single_spouse_is_null() public view returns (bool) {
        return (isMarried || spouse == address(0));
    }

    // isContract should always be true
    function echidna_is_contract() public view returns (bool) {
        return (iscontract);
    }

    // Ask to teacher for clarifications
    function echidna_parents_are_taxpayer() public view returns (bool) {
        address void = address(0);
        return ((parent1 == void || Taxpayer(parent1).isContract()) && (parent2 == void || Taxpayer(parent2).isContract()));
    }

    function echidna_spouse_is_taxpayer() public view returns (bool) {
        return (!isMarried || Taxpayer(spouse).isContract());
    }

    function echidna_bidirectional_marriage() public view returns (bool) {
        return (!isMarried || getSpouse() == address(this));
    }
}