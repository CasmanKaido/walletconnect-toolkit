# WalletConnect Toolkit

**A premium, modular, open‑source toolkit for adding WalletConnect v2 support to any web3 project.**

---

## 🎯 What is this?

The WalletConnect Toolkit provides:
- A **core TypeScript SDK** that wraps the official WalletConnect v2 client.
- A **React UI kit** with a ready‑to‑use `<WalletConnectButton>` component (glass‑morphism, dark‑mode ready).
- A **CLI** (`wc-cli`) to scaffold new dApps.
- A **demo Next.js app** that shows a full connection flow.
- **GitHub Actions CI**, Docusaurus documentation site, and a **good‑first‑issue template** to attract contributors.

All pieces are organized as a **pnpm monorepo**, making it easy to develop and publish each package independently.

---

## 🚀 Quick start

```bash
# Clone the repo
git clone https://github.com/CasmanKaido/walletconnect-toolkit.git
cd walletconnect-toolkit

# Install pnpm globally if you don’t have it
npm i -g pnpm

# Install all workspace dependencies
pnpm install

# Run the demo (Next.js) – replace YOUR_PROJECT_ID with a WalletConnect project ID
cd demo
pnpm dev
```

Open `http://localhost:3000` in your browser and click **Connect Wallet**.

---

## 📦 Packages

| Package | Description |
|---------|-------------|
| `@walletconnect-toolkit/core` | Thin wrapper around the official WalletConnect v2 client. |
| `@walletconnect-toolkit/react` | React components (`WalletConnectButton`, modal, theming). |
| `@walletconnect-toolkit/cli` | CLI to scaffold new projects (`wc-cli init <folder>`). |
| `demo` | Next.js demo app showing the SDK in action. |
| `docs` | Docusaurus site – usage guides, API reference, contribution guide. |

---

## 🛠️ Development

```bash
# Run tests for all packages
pnpm -r test

# Lint all packages
pnpm -r lint
```

Add new wallet adapters under `packages/plugins/` and update the **Good First Issue** template to invite contributors.

---

## 🤝 Contributing

We welcome contributions! Please read our [CONTRIBUTING.md](CONTRIBUTING.md) for:
- How to set up a development environment.
- Code style & linting guidelines.
- The process for submitting pull requests.
- A list of **good‑first‑issues** to get started.

---

## 📜 License

MIT © 2025 CasmanKaido

---

## 🙏 Acknowledgements

- **WalletConnect** – for the underlying protocol.
- **pnpm** – for fast, deterministic monorepo management.
- **Next.js**, **React**, **Docusaurus** – for the demo, UI kit, and docs.

---

*Built with love, glass‑morphism, and a dash of premium design.*
