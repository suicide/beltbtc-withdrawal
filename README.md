## beltBTC withdrawal test

beltBTC withdrawals are currently not working due to a change in ForTube that 
disabled BTC deposits.

The change tx: https://bscscan.com/tx/0x127b610d83757c330810c877c754c27ced15ca187b25a9a129dbe12cb1e0a8ac

beltBTC seems to try to rebalance while executing a withdrawal. Consequently,
withdrawal transactions fail due to a revert from ForTube Bank.

Example of a failing tx: https://bscscan.com/tx/0xd7177c3f4d29f32e3c838f64baed516b85876a07f60b83bafa93b3192aa79a21

The `Belt.t.sol` test showcases that if ForTube re-enables deposits for BTC,
users of beltBTC can withdraw their funds again.

Since the Belt team seems to be dormant, a quick solution for the current
situation would be for ForTube to re-enable BTC deposits.

### Execute the test

Run a fork of BNB chain

```shell
anvil --fork-url https://bsc.drpc.org
```

Run the tests agains the local BNB fork

```shell
forge test -vvv --rpc-url http://127.0.0.1:8545/
```
