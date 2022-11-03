// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {
  
  const ABCToken = await hre.ethers.getContractFactory("ABCToken");
  const abcToken = await ABCToken.deploy();

  await lock.deployed();

  const Lock = await hre.ethers.getContractFactory("Marketplace");
  const lock = await Lock.deploy(abcToken.address);

  await lock.deployed();

  console.log(
    `Marketplace deployed to ${lock.address}`
  );

  console.log("ABCToken deployed to", abcToken.address)
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});


//0x81667c0044b649DCda9b1938b1C00b47f3300850  marketplace
//0xCd1b0D1DcfEe117DFb64Cd6a247B61e53dD358a2  abctoken