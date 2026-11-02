# Analyst-Studio (TopicCast Studio)

A single-file HTML app: AI research agents produce fully narrated, source-cited podcast episodes,
run the Trading Analyst Pipeline (daily call scout, CFA desk, debating researchers, investment manager,
expert guest), track every opportunity through a Results ledger with live position P&L, and play the show with studio voices.

The daily call is calendar-first: the scout scans the **next 10 days of catalysts** — earnings dates,
Treasury auctions, CPI/PPI/Fed prints, prediction-market contracts and the sports slate, every date
verified three ways (in-window, weekday-matched, source-confirmed) — and treats today's street
research as the secondary source. Under **Settings → Daily auto-call** the call can run itself when
the app opens (a prompt banner, or fully automatic — prices are verified at run time, so the desk
works when you open it), and any idea that fails price validation is dropped from the board before
the show is written. The **📋 Ledger** button copies the whole board as log-ready entries in the
daily scan's ledger format for the append-only trading opportunity log.

Every BUY/SELL opportunity on the board is auto-scored by an embedded causal-entropic engine
(F = T·∇Sτ): a second opinion on whether committing to the trade preserves more of the desk's
future freedom of action than staying in cash — shown as 🌀 F chips, with a per-opportunity
deep-dive (editable priors, re-score) and the score synced to the cloud track record. Treat it
as a second opinion beside expected value, not a verdict: entropic scores can be anti-predictive,
and the app shows the raw number rather than hiding it.

## Single-opportunity analysis & country context

Next to the daily call, the **Analysts** tab analyzes one opportunity you type in — the CFA desk
researches it, the debating researchers argue it for and against, and the investment manager
delivers her verdict. The **🌍 Context** button sets the country the symbol trades in (21 markets,
or Auto: the country is inferred from the exchange suffix — `.TO`, `.L`, `.T` — or market
keywords like TSX, FTSE or Nikkei, defaulting to the US), and the whole desk then works in that
country's market context: native exchange and currency, regulator and central bank, national
data sources and macro drivers. Before the desk runs, the submitted symbol is also resolved against
a live market-data feed: Yahoo Finance quotes fetched through the Jina reader proxy (r.jina.ai),
which is keyless and browser-callable (CORS-verified). International exchange suffixes (`.AX`,
`.TO`, `.L`, `.T`…) resolve verbatim, bare tickers get the country's suffix (`mp1` + Australia →
**MP1.AX — Megaport Ltd**), and the desk receives the resolved quote as the verified price; any
UNCONFIRMED price on the final call is replaced with the live quote. An unresolvable symbol simply
skips the quote — the run proceeds research-driven. The 🔎 Live price buttons (Monitor and Results)
try the same feed first and fall back to the agent's web search.

## Economics dashboard & world markets

The **Economics** tab is a live dashboard of economic indicators and world market data built from
free, keyless official APIs: the US Treasury daily yield curve (3-month through 30-year, with
1-day moves and curve spreads), BLS labour and inflation releases (unemployment, payrolls,
participation, earnings, CPI / core CPI / PPI year over year), World Bank global macro (GDP
growth, inflation, unemployment, GDP per capita, current account across the major economies),
ECB FX reference rates for the US dollar, and live crypto (BTC, ETH, SOL with 24-hour moves).
Press **▶ Analysts Call** and a business journalist delivers a spoken one-minute update on the
most recent business and economic headlines — each headline a named link that opens its source
website. Global equities and commodities (S&P 500, developed-world and emerging equities, gold,
silver, oil via ETF quotes) are optional: add a free Alpha Vantage key in the Settings tab.
Live equity quotes for the analysis desk come through the Jina reader proxy (see the analysis
section above); direct Yahoo, Stooq and FRED API calls all block browser requests (no CORS), and
Trading Economics has no free API, which is why the dashboard uses open official sources everywhere else.

## Run it

Open the GitHub Pages URL below, then add your Mistral API key in the **Settings** tab
(get one at console.mistral.ai). The key is stored only in your own browser's local storage.

Live app: https://funkyfish49-ops.github.io/Analyst-Studio/

Everything runs client-side in the browser — there is no server component.

## Results ledger

The **Results** tab is the ledger of every analyzed opportunity: one-line rows with entry, stop,
target, current price and P&L (percent and dollars), filters by category and status, and sorting
by recency, P&L, confidence or horizon. Positions close themselves by category-distinct rules —
stocks and bonds auto-close when the target or stop level is crossed, prediction contracts close
at effective resolution (>=98.5¢ / <=1.5¢), sports odds resolve manually, and anything still
open past its 10-day horizon completes as expired. Closed positions never flip on later prices,
and the whole ledger syncs to the cloud track record when signed in.

## Forecast Lab

The standalone **Entropic Forecast Lab** lives at
https://funkyfish49-ops.github.io/Analyst-Studio/forecast-lab/ — the research companion to the
desk's second-opinion scores: score any single opportunity (EV, ∇Sτ, F, impairment probability)
and walk-forward backtest the engine itself (F-filter vs always-in vs cash, F-quintiles,
Spearman rank IC) on 5 years of daily closes for SPY, QQQ, AAPL, NVDA, TSLA and GLD.
The data snapshots in `forecast-lab/data/` refresh automatically every weekday evening after
the US close (GitHub Actions), and crypto series stream live from Binance.

## Cloud sync & track record (optional)

Sign in with Google from **Settings → ☁️ Cloud sync** to save episodes, opportunities and topics
to your own private Firestore (see the [firebaseSA](https://github.com/funkyfish49-ops/firebaseSA)
repo for the database design and security rules). The Monitor tab tracks each opportunity's
track record (won / lost / void) and its check history — with each opportunity's entropic score
stored at decision time, so the track record doubles as the engine's out-of-sample evaluation.
Without sign-in, the app works fully offline from browser local storage.
