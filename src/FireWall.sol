// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "lib/forge-std/src/console.sol";

contract FireWall {
    address public which_address;

    function protected(address _which_address) public {
        which_address = _which_address;
    }
}
