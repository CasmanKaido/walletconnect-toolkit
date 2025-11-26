---
name: Good First Issue
about: A simple, selfâ€‘contained task for newcomers
labels: good first issue
---

## Description

Add support for **<wallet name>** adapter.

### Steps

1. Copy packages/plugins/exampleAdapter.ts to a new file.
2. Implement the connect, disconnect, and signMessage methods using the WalletConnect client.
3. Add a unit test in 	ests/<wallet>-adapter.test.ts.
4. Update the README with a usage example.

### Acceptance Criteria

- The new adapter can be imported as @walletconnect-toolkit/plugins/<wallet>.
- All tests pass (pnpm test).
