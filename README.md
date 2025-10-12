# JoeCoin 🪙

A SIP-010 compliant fungible token built on the Stacks blockchain using Clarinet.

## Overview

JoeCoin (JOE) is a fungible token implementation that follows the SIP-010 standard for fungible tokens on the Stacks blockchain. It provides all the essential functionality for a modern cryptocurrency including transfers, minting, burning, and administrative controls.

## Features

- ✅ **SIP-010 Compliant**: Full compatibility with the Stacks fungible token standard
- 🔄 **Transfer**: Send tokens between addresses
- 🪙 **Mint**: Create new tokens (owner only)
- 🔥 **Burn**: Destroy tokens to reduce supply
- ⏸️ **Pausable**: Emergency pause functionality
- 🔐 **Access Control**: Owner-only administrative functions
- 📊 **Supply Tracking**: Real-time total supply management

## Token Details

- **Name**: JoeCoin
- **Symbol**: JOE
- **Decimals**: 6
- **Initial Supply**: 1,000,000 JOE (1,000,000,000,000 microJOE)
- **Contract Owner**: The address that deploys the contract

## Prerequisites

- [Clarinet](https://github.com/hirosystems/clarinet) v3.7.0 or higher
- [Node.js](https://nodejs.org/) v16 or higher
- [Git](https://git-scm.com/)

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/joecoin.git
   cd joecoin
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

3. Verify Clarinet installation:
   ```bash
   clarinet --version
   ```

## Development

### Running Tests

```bash
# Run all tests
clarinet test

# Run tests with coverage
npm run test:coverage

# Run specific test file
clarinet test tests/joecoin_test.ts
```

### Local Development

```bash
# Start Clarinet console
clarinet console

# Check contract syntax
clarinet check

# Get contract costs
clarinet costs contracts/joecoin.clar
```

### Contract Interaction

In the Clarinet console, you can interact with the contract:

```clarity
;; Get token name
(contract-call? .joecoin get-name)

;; Get balance of an address
(contract-call? .joecoin get-balance 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM)

;; Transfer tokens
(contract-call? .joecoin transfer u1000000 tx-sender 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM none)

;; Mint tokens (owner only)
(contract-call? .joecoin mint u500000000 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM)
```

## Contract Functions

### SIP-010 Standard Functions

| Function | Description | Parameters |
|----------|-------------|------------|
| `transfer` | Transfer tokens between addresses | `amount`, `sender`, `recipient`, `memo` |
| `get-name` | Get token name | None |
| `get-symbol` | Get token symbol | None |
| `get-decimals` | Get token decimals | None |
| `get-balance` | Get balance of an address | `account` |
| `get-total-supply` | Get total token supply | None |
| `get-token-uri` | Get token metadata URI | None |

### Additional Functions

| Function | Description | Access |
|----------|-------------|--------|
| `mint` | Create new tokens | Owner only |
| `burn` | Destroy tokens | Token holder |
| `set-paused` | Pause/unpause contract | Owner only |
| `set-contract-approved` | Approve contracts | Owner only |
| `is-paused` | Check if contract is paused | Public |
| `is-contract-approved` | Check contract approval | Public |
| `get-owner` | Get contract owner | Public |

## Error Codes

| Code | Constant | Description |
|------|----------|-------------|
| u100 | `err-owner-only` | Function can only be called by owner |
| u101 | `err-not-token-owner` | Sender doesn't own the tokens |
| u102 | `err-insufficient-balance` | Not enough tokens to transfer |
| u103 | `err-invalid-amount` | Amount must be greater than 0 |
| u104 | `err-contract-paused` | Contract is paused |

## Security Features

- **Owner Controls**: Critical functions are restricted to contract owner
- **Pause Mechanism**: Emergency pause to halt all token operations
- **Input Validation**: All functions validate inputs and check preconditions
- **SIP-010 Compliance**: Follows established security patterns

## Deployment

### Testnet Deployment

```bash
# Deploy to testnet
clarinet deploy --testnet
```

### Mainnet Deployment

```bash
# Deploy to mainnet (be careful!)
clarinet deploy --mainnet
```

## Testing

The project includes comprehensive tests covering:

- ✅ Token transfers
- ✅ Minting and burning
- ✅ Access control
- ✅ Pause functionality
- ✅ Error conditions
- ✅ SIP-010 compliance

## Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Make your changes
4. Run tests: `npm test`
5. Commit your changes: `git commit -m 'Add amazing feature'`
6. Push to the branch: `git push origin feature/amazing-feature`
7. Open a Pull Request

## Roadmap

- [ ] Add staking functionality
- [ ] Implement token vesting
- [ ] Add governance features
- [ ] Create web interface
- [ ] Add liquidity pool integration

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

For support and questions:

- 📧 Email: support@joecoin.xyz
- 💬 Discord: [JoeCoin Community](https://discord.gg/joecoin)
- 🐦 Twitter: [@JoeCoinOfficial](https://twitter.com/JoeCoinOfficial)
- 📖 Documentation: [docs.joecoin.xyz](https://docs.joecoin.xyz)

## Acknowledgments

- [Stacks](https://stacks.co/) for the blockchain platform
- [Clarinet](https://github.com/hirosystems/clarinet) for the development toolkit
- [SIP-010](https://github.com/stacksgov/sips/blob/main/sips/sip-010/sip-010-fungible-token-standard.md) for the token standard

---

**⚠️ Disclaimer**: This is a sample token for educational purposes. Always audit smart contracts before using them in production.
