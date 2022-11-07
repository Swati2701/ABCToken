//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ABCToken is ERC20 {

    address public owner;
    event BuyToken(address user, uint256 amount);
    constructor() ERC20("ABCToken", "ABCT"){
        owner = msg.sender;
        _mint(owner, 10 * 10**decimals());
    }

    
    function buyToken(address to, uint256 tokenAmount) external{
        require(to != owner, "owner cannot buy token");
        require(tokenAmount != 0, "cannot be zero value");

        emit BuyToken(to, tokenAmount);
        transfer(to, tokenAmount);
    }
}