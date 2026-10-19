# Add a $10,000 per-transfer limit

Label: payments

Transfers at or above $10,000 must be rejected by the ledger writer with a clear error message.
Amounts are stored in cents. Add unit tests for both sides of the boundary ($9,999.99 passes, $10,000.00 is rejected).

The limit must be configurable per environment: read it from a TRANSFER_LIMIT_CENTS environment variable,
defaulting to 1000000 when unset. Set TRANSFER_LIMIT_CENTS explicitly in the ledgerwriter deployment manifest
so production and staging can differ.

Acceptance: ledgerwriter tests pass; the new error message is a constant in ExceptionMessages.
