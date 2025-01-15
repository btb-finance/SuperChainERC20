import { ethers } from "hardhat";

async function main() {
  const [deployer] = await ethers.getSigners();
  console.log("Deploying contracts with the account:", deployer.address);

  const BTBFinanceERC20 = await ethers.getContractFactory("BTBFinanceERC20");
  const token = await BTBFinanceERC20.deploy(
    deployer.address,  // owner
    "BTB Finance",     // name
    "BTB",            // symbol
    18               // decimals
  );

  await token.waitForDeployment();
  const address = await token.getAddress();
  
  console.log("BTBFinanceERC20 deployed to:", address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
