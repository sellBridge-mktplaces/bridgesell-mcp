# Security policy

This repository holds the BridgeSell plugin for Claude Code (manifest, MCP connection and
skill). It contains no server code. The plugin connects to the BridgeSell MCP server, which
is read-only: it only forwards GET requests to the BridgeSell API with the signed-in
seller's own token.

## Reporting a vulnerability

Please do not open a public issue. Email **privacidade@bridgesell.ai** with the details and
steps to reproduce. We acknowledge reports within 5 business days.

You can also use GitHub's private vulnerability reporting (Security tab > Report a
vulnerability) when it is enabled on this repository.

## What never belongs in this repository

Passwords, API keys, tokens, signing keys, reviewer or test-account logins, customer data.
The plugin signs users in through OAuth in the client, so no credential is stored here.
