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

## Install as an app (phone & PC)

The site is a Progressive Web App: on Android, Chrome menu → **Add to Home screen / Install app** installs a full-screen TopicCast app with its own icon; on a PC, Chrome or Edge offers the install icon in the address bar (or the ⋮ menu → **Install app**), which opens the studio in its own window with a taskbar entry. Installed app and browser site share the same browser local storage, so the API key and settings are entered once per device and do not sync between phone and PC.

## Results ledger

The **Results** tab is the ledger of every analyzed opportunity: one-line rows with entry, stop,
target, current price and P&L (percent and dollars), filters by category and status, and sorting
by recency, P&L, confidence or horizon. Positions close themselves by category-distinct rules —
stocks and bonds auto-close when the target or stop level is crossed, prediction contracts close
at effective resolution (>=98.5¢ / <=1.5¢), sports odds resolve manually, and anything still
open past its 10-day horizon completes as expired. Closed positions never flip on later prices,
and the whole ledger syncs to the cloud track record when signed in.

## Knowledge base

The **Knowledge** tab is the desk's living knowledge base: versioned cards of what the research
has established, one card per fact or theme, organized into six evolving categories (Market,
Economic, Industry, Social media, Stock-specific, Other) with a facet rubric each so depth is
measurable. Cards carry claims with a 0-100 confidence and dated sources; every commit, edit,
verification or retirement lands in a per-card version timeline. Freshness is policy-driven —
each card declares its own re-verify window, and cards past it go stale, then overdue, surfacing
in the review queue where they can be verified, revised or retired in one click. The coverage &
depth map shows how many cards cover each facet per category (with average claim confidence)
plus each lens's learned reliability weights once 5+ resolved outcomes accumulate. Cards can be
added or edited manually (claims one per line as `text | confidence | basis`, sources as
`url | date`). Storage is per-device for now; cloud sync for the knowledge base lands in a
later round.

Round 15 wires the desk to this base end to end. While forming calls, the CFA desk and the
investment manager receive the established cards (with staleness labels and cite keys) plus any
earned lens-reliability weights as prompt context — key-scoped to the submitted symbol in
single-opportunity analysis. The manager records which lenses moved each call in the CALL DATA
(`kb` field: per-lens direction -1..1, magnitude 0-1, cited card keys, one-line note), sanitized
at parse time and frozen into a KB decision at board freeze. Every Won/Lost resolution — manual,
target/stop auto-close, or a cloud ledger row — feeds the outcome back into the lens weights:
an aligned lens gains trust on the side it supported, a dissenting lens gains trust on the side
it warned about. Voids, expiries, no-entry calls and re-resolutions never move the weights, and
a lens's weights only enter prompts once it holds 5+ resolved outcomes.

Round 16 adds the ingestion route. The **📡 Sources & digestion** card on the Knowledge tab holds a
registry of sources — any URL, added as a *feed* (digest it again any time) or *once* (a one-time
read), optionally pinned to one category lens. "Digest now" (or "Digest due" for every pending
source) has the research agent read the source with web search and **propose** up to 3 new cards,
3 claims to add to existing cards, and 3 contradictions against them — the proposal lands in the
review queue as an unreviewed digest, and nothing enters the base until you accept it there:
"Save as card", "Apply" (one claim onto an existing card, versioned like any edit), or "Edit" to
tune the proposal in the card editor first. Accepted items link back to their source, and a
source's last digest and contributed-card count show beside it. This round also restores
`mistral-large-4` to the Settings model select — Large 4 is GA and supports built-in connectors
again — with stale stored models falling back to the default.

Round 17 syncs the knowledge base itself. A new **☁️ Sync KB** button beside "Compact storage"
in the Coverage card does a stateless, idempotent two-way sync over the owner-scoped
`kb_*` Firestore collections (cards, timeline events, decisions, sources, digests and the
per-category weight docs; the security rules shipped with the cloud rounds already cover
them): pull merges the cloud into the local base first — cards by version number, events as
a union of both append-only logs, decisions by the newer outcome, sources and digests by
content, weights by sample count — then push publishes what the cloud lacks or trails.
Nothing is ever deleted remotely and nothing double-counts: events are append-only in the
cloud, decisions are frozen at creation, and weight docs only move forward. While you are
signed in, every knowledge write (card edits, verifications, accepted proposals, digests,
frozen decisions, resolved outcomes) also auto-pushes a few seconds later, and a fresh
device that signs in with an empty base pulls the cloud copy automatically — so the whole
base travels between phone and PC. The coverage line shows the last sync time, and the base
still lives in local storage, so nothing is lost offline.

Round 18 adds the evolution dashboard. The **📈 Evolution** card on the Knowledge tab plots,
per lens, the full weight history — long-trust (×wl) and short-trust (×ws) as lines over time
against the neutral 1.0 baseline — next to a bar strip of the P&L of every resolved decision
the lens shaped (hover a bar for its date and %). Attribution mirrors the weight updater
exactly: only buy/sell decisions, only lenses that held a real view (|d| ≥ 0.05), voids never
count. Under each chart: resolved counts and win rate, average win/loss, total P&L, and the
split that matters — the win rate when the lens was *aligned* with the trade versus when it
*dissented* (warned against the side taken) — so you can see whether a lens's trust is
actually earned. A ledger strip on top summarizes every resolved decision, and a lens only
counts as "trusted" once it holds 5+ outcomes, exactly as the desk does.

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
Your optional **Alpha Vantage key** rides the same sign-in: once you're signed in it is
stored on your private cloud profile and restored automatically on every device you sign
into (clearing it stays local to that device), so the Economics market tiles work on phone
and PC without re-entering it.

Without sign-in, the app works fully offline from browser local storage.
