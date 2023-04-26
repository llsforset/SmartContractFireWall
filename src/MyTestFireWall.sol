// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "./interfaces/IWETH9.sol";
import "./interfaces/IUniswap.sol";
import "./interfaces/IERC20.sol";

import "lib/forge-std/src/console.sol";

interface IFireWall {
    function protected(address _which_address) external;
}

contract MyTestFireWall {
    IERC20 public DAI = IERC20(0x6B175474E89094C44Da98b954EedeAC495271d0F);
    WETH9 public WETH = WETH9(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
    IUniswapV2Router UNISWAP_V2_ROUTER =
        IUniswapV2Router(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);

    // address public firewall;

    constructor() {}

    // function initFireWall(address _firewall) public {
    //     firewall = _firewall;
    // }

    function swap(
        address _tokenIn,
        address _tokenOut,
        uint _amountIn,
        uint _amountOutMin,
        address _to
    ) public {
        IERC20(_tokenIn).approve(address(UNISWAP_V2_ROUTER), _amountIn);

        address[] memory path;

        path = new address[](2);
        path[0] = _tokenIn;
        path[1] = _tokenOut;

        IUniswapV2Router(UNISWAP_V2_ROUTER).swapExactTokensForTokens(
            _amountIn,
            _amountOutMin,
            path,
            _to,
            block.timestamp
        );
    }

    // 目前插入防火墙的逻辑，必须以参数形式传入防火墙的地址
    function mySwap(address _addr) public {
        // 1. 插入防火墙的逻辑, 执行一个防火墙的外部调用
        IFireWall(_addr).protected(address(this));

        // 2. 原函数的核心功能
        swap(address(WETH), address(DAI), 1 ether, 0, address(this));
    }
}
