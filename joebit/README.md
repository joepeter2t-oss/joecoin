# JoeBit (Clarity / Clarinet)

A minimal SIP-010-like fungible token for Stacks, built with Clarinet.

## Project layout
- contracts/joebit.clar — token contract
- tests/joebit.test.ts — scaffold for unit tests
- Clarinet.toml — project manifest

## Requirements
- Clarinet (v3+). Install globally if needed:
  - npm: `npm i -g @hirosystems/clarinet`

## Quick start
```bash
# From this directory
clarinet check           # type-check contracts
clarinet console         # open a REPL to interact locally
```

In the console, initialize the owner (first caller becomes owner):
```clarity
(contract-call? .joebit initialize)
```

Mint some tokens as the owner:
```clarity
(contract-call? .joebit mint u1000000 'STTEST11111111111111111111111111111111)
```

Transfer tokens (caller must equal `sender`):
```clarity
(contract-call? .joebit transfer u1000 tx-sender 'STTEST22222222222222222222222222222222 none)
```

Read-only helpers:
```clarity
(contract-call? .joebit get-name)
(contract-call? .joebit get-symbol)
(contract-call? .joebit get-decimals)
(contract-call? .joebit get-total-supply)
(contract-call? .joebit get-balance 'STTEST11111111111111111111111111111111)
```

## Notes
- This implementation omits allowances (approve/transfer-from) for simplicity.
- `initialize` can only be called once; it assigns ownership to the first caller.
- Update tests in `tests/joebit.test.ts` as needed.
