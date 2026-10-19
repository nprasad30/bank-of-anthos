#!/bin/bash
# PreToolUse guardrail: refuse edits under infrastructure folders.
# Reads the hook JSON on stdin; exit 2 blocks the tool and feeds stderr back to Claude.
input=$(cat)
path=$(printf '%s' "$input" | python3 -I -c 'import json,sys
d=json.load(sys.stdin); ti=d.get("tool_input") or {}
print(ti.get("file_path") or ti.get("notebook_path") or "")' 2>/dev/null)
[ -z "$path" ] && exit 0
root="${CLAUDE_PROJECT_DIR:-$(pwd)}"
rel="${path#"$root"/}"
case "/$rel" in
  /kubernetes-manifests/*|/iac/*|*/k8s/*|*/kubernetes-manifests/*)
    echo "Blocked by policy: infrastructure folders are owned by platform engineering. Open a ticket with them instead." >&2
    exit 2 ;;
esac
exit 0
