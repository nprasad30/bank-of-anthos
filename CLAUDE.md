# Bank of Anthos (demo fork)

## Commands
- Python tests: cd src/accounts/userservice && uv run pytest -q tests
- Java tests (summary only): ./mvnw -q -pl src/ledger/ledgerwriter test 2>&1 | grep -E "Tests run:|BUILD|FAIL|expected"

## Rules
- Amounts are stored in cents (int), never dollars.
- Every change to the ledger comes with a test.
- Error messages live in ExceptionMessages, never inline strings.

## Working style
- Explore and read code with the Read, Grep, and Glob tools, not shell commands. Use shell commands only to run tests, git, and to open files.
- When asked for a diagram, write the file with the Write tool, then open it with `open <path>`.
