// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "src/UniswapV2Swap.sol";

contract UniswapV2SwapTest is Test {
    UniswapV2Swap uniswapV2Swap;

    function setUp() public {
        uniswapV2Swap = new UniswapV2Swap();
    }

    function testSwapWETHToDAI() public {
        function createSelectFork(string calldata urlOrAlias, uint256 block) external returns (uint256);

        console.log("success");
    }
}
