import { ethers } from "hardhat";

async function main() {
  const [deployer] = await ethers.getSigners();
  console.log("Deploying contracts with the account:", deployer.address);

  const BTBFinance = await ethers.getContractFactory("L2NativeSuperchainERC20");
  
  // Deploy parameters
  const owner = deployer.address;
  const name = "BTB Finance";
  const symbol = "BTB";
  const decimals = 18;

  const contract = await BTBFinance.deploy(owner, name, symbol, decimals);
  await contract.waitForDeployment();

  const contractAddress = await contract.getAddress();
  console.log("L2NativeSuperchainERC20 deployed to:", contractAddress);

  // Verify the deployment parameters
  console.log("Token Name:", await contract.name());
  console.log("Token Symbol:", await contract.symbol());
  console.log("Token Decimals:", await contract.decimals());
  console.log("Owner:", await contract.owner());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
