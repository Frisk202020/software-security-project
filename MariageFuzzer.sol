// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.22;

import "./TaxpayerLight.sol";

contract MarriageFuzzer {
    Taxpayer a;
    Taxpayer b;
    Taxpayer c;

    constructor() {
        a = new Taxpayer(); b = new Taxpayer(); c = new Taxpayer();
    }

    function marryA(address s) public { a.marry(s); }
    function marryB(address s) public { b.marry(s); }
    function marryC(address s) public { c.marry(s); }
    function divorceA() public { a.divorce(); }
    function divorceB() public { b.divorce(); }
    function divorceC() public { c.divorce(); }

    function echidna_bidirectional_marriage() public view returns (bool) {
        if (a.isMarried()) {
            Taxpayer s = Taxpayer(a.getSpouse());
            if (s.getSpouse() != address(a)) { return false; }
        }
        if (b.isMarried()) {
            Taxpayer s = Taxpayer(b.getSpouse());
            if (s.getSpouse() != address(b)) { return false; }
        }
        if (c.isMarried()) {
            Taxpayer s = Taxpayer(a.getSpouse());
            if (s.getSpouse() != address(c)) { return false; }
        }

        return true;
    }
}