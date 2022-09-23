## welcome to unhacked

_unhacked_ is a bi-weekly ctf, giving whitehats the chance to go back in time before real exploits and recover funds before the bad guys get them. 

_you are a whitehat, right anon?_

## meet audius

[audius](https://audius.co/) is a streaming music service with a market cap of over $250mm.

in july, they were hacked and their treasury was emptied of all its $AUDIO tokens.

the simple soundbite is that there was a storage slot collision with a proxy contract that allowed reinitialization of existing contracts.  since all of the contracts are behind a proxy, this collision meant that the initialize() function of all contracts could be called any time.

but how can we exploit this vulnerability to drain the treasury?

your job is to use this knowledge, dig into the code, and empty the treasury of over 18mm $AUDIO tokens before the blackhat does.

## how to play

1. fork this repo and clone it locally.

2. add a mainnet RPC url into `test/AudiusHack.t.sol` so that the tests are able to fork mainnet from block 15201700.

3. review the code in the `src/` folder, which contains all the code at the time of the hack. you can explore the state of the contract before the hack using block 15201700. ex: `cast call --rpc-url ${ETH_RPC_URL} --block 15201700 0x4DEcA517D6817B6510798b7328F2314d3003AbAC "getGuardianAddress()"`

4. if you get stuck, there are a few helpful resources. first, try [reading this post mortem from the audius team](https://blog.audius.co/article/audius-governance-takeover-post-mortem-7-23-22). if you need more hints, check out the [audius exploiter's history on etherscan](https://etherscan.io/address/0xa0c7bd318d69424603cbf91e9969870f21b8ab4c) (you may want to try decompiling the bytecode of the contracts they deployed).

5. when you find an exploit, code it up in `AudiusHack.t.sol`. the test will pass if you succeed.

6. post on twitter for bragging rights and tag [@unhackedctf](http://twitter.com/unhackedctf). first correct answer gets a spot on the leaderboard. no cheating.

## solution

this contest is no longer live. (you can read a write up of the solution here)[https://unhackedctf.substack.com/p/audius-walkthrough-challenge-3] or find the solution code in the `test` folder.

## subscribe

for new weekly challenges and solutions, subscribe to the [unhacked newsletter](https://unhackedctf.substack.com/p/welcome).
