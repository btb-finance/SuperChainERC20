// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "@eth-optimism/contracts-bedrock/contracts/libraries/Predeploys.sol";
import "./interfaces/L2/SuperchainERC20.sol";
import "solady/src/auth/Ownable.sol";

contract BTBFinanceToken is SuperchainERC20, Ownable {
    string private _name;
    string private _symbol;
    uint8 private immutable _decimals;

    constructor(address owner_, string memory name_, string memory symbol_, uint8 decimals_) {
        _name = name_;
        _symbol = symbol_;
        _decimals = decimals_;

        _initializeOwner(owner_);
    }

    function name() public view virtual override returns (string memory) {
        return _name;
    }

    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }

    function decimals() public view override returns (uint8) {
        return _decimals;
    }

    function mintTo(address to_, uint256 amount_) external onlyOwner {
        _mint(to_, amount_);
    }
}
