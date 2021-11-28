// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

import '@openzeppelin/contracts/access/Ownable.sol';

import '@openzeppelin/contracts/token/ERC20/IERC20.sol';
import '@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol';
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";


interface TreasureMarketplace {
    struct Listing {
        uint256 quantity;
        uint256 pricePerItem;
        uint256 expirationTime;
    }

    function createListing(
        address _nftAddress,
        uint256 _tokenId,
        uint256 _quantity,
        uint256 _pricePerItem,
        uint256 _expirationTime
    ) external;

    function updateListing(
        address _nftAddress,
        uint256 _tokenId,
        uint256 _newQuantity,
        uint256 _newPricePerItem,
        uint256 _newExpirationTime
    ) external;

    function cancelListing(address _nftAddress, uint256 _tokenId) external;

    function buyItem(
        address _nftAddress,
        uint256 _tokenId,
        address _owner,
        uint256 _quantity
    ) external;

    function addToWhitelist(address _nft) external;
    function removeFromWhitelist(address _nft) external;
}



contract  TreasureMarketplaceMultiBuyer {
    
    struct Asset {
        // 0: ETH
        // 1: ERC20
        // 2: ERC721
        // 3: ERC1155
        uint contractType;
        address contractAddress;
        uint tokenId;
        address ownerAddress;
        uint quantity;
        // uint decimals;
    }

    uint public fees;
    uint public base_fees;

    TreasureMarketplace public marketplace;

    constructor(TreasureMarketplace _treasureMarketplace){
        marketplace = _treasureMarketplace;
    }

    function setMarketplaceContract(TreasureMarketplace _treasureMarketplace) external onlyOwner nonReentrant {
        marketplace = _treasureMarketplace;
    }

    // fallback
    function() external {
        revert("Fallback function is called, reverting this txn...");
    }


    // non reentrant?
    // this shouldn't be useful but it's just in case
    function transferETH(address payable dest) external onlyOwner nonReentrant {
        dest.transfer(address(this).balance)
    }

    // non reentrant?
    // Asset tokens retrieval in case someone sends to this address
    function transferAsset(Asset _asset) external onlyOwner nonReentrant {
        
    }


    // approve token to TreasureMarketplace contract address
    function approveTokensToTreasureMarketplace external onlyOwner nonReentrant {

    }

    // non reentrant?
    function multiBuyAllAtomicUsingETH(Asset[] _outputAssets) external payable nonReentrant {
        
        uint outputAssetsLength = _outputAssets.length;



        for (uint i = 0; i < outputAssetsLength; i++){
            Asset outputAsset = _outputAssets[i];

            marketplace.buyItem(outputAsset.contractAddress, outputAsset.tokenId, outputAsset.ownerAddress, outputAsset.quantity);
        }
    }

    

}