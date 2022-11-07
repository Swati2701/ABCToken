//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";


contract Marketplace{
    IERC20 private immutable addrToken;
    
    address public owner;
    uint256 public offerNo;
    mapping(address => mapping(uint256 => bool)) public offerExist;
    mapping(address=> mapping(uint256 => uint256)) public offerId;
    mapping(address => mapping(uint256 => uint256)) public userBalance;
    
    constructor(IERC20 _token){
        addrToken = _token;
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not called by owner");
        _;
    }


    function makeOffer(address addrNFT, uint256 tokenId) external {
        require(addrToken.balanceOf(msg.sender)!=0, "User must have ABCToken");
        unchecked{
            offerNo++;
        }
        offerId[addrNFT][tokenId] = offerNo; 
        userBalance[msg.sender][offerNo] = addrToken.balanceOf(msg.sender);      
    }

    function acceptOffer(uint256 _offerId) external{
        require(!(offerExist[msg.sender][_offerId]), "Already accepted offer");
        offerExist[msg.sender][_offerId] = true;
    }

    function rejectOffer(uint256 _offerId) external onlyOwner {
        require((offerExist[msg.sender][_offerId]) == true, "offer cannot be rejected");
        offerExist[msg.sender][_offerId] = false;
    }

    function fetchOffer(uint256 _offerValue) external view returns(bool, uint256){
        return (offerExist[msg.sender][_offerValue],  userBalance[msg.sender][_offerValue]);
    }
}