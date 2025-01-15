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
  paths: {
    sources: "./contracts",
    tests: "./test",
    cache: "./cache",
    artifacts: "./artifacts",
    root: "."
  },
  typechain: {
    outDir: "typechain-types",
    target: "ethers-v6",
  },
  networks: {
    hardhat: {
      allowUnlimitedContractSize: true
    },
    "op-sepolia": {
      url: "https://sepolia.optimism.io",
      accounts: [process.env.PRIVATE_KEY || ""]
    },
    "eth-sepolia": {
      url: "https://gateway.tenderly.co/public/sepolia",
      accounts: [process.env.PRIVATE_KEY || ""]
    }
  },
  etherscan: {
    apiKey: {
      "op-sepolia": "AQ8REW4J2N79Y69ZW9CZED9N7WI3YTRCX4",
      "sepolia": "4EDQPVIY7ZZ45HMZWTJXAJIZC8S63QQUTA"
    },
    customChains: [
      {
        network: "op-sepolia",
        chainId: 11155420,
        urls: {
          apiURL: "https://api-sepolia-optimistic.etherscan.io/api",
          browserURL: "https://sepolia-optimism.etherscan.io"
        }
      }
    ]
  }
};

export default config;
