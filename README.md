# WavePortal
The frontend of the dapp is available [here](https://github.com/sbhbenjamin/waveportal-frontend)<br />

The backend of a dapp that allows people to send me waves through the ethereum blockchain, and stand a chance to gain some ether. The frontend is built on React, and the smart contract is powered by Solidity. Hardhat was used in the development of the smart contract. The dapp is live running the contract off the Rinkeby network.

### Prerequisites
Node.js v14+<br />

## Getting started
Install dependencies: 
```
npm install
```

Local deployment
```
npx hardhat node // Start your local hardhat node
npx hardhat run scripts/deploy.js --network localhost // Deploy contract to local hardhat node
npx hardhat run scripts/deploy.js --network rinkeby // Deploy contract to rinkeby testnet
```
