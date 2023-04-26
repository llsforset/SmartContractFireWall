// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/MyTest.sol";
import "src/MyTestFireWall.sol";
import "src/FireWall.sol";
import "lib/forge-std/src/console2.sol";

contract MyTestTest is Test {
    MyTest public myTest;
    MyTestFireWall public myTestFireWall;
    FireWall public fireWall;

    address public WETH9 = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    address public sign = vm.addr(1);

    function setUp() public {
        vm.createSelectFork("https://rpc.ankr.com/eth");
        // 1. 部署原合约
        myTest = new MyTest();
        // 2. 部署防火墙
        fireWall = new FireWall();
        // 3. 将原合约中插入防火墙
        myTestFireWall = new MyTestFireWall();
    }

    // 对原合约做相对应的测试
    function testMySwap() public {
        deal(WETH9, address(myTest), 1 ether);
        myTest.mySwap();
    }

    // 对带有防火墙的合约做相应的测试
    function testMySwapFireWall() public {
        // 1. 拿到带防火墙后的合约的deployCode
        bytes memory code = address(myTestFireWall).code;
        // 2. 把原来合约的code做相对应地替换
        vm.etch(address(sign), code);
        // 3. 进行相应的合约调用，观察是否触发防火墙
        deal(WETH9, address(sign), 1 ether);
        address(sign).call(
            abi.encodeWithSignature("mySwap(address)", address(fireWall))
        );
    }
}
