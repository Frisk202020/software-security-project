// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.22;

import "./Taxpayer.sol";

contract MarriageFuzzer {
    Taxpayer a;
    Taxpayer b;

    constructor() {
        a = new Taxpayer(); b = new Taxpayer();
    }

    function marryA(address s) public { a.marry(s); }
    function marryB(address s) public { b.marry(s); }

    function echidna_bidirectional_marriage() public view returns (bool) {
        if (!a.isMarried()) { return true; }
        
        Taxpayer s = Taxpayer(a.getSpouse());
        return (s.getSpouse() == address(a));
    }
}