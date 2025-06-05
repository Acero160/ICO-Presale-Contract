# INITIAN COIN OFFER

This contract manages the sale of **Dubai2040** tokens in exchange for **Ether**.

- Owner-only configuration of token address and sale price  
- Secure token purchase with overflow checks  
- Ether forwarding to the owner  
- Functions for full token withdrawal, manual Ether transfer, and sale tracking

---

## 🔑 Key Functions

- `buyToken(uint256 amount) payable`: Buy tokens by sending the exact Ether  
- `updateToken(address)`: Set the ERC20 token to be sold  
- `updateTokenSalePrice(uint256)`: Set the sale price per token  
- `withdrawAllTokens()`: Withdraw all remaining tokens to owner  
- `transferEther(address, uint256)`: Send Ether to any receiver  
- `transferToOwner(uint256)`: Manually send Ether to owner

---

## 🔐 Security Features

✅ Uses `require` extensively for input and state validation  
✅ `onlyOwner` modifier restricts admin actions  
✅ Overflow/underflow protection via Solidity >= 0.8.0  
✅ Pattern: checks → effects → interactions (used with caution)

⚠️ Token assumes 18 decimals (validate before deployment)  
⚠️ No rate-limiting, frontrunning protection or KYC checks (out of scope)

---

## 🧪 Testing

Unit tests are written using **Foundry's Forge** framework.

To run the tests:

```bash
forge test -vv
```


##  ✅ Test Coverage Includes:

- ✅ Successful token purchase and balance update

- ✅ Failing token purchase with incorrect Ether

- ✅ Withdrawal of all tokens to owner

- ✅ Ether transfer to owner and arbitrary addresses

- ✅ Sale price and token address configuration
