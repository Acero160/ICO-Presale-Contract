// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/TokenICO.sol";

contract MockERC20 is ERC20 {
    string public override name = "Mock Token";
    string public override symbol = "MOCK";
    uint256 public override totalSupply;
    mapping(address => uint256) public balances;

    constructor(uint256 _supply) {
        totalSupply = _supply;
        balances[address(this)] = _supply;
    }

    function transfer(address to, uint256 amount) external override returns (bool) {
        require(balances[msg.sender] >= amount, "Insufficient");
        balances[msg.sender] -= amount;
        balances[to] += amount;
        return true;
    }

    function balanceOf(address account) external view override returns (uint256) {
        return balances[account];
    }

    function allowance(address, address) external pure override returns (uint256) { return 0; }
    function approve(address, uint256) external pure override returns (bool) { return true; }
    function transferFrom(address, address, uint256) external pure override returns (bool) { return true; }
}

contract TokenICOTest is Test {
    TokenICO public ico;
    MockERC20 public token;

    function setUp() public {
        ico = new TokenICO();
        token = new MockERC20(1_000_000 ether);
        token.transfer(address(ico), 500_000 ether);
        ico.updateToken(address(token));
        ico.updateTokenSalePrice(1 ether); // 1 token = 1 ETH
    }

    function testBuyToken() public {
        vm.deal(address(this), 10 ether);
        ico.buyToken{value: 1 ether}(1);
        assertEq(token.balanceOf(address(this)), 1 ether);
    }

    function testFail_BuyToken_WrongEther() public {
        vm.deal(address(this), 1 ether);
        ico.buyToken{value: 0.5 ether}(1); // debería fallar
    }

    function testWithdrawAllTokens() public {
        ico.withdrawAllTokens();
        assertEq(token.balanceOf(address(this)), 500_000 ether);
    }

    function testTransferEther() public {
        vm.deal(address(this), 1 ether);
        ico.transferEther{value: 1 ether}(payable(address(0x1234)), 1 ether);
    }

    function testTransferToOwner() public {
        vm.deal(address(this), 1 ether);
        ico.transferToOwner{value: 1 ether}(1 ether);
    }
}
