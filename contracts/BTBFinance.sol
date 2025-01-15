// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import {Predeploys} from "../src/libraries/Predeploys.sol";
import {SuperchainERC20} from "./interfaces/L2/SuperchainERC20.sol";
import {IERC20} from "./interfaces/L2/IERC20.sol";
import {IERC7802} from "./interfaces/L2/IERC7802.sol";
import {ERC165} from "../src/utils/introspection/ERC165.sol";
import {Unauthorized} from "../src/libraries/errors/Unauthorized.sol";
import {Ownable} from "../src/auth/Ownable.sol";

contract BTBFinanceERC20 is SuperchainERC20, Ownable {
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