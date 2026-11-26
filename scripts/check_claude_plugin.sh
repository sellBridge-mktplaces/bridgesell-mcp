#!/usr/bin/env bash
# Confere o plugin contra o checklist do diretório do Claude
# (https://claude.com/docs/plugins/pre-submission-checklist) antes de submeter em
# claude.ai/directory/manage. Não altera nada; sai com 1 se algo bloquear.
set -euo pipefail
cd "$(dirname "$0")/../plugin"
fail=0
bad() { echo "BLOQUEIA: $*" >&2; fail=1; }

[ -f .claude-plugin/plugin.json ] || bad "falta .claude-plugin/plugin.json"
python3 -I - <<'PY' || fail=1
import json, re, sys
m = json.load(open(".claude-plugin/plugin.json"))
errs = []
if not re.fullmatch(r"[a-z0-9]([a-z0-9-]{0,62}[a-z0-9])?", m.get("name", "")):
    errs.append("name deve ter só minúsculas, dígitos e hífens (máx. 64)")
for k in ("description", "author", "version"):
    if not m.get(k):
        errs.append(f"falta {k} (aviso)")
mcp = json.load(open(".mcp.json"))
for n, s in mcp.get("mcpServers", {}).items():
    if s.get("type") not in ("http", "sse", "ws") or not str(s.get("url", "")).startswith(("https://", "wss://")):
        errs.append(f"servidor MCP {n}: precisa de type http/sse/ws e url https")
    if "headers" in s:
        errs.append(f"servidor MCP {n}: sem credenciais em headers")
if errs:
    print("\n".join("BLOQUEIA: " + e for e in errs), file=sys.stderr); sys.exit(1)
PY

words=$(python3 -I -c "
import re
t=re.sub(r'\`\`\`.*?\`\`\`','',open('README.md').read(),flags=re.S)
print(len(re.findall(r'\w+',t)))" 2>/dev/null || echo 0)
[ "$words" -ge 40 ] || bad "README.md precisa de 40+ palavras fora de blocos de código (tem $words)"
{ [ -f LICENSE ] || grep -q '"license"' .claude-plugin/plugin.json; } || bad "falta LICENSE ou campo license"

find . \( -name .DS_Store -o -name Thumbs.db -o -name desktop.ini -o -name __MACOSX \) | grep . && bad "arquivos de sistema no plugin" || true
find . -type l | grep . && bad "links simbólicos no plugin" || true
find . -type f -size +256k | grep . && echo "AVISO: arquivo >256 KiB fica retido para revisão" >&2 || true
grep -rn "TODO" . && bad "há TODO no plugin" || true

if command -v claude >/dev/null; then (cd .. && claude plugin validate ./plugin) || fail=1
else echo "AVISO: 'claude' não instalado; pulei claude plugin validate" >&2; fi

[ "$fail" = 0 ] && echo "OK: plugin passa nas checagens locais do diretório do Claude."
exit "$fail"
