# Demo run sheet (Bank of Anthos)

Reset between runs:  git reset --hard demo-clean && git clean -fd
Start:               claude            (Manual permission mode; Shift+Tab cycles modes)
Backend:             Anthropic direct via ANTHROPIC_API_KEY in this shell.

## Move 1 (3 min): understand it and draw it
I am new to this codebase. Explain how a payment moves from the web front end to the ledger, which service validates it and what rules it checks. Keep it to what is actually in the code. Then write the flow as a draw.io diagram to docs/payment-flow.drawio and open it.

## Move 2 (6 min): ticket to pull request
Read demo/ISSUE.md and implement it. Show me your plan before editing anything. If the deployment config needs to change, update it too.
- Opens red: TransactionValidatorTest has one failing boundary test (seeded).
- Expect: plan -> approve -> edits to TransactionValidator, ExceptionMessages, tests -> hook denial on any k8s edit -> permission prompt before ./mvnw test -> green.
- Known wrinkle: the existing VALID_TRANSACTION_AMOUNT list includes Integer.MAX_VALUE; Claude has to adjust it.
- Finish: "Show me the diff summary" (no GitHub fork on this laptop).

## Move 3 (2 min, cut if behind): unattended incident triage, read-only
claude -p "Read demo/incident.log and demo/RUNBOOK.md. Following the runbook, write a short incident summary for the on-call engineer: what failed, the most likely root cause with the three log lines that prove it, and the first two steps. Plain English, under 150 words. Recommend; do not act." --allowedTools Read

## Kill rules
- Move 2 not green by minute 9: skip Move 3, show the saved diff.
- draw.io misbehaves: open the .drawio by hand or ask for a mermaid HTML instead.
- Hook does not fire: drop the "update the deployment config" clause and show .claude/settings.json.
- Anything hangs: switch to the recording. Never debug on stage.
