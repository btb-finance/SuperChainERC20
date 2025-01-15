import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import * as dotenv from "dotenv";

dotenv.config();

const config: HardhatUserConfig = {
  solidity: {
    version: "0.8.25",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
      viaIR: true
    }
  },
  networks: {
    hardhat: {
      allowUnlimitedContractSize: true
    },
    "op-sepolia": {
      url: "https://sepolia.optimism.io",
      accounts: ["0x89266ff69e24130a10d24dfb80316a2c6f3e2304345e8796aa820a3a19f27589"]
    }
  }
};

export default config;
