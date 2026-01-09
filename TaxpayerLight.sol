pragma solidity ^0.8.22;
// SPDX-License-Identifier: UNLICENSED

//import "./Lottery.sol";

contract Taxpayer {
  uint age; 
  bool ismarried; 
  bool iscontract;
  address spouse; // Reference to spouse if person is married, address(0) otherwise

  address  parent1; 
  address  parent2; 

  uint constant  DEFAULT_ALLOWANCE = 5000; // Constant default income tax allowance
  uint constant ALLOWANCE_OAP = 7000; // Constant income tax allowance for Older Taxpayers over 65
  uint tax_allowance; // Income tax allowance
  uint income; 
  uint256 rev;

  //Parents are taxpayers
  constructor() {
    age = 0;
    ismarried = false;
    parent1 = address(0);
    parent2 = address(0);
    spouse = address(0);
    income = 0;
    tax_allowance = DEFAULT_ALLOWANCE;
    iscontract = true;
  } 
  function isMarried() public view returns (bool) {
    return ismarried;
  }
  function getSpouse() public view returns (address) {
    return spouse;
  }

  // We require new_spouse != address(0);
  function marry(address new_spouse) public {
    require(new_spouse != address(0)); require(Taxpayer(new_spouse).isContract());
    require(new_spouse != address(this));
    Taxpayer s = Taxpayer(spouse);
    address s_spouse = s.getSpouse();
    require(s_spouse == address(0) || s_spouse == address(this));

    spouse = new_spouse;
    ismarried = true;
    if (!s.isMarried()) {
      s.marry(address(this));
    }
  }
 
  function divorce() public {
    Taxpayer s = Taxpayer(spouse);
    spouse = address(0);
    ismarried = false;

    if (s.isMarried()) { s.divorce(); }
  }

  /* Transfer part of tax allowance to own spouse */
  // function transferAllowance(uint change) public {
  //   tax_allowance = tax_allowance - change;
  //   Taxpayer sp = Taxpayer(address(spouse));
  //   sp.setTaxAllowance(sp.getTaxAllowance()+change);
  // }

  function haveBirthday() public {
    age++;
  }
 
  // function setTaxAllowance(uint ta) public {
  //   require(Taxpayer(msg.sender).isContract() || Lottery(msg.sender).isContract());
  //   tax_allowance = ta;
  // }
  function getTaxAllowance() public view returns(uint) {
    return tax_allowance;
  }

  // Taxpayer(NULL) is casted to 0
  function getDefaultAllowance() public view returns (uint) {
    return age < 65 ? DEFAULT_ALLOWANCE : ALLOWANCE_OAP;
  }
  function isContract() public view returns(bool){
    return iscontract;
  }

  // function joinLottery(address lot, uint256 r) public {
  //   Lottery l = Lottery(lot);
  //   l.commit(keccak256(abi.encode(r)));
  //   rev = r;
  // }
  //  function revealLottery(address lot, uint256 r) public {
  //   Lottery l = Lottery(lot);
  //   l.reveal(r);
  //   rev = 0;
  // }

  function echidna_check_spouse_exists() public view returns (bool) {
    return (!ismarried || ismarried && spouse != address(0)); 
  }
  function echidna_single_spouse_is_null() public view returns (bool) {
    return (ismarried || spouse == address(0));
  }
  function echidna_is_contract() public view returns (bool) {
    return (iscontract);
  }
  function echidna_spouse_is_taxpayer() public view returns (bool) {
    return (!ismarried || Taxpayer(spouse).isContract());
  }
  function echidna_cant_marry_self() public view returns (bool) {
    return (spouse != address(this));
  }
}
