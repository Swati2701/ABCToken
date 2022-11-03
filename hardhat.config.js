require('@nomiclabs/hardhat-ethers')
require('@nomiclabs/hardhat-etherscan')
require('dotenv').config()

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
const MATIC_KEY = process.env.MATIC_PRIVATE_KEY

module.exports = {
	solidity: {
		compilers: [
			{
				version: '0.8.1',
			},
			{
				version: '0.8.0',
			},
		],
	},
	networks: {
		hardhat: {
			accounts: {
				accountsBalance: '1000000000000000000000000000000000000000',
			},
		},
		fork: {
			url: 'http://127.0.0.1:8545/',
		},

		matic: {
			url: process.env.MUMBAI_RPC_URL,
			accounts: [`0x${MATIC_KEY}`],
			chainId: 80001,
		},
	},
	etherscan: {
		apiKey: process.env.MATIC_API_KEY, //for polygonscan (mumbai)
	},
}
