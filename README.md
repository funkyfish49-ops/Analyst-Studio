# Analyst-Studio (TopicCast Studio)

A single-file HTML app: AI research agents produce fully narrated, source-cited podcast episodes,
run the Trading Analyst Pipeline (market scanner, CFA desk, debating researchers, investment manager,
expert guest), monitor opportunities, and play the show with studio voices.

Every BUY/SELL opportunity on the board is auto-scored by an embedded causal-entropic engine
(F = T·∇Sτ): a second opinion on whether committing to the trade preserves more of the desk's
future freedom of action than staying in cash — shown as 🌀 F chips, with a per-opportunity
deep-dive (editable priors, re-score) and the score synced to the cloud track record. Treat it
as a second opinion beside expected value, not a verdict: entropic scores can be anti-predictive,
and the app shows the raw number rather than hiding it.

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
No free, browser-callable source exists for live equity/commodity prices (Trading Economics has
no free API; Yahoo, Stooq and the FRED API all block browser requests), which is why the app uses
open official sources everywhere else.

## Run it

Open the GitHub Pages URL below, then add your Mistral API key in the **Settings** tab
(get one at console.mistral.ai). The key is stored only in your own browser's local storage.

Live app: https://funkyfish49-ops.github.io/Analyst-Studio/

Everything runs client-side in the browser — there is no server component.

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
