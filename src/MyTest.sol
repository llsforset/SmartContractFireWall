// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "./interfaces/IWETH9.sol";
import "./interfaces/IUniswap.sol";
import "./interfaces/IERC20.sol";

contract MyTest {
    IERC20 public DAI = IERC20(0x6B175474E89094C44Da98b954EedeAC495271d0F);
    WETH9 public WETH = WETH9(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
    IUniswapV2Router UNISWAP_V2_ROUTER =
        IUniswapV2Router(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);

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

    function mySwap() public {
        // 用 1 个WETH 去置换dai
        swap(address(WETH), address(DAI), 1 ether, 0, address(this));
    }
}
