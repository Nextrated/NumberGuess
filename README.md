GuessNumberGame - Ethereum Smart Contract
GuessNumberGame is a simple Ethereum smart contract where players can guess a number between 1 and 5 and stand a chance to win rewards. If the player's guess is correct, they receive three times the guess fee as their reward.

Variables
contractOwner: An address variable that represents the owner of the contract.
guess: An unsigned integer variable that stores the user's guess.
guessFee: An unsigned integer variable that represents the fee required to participate in the game.
Guesslist: An array of unsigned integers that stores the pool of numbers for the game.
activeGuessNumber: An unsigned integer variable that represents the randomly generated number for each game.
callCounter: An unsigned integer variable that keeps track of the number of game rounds.
Resulr: A string that displays whether the player guess is correct or wrong.


Functions
constructor()
Initializes the contract owner.
Sets the guess fee to appropriate value.
Populates the Guesslist array with numbers from 1 to 5.

getActiveGuessNum()
Generates a random number from the Guesslist array based on the current callCounter.
Increments the callCounter to ensure the next game generates a different number.
Returns the active guess number.

guessNumber(uint256 pleaseEnterTheNumber)
Allows the user to submit their guess number.
Updates the guess variable with the provided number.
Calls the iterateGuessedNumber() function to check if the guess is correct.
Emits the Guessed Event with the address of the sender, the guess, a boolean indicating whether the user won and the result string.

iterateGuessedNumber()
Calls the getActiveGuessNum() function to generate the active guess number.
Compares the user's guess with the active guess number to determine if the user won.
Updates the result string accordingly.

withdrawFunds()
Allows the contract owner to withdraw the contract's balance.
Verifies that the caller is the contract owner.
Transfers the contract balance to the contract owner's address.


updateGuessFee(uint256 _newGuessFee)
This function allows the contract owner to update the guess fee. This function can only be called by the contract owner. 
If called successfully, it will return the new guess fee.

Usage Example:
To update the guess fee to 0.002 ETH, the contract owner would call updateGuessFee(2000000000000000). 
This function will update the guess fee and return the new guess fee.


generateRandomNumber(uint256 min, uint256 max)
Generates a random number within the specified range based on various parameters, including the current block's timestamp and difficulty.
Returns the randomly generated number.


Events
The contract emits events to allow tracking of key activities:

Guessed: This event is emitted when a player makes a guess. It includes the player's address, their guess, and whether their guess was successful.

FundsWithdrawn: This event is emitted when the contract owner withdraws funds. It includes the owner's address and the amount withdrawn.

Usage and Requirements
This contract should be used for educational or entertainment purposes only. It is not audited for security and should not be used for serious financial applications without a proper security audit.

Please note that transactions in this contract require gas, which means you will need Ether (ETH) in your wallet to interact with this contract. 
The guess fee also needs to be paid in ETH. The guess fee is set in the contract and can only be changed by the contract owner.

To interact with this contract, you will need an Ethereum wallet that supports smart contract interaction, such as Metamask. 
You can then use a tool like Remix or Hardhat to deploy and interact with the contract.

Safety and Security
While every effort has been made to ensure the contract is bug-free and safe to use, it is strongly recommended to conduct a full security audit before using this contract for any serious or large-scale applications.

No warranty is provided for the use of this contract and users should interact with it at their own risk. The contract does not provide true randomness and the outcome of games can be influenced by Ethereum miners to some extent.

License
This contract is released under the MIT License.
