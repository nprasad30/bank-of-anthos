# Runbook: ledgerwriter unhealthy or rejecting transactions

1. Check recent deploys of ledgerwriter (look for "deploy ledgerwriter" markers in the last 60 minutes).
2. Check database connection pool stats (HikariPool active/idle/waiting) for exhaustion.
3. Check readiness probe results (/ready) and whether pods were restarted.
4. Check ledger-db for "remaining connection slots are reserved" or connection refusals.
5. Mitigation A: roll back ledgerwriter to the previous version.
6. Mitigation B: raise the pool size or restart pods to release leaked connections.
7. Confirm transactions are being accepted again before closing the incident.
8. Escalate to platform engineering if the database itself is saturated.
9. Open a post-mortem ticket with the three log lines that proved the cause.
10. Do not change kubernetes-manifests/ during an incident; platform engineering owns rollouts.
