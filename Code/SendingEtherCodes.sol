


//  Self Destruct
//  1.Self Destruct
// When the donate function is called, trigger a selfdestruct in the contract!


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    address public owner;
    address public charity;

    constructor(address _charity) {
        owner = msg.sender;
        charity = _charity;
    }

    receive() external payable {
       
    }

    function tip() public payable {
        (bool sent, ) = owner.call{ value: msg.value }("");
        require(sent, "Failed to send Ether to owner");
    }

    function donate() public {
        require(address(this).balance > 0, "No funds to donate");

    
        selfdestruct(payable(charity));
    }
};
