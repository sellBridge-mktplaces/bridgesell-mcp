# BridgeSell

BridgeSell connects Claude to the stores you already manage in BridgeSell, so you can ask about your marketplace business in plain language.

## What it does

The plugin points Claude at the BridgeSell MCP server (`https://bridgesell-iris.onrender.com/mcp`) and adds a skill that teaches Claude which tool to use for each question.

- Orders and alerts on Amazon and Mercado Livre: totals, status, cancellations, mediations and returns.
- Stock and listings: out-of-stock items and listing search on Amazon, Mercado Livre, Shopee and TikTok Shop.
- Catalog compliance on Amazon and Mercado Livre.
- Finances on Amazon and Mercado Livre: payments, refunds, fees and Mercado Livre billing.
- Connection and sync status of every connected store, so answers say how fresh the data is.

## Read-only and private

Every tool is read-only: nothing can change prices, stock, listings or orders, and nothing sends messages. Buyers' personal data is never returned. Each call uses your own BridgeSell sign-in and only your own stores.

## Requirements

An active BridgeSell account. When you first use the plugin, Claude asks you to sign in to BridgeSell (OAuth) and approve read access.

## Install in Claude Code

```
/plugin install bridgesell --marketplace sellBridge-mktplaces/bridgesell-mcp
```

## Example questions

- How were my sales in the last 7 days?
- Which of my listings are out of stock?
- Which orders have alerts right now?

## Links

- Website: https://www.bridgesell.ai
- Privacy policy: https://www.bridgesell.ai/politica-de-privacidade/
- Support: https://www.bridgesell.ai/politica-de-privacidade/#quem-somos
