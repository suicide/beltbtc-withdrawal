// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";

contract BeltTest is Test {
    address private fortubeProxyAddress = 0xc78248D676DeBB4597e88071D3d889eCA70E5469;
    address private fortubeProxyAdmin = 0x7354092C6032FC2f1B8a43F3A55365be1Ac0348A;

    ForTubeBankController private fortubeBankController;

    address private beltBtcAddress = 0x51bd63F240fB13870550423D208452cA87c44444;
    IStrategyToken private beltBtc;

    address private btcAddress = 0x7130d2A12B9BCbFAe4f2634d864A1Ee1Ce3Ead9c;
    IERC20 private btc;

    address private sender = 0xA68C2D3244D70daE150664d08114Ea8DEE68eE58;

    function setUp() public {
      fortubeBankController = ForTubeBankController(fortubeProxyAddress);
      beltBtc = IStrategyToken(beltBtcAddress);
      btc = IERC20(btcAddress);
    }

    function test_withdraw_fail() public {

      // previously failed tx
      // 0xd7177c3f4d29f32e3c838f64baed516b85876a07f60b83bafa93b3192aa79a21
      vm.startPrank(sender);
      // the withdrawal will fail without re-enabling BTC deposits
      vm.expectRevert();
      beltBtc.withdraw(119787542064703475, 122500000000000000);

    }

    function test_withdraw() public {
      // deposits were previously disabled
      // 0x127b610d83757c330810c877c754c27ced15ca187b25a9a129dbe12cb1e0a8ac
      console.log("before: btc balance", btc.balanceOf(sender));
      vm.startPrank(fortubeProxyAdmin);
      fortubeBankController.setTokenConfig(btcAddress, false, true, false, false, false);

      // previously failed tx
      // 0xd7177c3f4d29f32e3c838f64baed516b85876a07f60b83bafa93b3192aa79a21
      vm.startPrank(sender);
      beltBtc.withdraw(119787542064703475, 122500000000000000);

      console.log("after: btc balance", btc.balanceOf(sender));
    }
}

interface ForTubeBankController {
    function setTokenConfig(
        address t,
        bool _depositDisabled,
        bool _borrowDisabled,
        bool _withdrawDisabled,
        bool _repayDisabled,
        bool _liquidateBorrowDisabled
    ) external;
}

interface IStrategyToken {
  function withdraw(uint256 _shares, uint256 _minAmount) external;
}

interface IERC20 {
  function balanceOf(address account) external view returns (uint256);
}
