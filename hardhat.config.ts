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
  },
  etherscan: {
    apiKey: {
      "op-sepolia": "AQ8REW4J2N79Y69ZW9CZED9N7WI3YTRCX4"
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
