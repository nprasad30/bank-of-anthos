# Add a $10,000 per-transfer limit

Label: payments

Transfers at or above $10,000 must be rejected by the ledger writer with a clear error message.
Amounts are stored in cents. Add unit tests for both sides of the boundary ($9,999.99 passes, $10,000.00 is rejected).
Do not change deployment configuration; if you think it needs to change, say so in the PR description.

Acceptance: ledgerwriter tests pass; the new error message is a constant in ExceptionMessages.
