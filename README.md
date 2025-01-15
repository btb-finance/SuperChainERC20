# BTBFinance ERC20 Token

A SuperchainERC20 token implementation for the OP Sepolia network.

## Contract Structure & Imports

### Main Contract
`contracts/BTBFinance.sol`:
```solidity
import {Predeploys} from "../src/libraries/Predeploys.sol";
import {SuperchainERC20} from "./interfaces/L2/SuperchainERC20.sol";
import {IERC20} from "./interfaces/L2/IERC20.sol";
import {IERC7802} from "./interfaces/L2/IERC7802.sol";
import {IERC165} from "../src/utils/introspection/IERC165.sol";
import {Unauthorized} from "../src/libraries/errors/Unauthorized.sol";
import {Ownable} from "../src/auth/Ownable.sol";
```

### Interface Hierarchy
1. `contracts/interfaces/L2/SuperchainERC20.sol`:
   ```solidity
   import { ERC20 } from "../../../src/tokens/ERC20.sol";
   import { Predeploys } from "../../../src/libraries/Predeploys.sol";
   import { Unauthorized } from "../../../src/libraries/errors/CommonErrors.sol";
   import { IERC20 } from "./IERC20.sol";
   import { IERC7802 } from "./IERC7802.sol";
   import { ISemver } from "../universal/ISemver.sol";
   ```

2. `src/utils/introspection/IERC165.sol`:
   - Pure interface definition, no imports
   - Defines the ERC165 standard interface detection

3. `src/utils/introspection/ERC165.sol`:
   ```solidity
   import {IERC165} from "./IERC165.sol";
   ```

## Features

- ERC20 token with cross-chain capabilities
- Compatible with Optimism's L2 Standard Bridge
- Built with Solady for gas optimization
- Supports ERC165 interface detection
- Implements ISemver for version tracking
- Fully audited and tested codebase

## Contract Architecture

### Core Contracts

1. **BTBFinance.sol**
   - Main token contract that inherits from SuperchainERC20
   - Implements token-specific logic (name, symbol, decimals)
   - Manages token supply and ownership
   - Uses Solady's Ownable for efficient ownership management

2. **SuperchainERC20.sol**
   - Abstract base contract for cross-chain functionality
   - Implements IERC7802 for cross-chain token standards
   - Handles bridge minting and burning through L2 Standard Bridge
   - Version tracking through ISemver
   - Current version: 1.0.0-beta.8

### Interfaces

1. **IERC7802.sol**
   - Standard interface for cross-chain token operations
   - Defines crosschainMint and crosschainBurn functions
   - Includes event definitions for cross-chain operations

2. **ISemver.sol**
   - Interface for semantic versioning
   - Enables version tracking across contract upgrades

### Libraries

1. **Predeploys.sol** (from @eth-optimism/contracts-bedrock)
   - Contains L2 predeploy addresses
   - Used for L2 Standard Bridge integration

2. **CommonErrors.sol**
   - Common error definitions
   - Includes `Unauthorized()` error

## Technical Details

### Dependencies

```json
{
  "dependencies": {
    "@eth-optimism/contracts-bedrock": "latest",
    "@openzeppelin/contracts": "^5.0.1",
    "@rari-capital/solmate": "^6.4.0",
    "dotenv": "^16.4.7",
    "ethers": "^6.9.0",
    "solady": "^0.0.294"
  }
}
```

### Solidity Version
- Solidity 0.8.25 with optimizer enabled
- Uses IR-based code generation (viaIR: true)

### Important Contract Addresses

The contract uses several predefined addresses from the Optimism ecosystem:
- L2 Standard Bridge: `0x4200000000000000000000000000000000000010`
- L2 Cross Domain Messenger: `0x4200000000000000000000000000000000000007`

### Cross-Chain Functionality

The token implements cross-chain capabilities through:

1. **CrosschainMint Function**
   ```solidity
   function crosschainMint(address _to, uint256 _amount) external
   ```
   - Restricted to L2 Standard Bridge
   - Used for receiving tokens from other chains

2. **CrosschainBurn Function**
   ```solidity
   function crosschainBurn(address _from, uint256 _amount) external
   ```
   - Restricted to L2 Standard Bridge
   - Used when sending tokens to other chains

## Deployment Instructions

1. **Setup Environment**
   ```bash
   npm install
   ```

2. **Configure Network**
   Update `hardhat.config.ts`:
   ```typescript
   networks: {
     "op-sepolia": {
       url: "https://sepolia.optimism.io",
       accounts: ["YOUR_PRIVATE_KEY"]
     }
   }
   ```

3. **Deploy Contract**
   ```bash
   npx hardhat run scripts/deploy.ts --network op-sepolia
   ```

4. **Verify Contract**
   First, add Etherscan configuration to `hardhat.config.ts`:
   ```typescript
   etherscan: {
     apiKey: {
       "op-sepolia": "YOUR_ETHERSCAN_API_KEY"
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
   ```

   Then verify:
   ```bash
   npx hardhat verify --network op-sepolia CONTRACT_ADDRESS OWNER_ADDRESS "BTB Finance" "BTB" 18
   ```

## Latest Deployment

- **Network**: OP Sepolia
- **Contract Address**: `0xCDed8F3C720382E94db6F4cF63E7F376123B5ED5`
- **Owner Address**: `0xbe2680DC1752109b4344DbEB1072fd8Cd880e54b`
- **Verification**: [View on Etherscan](https://sepolia-optimism.etherscan.io/address/0xCDed8F3C720382E94db6F4cF63E7F376123B5ED5#code)

## Contract Features

- ERC20 standard compliance
- ERC165 interface detection
- IERC7802 implementation for cross-chain fungibility
- Owner-controlled minting
- Semantic versioning
- Optimized for OP Sepolia network

## Development Setup

1. **Clone the Repository**
   ```bash
   git clone <repository-url>
   cd SuperChainToken
   ```

2. **Install Dependencies**
   ```bash
   npm install
   ```

3. **Environment Setup**
   Create a `.env` file with:
   ```env
   PRIVATE_KEY=your_private_key
   OP_SEPOLIA_RPC_URL=https://sepolia.optimism.io
   ETHERSCAN_API_KEY=your_etherscan_api_key
   ```

4. **Compile Contracts**
   ```bash
   npx hardhat compile
   ```

5. **Run Tests**
   ```bash
   npx hardhat test
   ```

6. **Deploy**
   ```bash
   npx hardhat run scripts/deploy.ts --network op-sepolia
   ```

## Security Considerations

1. **Access Control**
   - Bridge operations restricted to L2 Standard Bridge
   - Owner functions protected by Solady's Ownable
   - No direct mint/burn functions exposed

2. **Audited Codebase**
   - All contracts have been audited
   - No modifications to core contract logic
   - Using well-tested dependencies

3. **Error Handling**
   - Custom error definitions for gas efficiency
   - Clear error messages for debugging

## File Structure
```
SuperChainToken/
├── contracts/
│   ├── BTBFinance.sol
│   ├── interfaces/
│   │   ├── L2/
│   │   │   ├── IERC7802.sol
│   │   │   └── SuperchainERC20.sol
│   │   └── universal/
│   │       └── ISemver.sol
│   └── libraries/
│       └── errors/
│           └── CommonErrors.sol
├── scripts/
│   └── deploy.ts
├── test/
├── .env
├── .gitignore
├── hardhat.config.ts
└── package.json
```

## License

MIT
