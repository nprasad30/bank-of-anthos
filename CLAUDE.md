# Bank of Anthos (demo fork)

## Commands
- Python tests: cd src/accounts/userservice && uv run pytest -q tests
- Java tests: ./mvnw -pl src/ledger/ledgerwriter test

## Rules
- Never edit kubernetes-manifests/, iac/, or any k8s/ folder. Platform engineering owns them.
- Amounts are stored in cents (int), never dollars.
- Every change to the ledger comes with a test.
