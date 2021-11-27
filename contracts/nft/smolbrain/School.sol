// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts@4.4.0/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@4.4.0/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts@4.4.0/security/Pausable.sol";
import "@openzeppelin/contracts@4.4.0/access/Ownable.sol";
import "@openzeppelin/contracts@4.4.0/token/ERC20/extensions/ERC20FlashMint.sol";

contract TestMagic is ERC20, ERC20Burnable, Pausable, Ownable, ERC20FlashMint {
    constructor() ERC20("TestMagic", "TESTMAGIC") {
        _mint(msg.sender, 1000000000000000 * 10 ** decimals());
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount)
        internal
        whenNotPaused
        override
    {
        super._beforeTokenTransfer(from, to, amount);
    }
}
