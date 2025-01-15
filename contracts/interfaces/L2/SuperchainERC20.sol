// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

// Contracts
import { ERC20 } from "solady/src/tokens/ERC20.sol";

// Libraries
import { Predeploys } from "@eth-optimism/contracts-bedrock/src/libraries/Predeploys.sol";
import { Unauthorized } from "../../libraries/errors/CommonErrors.sol";

// Interfaces
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { ISemver } from "../universal/ISemver.sol";
import { IERC7802, IERC165 } from "./IERC7802.sol";

/// @title SuperchainERC20
/// @notice A standard ERC20 extension implementing IERC7802 for unified cross-chain fungibility across
/// @dev This contract is meant to be inherited by L2 token contracts
abstract contract SuperchainERC20 is ERC20, IERC7802, ISemver {
    /// @notice Semantic version.
    /// @custom:semver 1.0.0-beta.8
    function version() external view virtual returns (string memory) {
        return "1.0.0-beta.8";
    }

    /// @notice Modifier that ensures the caller is the L2 Standard Bridge
    modifier onlyBridge() {
        if (msg.sender != Predeploys.L2_STANDARD_BRIDGE) revert Unauthorized();
        _;
    }

    /// @notice Allows the SuperchainTokenBridge to mint tokens.
    /// @param _to     Address to mint tokens to.
    /// @param _amount Amount of tokens to mint.
    function crosschainMint(address _to, uint256 _amount) external onlyBridge {
        _mint(_to, _amount);

        emit CrosschainMint(_to, _amount, msg.sender);
    }

    /// @notice Allows the SuperchainTokenBridge to burn tokens.
    /// @param _from   Address to burn tokens from.
    /// @param _amount Amount of tokens to burn.
    function crosschainBurn(address _from, uint256 _amount) external onlyBridge {
        _burn(_from, _amount);

        emit CrosschainBurn(_from, _amount, msg.sender);
    }

    /// @inheritdoc IERC165
    function supportsInterface(bytes4 _interfaceId) public view virtual returns (bool) {
        return _interfaceId == type(IERC7802).interfaceId || _interfaceId == type(IERC20).interfaceId
            || _interfaceId == type(IERC165).interfaceId;
    }
}