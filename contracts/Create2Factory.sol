// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

contract Create2Factory {
    event Deployed(address addr, uint256 salt);

    function deploy(uint256 value, bytes32 salt, bytes memory code) external returns (address addr) {
        require(address(this).balance >= value, "Create2Factory: insufficient balance");
        require(code.length != 0, "Create2Factory: empty code");

        assembly {
            addr := create2(value, add(code, 0x20), mload(code), salt)
        }
        
        require(addr != address(0), "Create2Factory: failed deployment");

        emit Deployed(addr, uint256(salt));
    }

    receive() external payable {}
}
