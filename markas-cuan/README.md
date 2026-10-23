# MARKAS CUAN

YooImprove-style business dashboard with MARKAS CUAN branding and encrypted browser-local data. Published under `/ajidarma/markas-cuan/`; legacy `/yooimprove/` is unchanged.

## First use

1. Open **Buka brankas**, create a unique password of at least 12 characters, and keep it safe. There is no password recovery.
2. In **Penyimpanan & keamanan**, choose **Salin data YooImprove** from the same browser/profile and GitHub Pages origin used before. Alternatively, import the old JSON backup.
3. Migration preserves member IDs, contacts, dates, historical prices, payments, and expenses. Original YooImprove storage is never overwritten. Old product catalog is not imported; non-membership historic receipts remain as historical income to preserve cash totals. Demo data is rejected.
4. Download an encrypted backup regularly. Recover it on another device through the locked vault screen with its original password. Do not upload business backups to GitHub.

## Supported membership prices

| Package | Original | Promo | Discount |
| --- | ---: | ---: | ---: |
| VIP Umum, 1 month | Rp250.000 | Rp150.000 | 40% |
| VIP Umum, 2 months | Rp380.000 | Rp247.000 | 35% |
| VIP Umum, 1 year | Rp800.000 | Rp500.000 | 37,5% |
| VIP Privat, 1 month | Rp320.000 | Rp200.000 | 37,5% |

New registrations and renewals use only these packages. Historical membership durations and prices remain unchanged on migration. Expiry is inclusive (calendar-month addition clamped to month end, minus one day). Renewal extends from the day after the current end, or today if expired, and preserves existing active access. Payments are full manual receipts, not installment tracking or payment gateway confirmation. Cash reports count receipts by payment date, not accrual accounting.

## Security and operational limits

- The default page shows the original dashboard layout with locked placeholders; it never reads or renders private member/financial records before unlock. No private business data, default password, or API secret is shipped.
- Vault: AES-256-GCM; PBKDF2-SHA256, 310,000 iterations; random 16-byte salt and fresh 12-byte nonce for each save. Password/key is never persisted. Auto-lock after 10 minutes without interaction.
- This is NOT server authentication or a multi-user database. It does not restrict who can download the application code. Each browser has its own independent data.
- All paths on `darmagz05.github.io` share an origin. Other same-origin code can read/change localStorage ciphertext. A compromised device, extension, same-origin script, or deployed code can attack an unlocked session. Encryption does not secure the unencrypted YooImprove original; it remains untouched for compatibility. After verifying migration and offline backups, separately decide how to retire that original.
- Browser clearing, private browsing, disk failure, or forgotten passwords can lose data. Backups are essential. Imports preserve an encrypted pre-import snapshot locally; recovery replaces data only after validation and confirmation.
- CSP blocks external scripts and network requests. No analytics, third-party fonts, or remote dependencies. CSV export guards text against spreadsheet formula injection.
- For shared staff access or real online administration, add server authentication, authorization, a protected database, audit logs and backups before storing sensitive production information online.
- Membership descriptions are based on the prior site; detailed schedules/session entitlements require operator confirmation. No contact number was invented, so registration is through the operator's existing official channel.

## Run locally

Serve this directory over localhost (for example `python -m http.server 8765`). Web Crypto requires HTTPS or localhost. Open `http://localhost:8765/`.

