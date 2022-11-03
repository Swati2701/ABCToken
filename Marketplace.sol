//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
// import ""

contract Marketplace{
    IERC20 private immutable addrToken;
    
    address public owner;
    
    mapping(address => mapping(uint256 => bool)) public offerExist;
    mapping(address=> mapping(uint256 => uint256)) public offerId;
    
    constructor(IERC20 _token){
        addrToken = _token;
        owner = msg.sender;
    }
    

    modifier onlyOwner() {
        require(msg.sender == owner, "Not called by owner");
        _;
    }


    function makeOffer(address addrNFT, uint256 tokenId) external{
        require(addrToken.balanceOf(msg.sender)!=0, "User must have ABCToken");
        offerId[addrNFT][tokenId]++;
    }

    function rejectOffer(uint256 _offerId) external{
        require(!(offerExist[msg.sender][_offerId]), "offer cannot be rejected");
        offerExist[msg.sender][_offerId] = false;
    }

    function acceptOffer(uint256 _offerId) external onlyOwner{
        require(offerExist[msg.sender][_offerId], "Already accepted offer");
        offerExist[msg.sender][_offerId] = true;
    }

    function fetchOffer(uint256 _offerValue) external view returns(bool){
        return (offerExist[msg.sender][_offerValue]);
    }
}