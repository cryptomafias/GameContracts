# Mafia Game Contracts
## 1. Accounts Contract
- Deployed Address: [0x4B7c2323Ea4021dBe02AE11259Af54d6E9a0CD80](https://explorer-mumbai.maticvigil.com/address/0x4B7c2323Ea4021dBe02AE11259Af54d6E9a0CD80/transactions)
- Generates user profile NFTs using ERC721 standard when the user first Registers on the game
- Allots the Sign Up rewards to the players from our Game Tokens
- Returns tokenURI at user sign in
- Deletes profile NFT when user deletes their account

## 2. Crypto Mafia Coin Contract
- Deployed Address: [0x91D89b2F9B8cb1873546Ce99E4166AD05264cB76](https://explorer-mumbai.maticvigil.com/address/0x91D89b2F9B8cb1873546Ce99E4166AD05264cB76/transactions)
- Handles initial minting of Game coins using ERC20 standard
- Allows accounts contract to give players sign up reward
- Handles staking of Game coins when player joins the room
- Allows game master to distribute those coins back as allowance

## 3. Random Number Generator Contract
- Deployed Address: [0x0059915f5b41Fbbdd9059f028AC8EcDFf15Ff6d2](https://explorer-mumbai.maticvigil.com/address/0x0059915f5b41Fbbdd9059f028AC8EcDFf15Ff6d2/transactions)
- Handles fetching random numbers from Chainlink 
- Stores the random number mapped with room ID

## 4. Address Book Contract
- Deployed Address: [0x0eD3b4e41fFb13d05e75041Fa2D7Aa715C9F2369](https://explorer-mumbai.maticvigil.com/address/0x0eD3b4e41fFb13d05e75041Fa2D7Aa715C9F2369/transactions)
- Stores the addresses for all the other contract

## 5. Interfaces
Required to have cross contract communication and function calls
