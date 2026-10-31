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
