# Mafia Game Contracts
## 1. Accounts Contract

This contract :
Generates user profile NFTs using ERC721 standard when the user first Registers on the game
Allots the Sign Up rewards to the players from our Game Tokens
Returns tokenURI at user sign in
Deletes profile NFT when user deletes their account

## 2. Crypto Mafia Coin Contract

This contract :
Handles initial minting of Game coins using ERC20 standard
Allows accounts contract to give players sign up reward
Handles staking of Game coins when player joins the room
Allows game master to distribute those coins back as allowance

## 3. Random Number Generator Contract

This contract:
Handles fetching random numbers from Chainlink 
Stores the random number mapped with room ID

## 4. Address Book Contract

This contract:
Stores the addresses for all the other contract

## 5. Interfaces
Required to have cross contract communication and function calls


Note : VRFConsumebase contract compiles for 0.6.0 whereas Openzeppelin token contracts compile for 0.8.0 therefore we needed separate contracts and interfaces between them.
