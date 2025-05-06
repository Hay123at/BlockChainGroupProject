
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// INHERITANCE
// 1: Inherit

// Make SuperHeroes
// You'll notice that the SuperHeroes.sol file imports the Hero.sol read-only file. Your goal is to create two new contracts that inherit from the base Hero contract.
// 1.	Create two new contracts Mage and Warrior which inherit both the function and the state variable from the Hero contract.

import "./Hero.sol";

// Mage inherits from Hero
contract Mage is Hero {
    // Inherits health variable and attack function from Hero
}

// Warrior inherits from Hero
contract Warrior is Hero {
    // Inherits health variable and attack function from Hero
}


// 2: Constructor Args
// Specific Health 
// You'll notice that the Hero.sol file has changed on this stage! Now it has a constructor which takes a health argument.
// 1.	Let's modify our SuperHeroes so that Warrior has an initial health of 200 while the Mage has an initial health of 50.


import "./Hero.sol";

// Mage inherits from Hero and sets initial health to 50
contract Mage is Hero(50) {
    // Additional Mage-specific logic (if any) can go here
}

// Warrior inherits from Hero and sets initial health to 200
contract Warrior is Hero(200) {
    // Additional Warrior-specific logic (if any) can go here
}

// SuperHero Attacks
// You'll notice the Hero.sol tab has changed once again! This time there's three important things to notice:
// 1.	The Hero contract is an abstract contract. It has a virtual function called attack which we'll need to override in both Warrior and Mage.
// 2.	An enum called AttackTypes has been added to the Hero contract to differentiate between the different types of attacks our heroes can do.
// 3.	There's a contract called Enemy which has a method called takeAttack on it.
// Your job is to implement the attack function on the Warrior and Mage contracts:
// 1.	Add an override function called attack to both the Warrior and Mage contracts. This function should take an Enemy parameter which will be an Enemy contract.
// 2.	Invoke takeAttack function on the Enemy contract and change the parameter based on the hero:
// 1.	For the Warrior, invoke the enemy's takeAttack with the Brawl attack type. 
// 2.	For the Mage, invoke the enemy's takeAttack with the Spell attack type. 


import "./Hero.sol";

// Mage inherits from Hero and sets initial health to 50
contract Mage is Hero(50) {
    // Override attack function for Mage
    function attack(Enemy enemy) override public {
        enemy.takeAttack(AttackTypes.Spell);
    }
}

// Warrior inherits from Hero and sets initial health to 200
contract Warrior is Hero(200) {
    // Override attack function for Warrior
    function attack(Enemy enemy) override public {
        enemy.takeAttack(AttackTypes.Brawl);
    }
}


// 4: Super
// Add the Super!
// The attack function is now implemented by the Hero base contract. It will take the enemy as an argument and decrement energy from our hero after every attack.
// Let's invoke this base contract function from within the attack function for both (derived) hero contracts: Mage and Warrior.


import "./Hero.sol";

// Mage inherits from Hero and sets initial health to 50
contract Mage is Hero(50) {
    // Override attack function for Mage
    function attack(Enemy enemy) override public {
        enemy.takeAttack(AttackTypes.Spell); // Mage-specific behavior
        super.attack(enemy); // Call base Hero logic (e.g., reduce energy)
    }
}

// Warrior inherits from Hero and sets initial health to 200
contract Warrior is Hero(200) {
    // Override attack function for Warrior
    function attack(Enemy enemy) override public {
        enemy.takeAttack(AttackTypes.Brawl); // Warrior-specific behavior
        super.attack(enemy); // Call base Hero logic (e.g., reduce energy)
    }
}

// 5: Ownable
// Only Owner
// On the Collectible.sol tab you'll see that Collectible contract inherits from the Ownable contract.
// 1.	Your goal is to fill out the Ownable base contract, which will be used by the Collectible contract!
// 2.	The owner should be defined in the Ownable base contract
// 3.	Ensure that markPrice can only be called by the owner (the deployer of the collectible)


contract Ownable {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }
}

// 6: Multiple Inheritance
// Collectible Transferable 
// The Collectible contract now also inherits from Transferable, a contract which has not been created yet!
// 1.	Your goal is to create a new contract Transferable that will allow the Collectible to transfer its ownership to another address.
// 2.	In the Transferable contract, create a function called transfer which takes an address for the new owner.
// 3.	Have this function transfer ownership from the current owner to the new owner passed in.
// 4.	Ensure that this function can only be called by the current owner.


// Ownable contract
contract Ownable {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }
}

// Transferable contract that inherits Ownable
contract Transferable is Ownable {
    // Function to transfer ownership to a new address
    function transfer(address newOwner) public onlyOwner {
        require(newOwner != address(0), "New owner cannot be zero address");
        owner = newOwner;
    }
}


