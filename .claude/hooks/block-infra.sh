#!/bin/bash
# PreToolUse guardrail: refuse writes under infrastructure folders.
# Covers file tools (Edit/Write/MultiEdit/NotebookEdit) and shell commands that write to those paths.
# Exit 2 blocks the tool and feeds stderr back to Claude.
input=$(cat)
read -r tool path cmd < <(printf '%s' "$input" | python3 -I -c 'import json,sys
d=json.load(sys.stdin); ti=d.get("tool_input") or {}
p=ti.get("file_path") or ti.get("notebook_path") or ""
c=(ti.get("command") or "").replace("\n"," ")
print(d.get("tool_name",""), p.replace(" ","%20") or "-", c)' 2>/dev/null)
msg="Blocked by policy: infrastructure folders (kubernetes-manifests/, iac/, k8s/) are owned by platform engineering. Open a ticket with them instead."
root="${CLAUDE_PROJECT_DIR:-$(pwd)}"
if [ "$path" != "-" ]; then
  rel="${path#"$root"/}"
  case "/$rel" in
    /kubernetes-manifests/*|/iac/*|*/k8s/*|*/kubernetes-manifests/*) echo "$msg" >&2; exit 2 ;;
  esac
fi
if [ "$tool" = "Bash" ] && printf '%s' "$cmd" | grep -qE '(kubernetes-manifests|/iac/|^iac/| iac/|/k8s/|^k8s/| k8s/)'; then
  if printf '%s' "$cmd" | grep -qE '(>|sed -i|tee |mv |cp |rm |python|perl|kubectl (apply|edit|patch)|yq |patch )'; then
    echo "$msg" >&2; exit 2
  fi
fi
exit 0
