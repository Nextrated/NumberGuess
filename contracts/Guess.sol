// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract GuessNumberGame {
    // Adress variable to hold the address of the owner of the contract
    address private contractOwner;

    // Unsigned Integer variable to hold the inputed guess from the players
    uint256 private guess;

    // Unsigned Integer variable which is the amount charged by the contract for players to guess
    uint256 private guessFee;

    // Empty Array which will hold the numbers the contract owner wants to include in the List of numbers users can guess from 
    uint256[] private Guesslist;

    // Unsigned Integer variable which is the correct number players are attempting to guess
    uint256 private activeGuessNumber;

    // Unsigned Integer variable which keeps track of the random numbers generated
    uint256 private callCounter;

    // String varible that displays whether the players guess is right or wrong
    string private result;

    // Event to track guesses
    event Guessed(address indexed player, uint256 guess, bool success);

    // Event to track withdrawals 
    event FundsWithdrawn(address indexed owner, uint256 amount); 


    /* Function that is run once on deployment setting the address of the owner of the contract, 
      the guess fee and the numbers to include in the guess list*/
    constructor() {
        contractOwner = msg.sender;
        guessFee = 0.001 ether;
        // Initialize the array with numbers 1-5
        for (uint256 i = 1; i <= 5; i++) {
            Guesslist.push(i);
        }
    }

    /* Function that takes the guess input from the player, checks to see that the input is within the range,
     checks that guessFee is sent along with the transaction and displays whether or not the guess is correct */
    function guessNumber(uint256 pleaseEnterTheNumber) public payable returns (bool, string memory) {
        require(msg.value == guessFee, "Incorrect guess fee"); // Checks if the transaction value matches the guess fee
        require(pleaseEnterTheNumber >= 1 && pleaseEnterTheNumber <= 5, "Guess must be between 1 and 5"); // Checks if guess is within range

        guess = pleaseEnterTheNumber;
        bool success = iterateGuessedNumber();

        emit Guessed(msg.sender, guess, success); // Emit event when a guess is made
        return (success, result);
    }


    // Function that checks whether the players guess is correct or not
    function iterateGuessedNumber() private returns (bool) {
        uint256 randomIndex = generateRandomNumber(0, Guesslist.length - 1);
        activeGuessNumber = Guesslist[randomIndex];
        callCounter++;

        bool isWinner = (guess == activeGuessNumber);
        if (isWinner) {
            payable(msg.sender).transfer(guessFee * 3); // Transfer x3 of the guessFee to the player
            result = "winner";
        } else {
            result = "loser";
        }

        return isWinner;
    }


    // Function that allows the Contract owner to withdraw the funds from the smart contract
    function withdrawFunds() public {
        require(msg.sender == contractOwner, "Only the contract owner can withdraw funds");
        uint256 contractBalance = address(this).balance;
        require(contractBalance > 0, "No funds available for withdrawal");

        payable(contractOwner).transfer(contractBalance);
        emit FundsWithdrawn(contractOwner, contractBalance); // Emit event when funds are withdrawn
    }

    //  Function that allows the contract owner to update the price players pay to guess
    function updateGuessFee(uint256 _newGuessFee) public returns (uint256) {
    require(msg.sender == contractOwner, "Only the contract owner can update the guess fee");
    guessFee = _newGuessFee;
    return guessFee;
}


    // Function that generates random numbers from the guess list pool using Blockchain Parameters
    function generateRandomNumber(uint256 min, uint256 max) private view returns (uint256) {
        uint256 randomNumber = uint256(
            keccak256(
                abi.encodePacked(
                    block.timestamp,
                    block.prevrandao,
                    block.number,
                    msg.sender,
                    callCounter
                )
            )
        ) % (max - min + 1);

        return randomNumber + min;
    }
    
    // Fallback function
    fallback () external {
        revert("Operation not supported");
    }
}
