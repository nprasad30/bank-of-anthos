# Demo run sheet (Bank of Anthos)

Reset between runs:  git reset --hard demo-clean && git clean -fd
Start:               claude   (this repo starts in manual mode via .claude/settings.json; the status line must NOT say "auto mode")
Backend:             Claude Max login; ANTHROPIC_API_KEY only as a fallback.

## Move 1 (3 min): understand it and draw it
I am new to this codebase. In plain English: how does a payment move from the web front end to the ledger, which service validates it, and what rules does it check? Answer in at most eight short lines, with the rules as a numbered list. Then draw it as a simple draw.io diagram at docs/payment-flow.drawio: at most six boxes (customer, web app, and the services a payment passes through), one arrow per hop, no internal details, and open it.

## Move 2 (6 min): ticket to tested change
Press Shift+Tab until the status line says plan mode, then paste the contents of ~/fintechco-interview/demo/ticket-PAY-1042.txt (keep it on the clipboard).
- Opens red: TransactionValidatorTest has one failing boundary test (seeded).
- Expect: plain-English plan -> "approve?" prompt -> edits to TransactionValidator, ExceptionMessages, tests -> attempt on kubernetes-manifests/ledger-writer.yaml -> hook denial -> permission prompt before ./mvnw test -> green -> three-sentence summary naming $9,999.99 and $10,000.00.
- Known wrinkle: the existing valid-amounts list includes Integer.MAX_VALUE; Claude adjusts it.

## Move 3 (2 min, cut if behind): unattended incident triage, read-only
claude -p "Read demo/incident.log and demo/RUNBOOK.md. Following the runbook, write a short incident summary for the on-call engineer: what failed, the most likely root cause with the three log lines that prove it, and the first two steps. Plain English, under 150 words. Recommend; do not act." --allowedTools Read

## Kill rules
- Move 2 not green by minute 9: skip Move 3, show the saved diff in demo/fallback.
- draw.io misbehaves: open the .drawio by hand.
- Hook does not fire: show .claude/settings.json and say the rule is there.
- Anything hangs: switch to the recording. Never debug on stage.
