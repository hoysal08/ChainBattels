// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract ChainBattelswability is ERC721URIStorage {
    using Strings for uint256;
using Counters for Counters.Counter;    
Counters.Counter private _tokenid;

struct ability{
    uint xp;
    uint strength;
    uint speed;
    uint level;
}

    mapping(uint256 => ability)public tokenidtolevels;

    constructor() ERC721("Chain BattelS", "CBTLS"){

    }

    function generateCharacter(uint256 tokenId) public view returns(string memory){
        bytes memory svg =abi.encodePacked(
            '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350">',
   '<style>.base { fill: white; font-family: serif; font-size: 14px; }</style>',
  '<rect width="100%" height="100%" fill="black" />',
   '<text x="50%" y="20%" class="base" dominant-baseline="middle" text-anchor="middle">Warrior</text>',
   '<text x="50%" y="30%" class="base" dominant-baseline="middle" text-anchor="middle">', "Levels: ",getLevels(tokenId),'</text>',
   '<text x="50%" y="40%" class="base" dominant-baseline="middle" text-anchor="middle">', "Speed: ",getSpeed(tokenId),'</text>',
   '<text x="50%" y="50%" class="base" dominant-baseline="middle" text-anchor="middle">', "Strength: ",getStrength(tokenId),'</text>',
   '<text x="50%" y="60%" class="base" dominant-baseline="middle" text-anchor="middle">', "XP: ",getXp(tokenId),'</text>'
 '</svg>'
        );

        return string(
            abi.encodePacked("data:image/svg+xml;base64,",
            Base64.encode(svg)
            )
        );
    }

    function getLevels(uint256 tokenId) public view returns(string memory) {
       uint lev =tokenidtolevels[tokenId].level;
        return lev.toString();
    }
    function getSpeed(uint256 tokenId) public view returns(string memory) {
       uint sped =tokenidtolevels[tokenId].speed;
        return sped.toString();
    }
     function getStrength(uint256 tokenId) public view returns(string memory) {
       uint strng =tokenidtolevels[tokenId].strength;
        return strng.toString();
    }
     function getXp(uint256 tokenId) public view returns(string memory) {
       uint Xp =tokenidtolevels[tokenId].xp;
        return Xp.toString();
    }

    function getTokenURI(uint256 tokenId) public returns (string memory){
    bytes memory dataURI = abi.encodePacked(
        '{',
            '"name": "Chain Battles #', tokenId.toString(), '",',
            '"description": "Battles on chain",',
            '"image": "', generateCharacter(tokenId), '"',
        '}'
    );
    return string(
        abi.encodePacked(
            "data:application/json;base64,",
            Base64.encode(dataURI)
        )
    );
}

    function mint() public{
       _tokenid.increment();
       uint256 newItemId=_tokenid.current();
       _safeMint(msg.sender,newItemId);
       tokenidtolevels[newItemId].level=0;
        tokenidtolevels[newItemId].speed=0;
       tokenidtolevels[newItemId].strength=0;
       tokenidtolevels[newItemId].xp=0;

       _setTokenURI(newItemId,getTokenURI(newItemId));

    }
    
    function train(uint256 tokenId) public {
        require(_exists(tokenId),"Please use an existing Token");
        require(ownerOf(tokenId)==msg.sender,"You must own this token to train it");
        uint256 currentLevel=tokenidtolevels[tokenId].level;
        tokenidtolevels[tokenId].level=currentLevel+1;
          uint256 currentspeed=tokenidtolevels[tokenId].speed;
        tokenidtolevels[tokenId].speed=currentspeed+3;
         uint256 currentstrng=tokenidtolevels[tokenId].strength;
        tokenidtolevels[tokenId].strength=currentstrng+5;
          uint256 currentxp=tokenidtolevels[tokenId].xp;
        tokenidtolevels[tokenId].xp=currentxp+10;
        _setTokenURI(tokenId,getTokenURI(tokenId));
    }
    

}

//add attribute to mapping
//generate sudo random number keccka 256,block.timestamp etc

//0xC3Dd9C49bc799db9aA7970366196eE1ecD1Bd18A