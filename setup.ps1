# PowerShell script to set up WalletConnect Toolkit project
# -------------------------------------------------
# 1️⃣  Create the repository folder and initialise git
# -------------------------------------------------
$repoPath = "C:\Users\XPS\Desktop\New_folder\PJS\github\walletconnect-toolkit"
if (-Not (Test-Path $repoPath)) { New-Item -ItemType Directory -Path $repoPath }
Set-Location $repoPath
if (-Not (Test-Path ".git")) { git init }
# TODO: replace <YOUR_USERNAME> with your GitHub username
git remote add origin https://github.com/<YOUR_USERNAME>/walletconnect-toolkit.git

# -------------------------------------------------
# 2️⃣  Install pnpm (global) and initialise the monorepo
# -------------------------------------------------
npm i -g pnpm
pnpm init -y
pnpm add -Dw @pnpm/workspace

# Create pnpm-workspace.yaml
@"
packages:
  - packages/*
"@ | Out-File -Encoding utf8 pnpm-workspace.yaml

# -------------------------------------------------
# 3️⃣  Scaffold folder structure
# -------------------------------------------------
mkdir packages\core
mkdir packages\react
mkdir packages\cli
mkdir packages\plugins
mkdir demo
mkdir docs

# -------------------------------------------------
# 4️⃣  Core SDK (packages/core)
# -------------------------------------------------
Set-Location packages\core
pnpm init -y
pnpm add @walletconnect/client @walletconnect/web3-provider
pnpm add -D typescript ts-node eslint prettier
@"
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "ESNext",
    "declaration": true,
    "outDir": "dist",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true
  },
  "include": ["src/**/*.ts"]
}
"@ | Out-File -Encoding utf8 tsconfig.json
mkdir src
@"
import { Client } from '@walletconnect/client';

export class WalletConnectToolkit {
  private client: Client;

  constructor(projectId: string) {
    this.client = new Client({ projectId });
  }

  async connect() {
    await this.client.connect();
    return this.client.session;
  }

  async disconnect() {
    await this.client.disconnect();
  }
}
"@ | Out-File -Encoding utf8 src\index.ts
Set-Location ..\..

# -------------------------------------------------
# 5️⃣  React UI Kit (packages/react)
# -------------------------------------------------
Set-Location packages\react
pnpm init -y
pnpm add react react-dom
pnpm add -D typescript @types/react @types/react-dom vite
@"
import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

export default defineConfig({
  plugins: [react()],
  build: { outDir: '../../demo/react' },
});
"@ | Out-File -Encoding utf8 vite.config.ts
mkdir src
@"
import React, { useState } from 'react';
import { WalletConnectToolkit } from '@walletconnect-toolkit/core';

export const WalletConnectButton = ({ projectId }: { projectId: string }) => {
  const [connected, setConnected] = useState(false);
  const wc = new WalletConnectToolkit(projectId);

  const handleConnect = async () => {
    await wc.connect();
    setConnected(true);
  };

  return (
    <button
      onClick={handleConnect}
      className={\`wallet-btn \${connected ? 'connected' : ''}\`}
    >
      {connected ? 'Connected ✅' : 'Connect Wallet'}
    </button>
  );
};
"@ | Out-File -Encoding utf8 src\WalletConnectButton.tsx
Set-Location ..\..

# -------------------------------------------------
# 6️⃣  CLI (packages/cli)
# -------------------------------------------------
Set-Location packages\cli
pnpm init -y
pnpm add commander
pnpm add -D typescript ts-node
mkdir src
@"
#!/usr/bin/env node
import { Command } from 'commander';
import { WalletConnectToolkit } from '@walletconnect-toolkit/core';

const program = new Command();

program
  .name('wc-cli')
  .description('WalletConnect Toolkit CLI')
  .version('0.1.0');

program
  .command('init <folder>')
  .description('Scaffold a new dApp with the toolkit')
  .action((folder) => {
    console.log(`Creating a new project in ${folder} …`);
    // Future: generate files here
  });

program.parse(process.argv);
"@ | Out-File -Encoding utf8 src\index.ts
Set-Location ..\..

# -------------------------------------------------
# 7️⃣  Demo dApp (Next.js)
# -------------------------------------------------
Set-Location demo
npx -y create-next-app@latest . --use-npm --no-eslint --no-tailwind --no-git
pnpm add -w @walletconnect-toolkit/core @walletconnect-toolkit/react
@"
import { WalletConnectButton } from '@walletconnect-toolkit/react';

export default function Home() {
  return (
    <main style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', marginTop: '4rem' }}>
      <h1>WalletConnect Toolkit Demo</h1>
      <WalletConnectButton projectId=\"YOUR_PROJECT_ID\" />
    </main>
  );
}
"@ | Out-File -Encoding utf8 pages\index.tsx
Set-Location ..

# -------------------------------------------------
# 8️⃣  CI workflow (GitHub Actions)
# -------------------------------------------------
mkdir .github
mkdir .github\workflows
@"
name: CI
on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: pnpm/action-setup@v2
        with:
          version: 9
      - run: pnpm install
      - run: pnpm -r lint
      - run: pnpm -r test
"@ | Out-File -Encoding utf8 .github\workflows\ci.yml

# -------------------------------------------------
# 9️⃣  Docs site (Docusaurus)
# -------------------------------------------------
Set-Location docs
npx -y create-docusaurus@latest . classic
pnpm add -w @walletconnect-toolkit/core @walletconnect-toolkit/react
Set-Location ..

# -------------------------------------------------
# 10️⃣  Good‑first‑issue template
# -------------------------------------------------
mkdir .github\ISSUE_TEMPLATE
@"
---
name: Good First Issue
about: A simple, self‑contained task for newcomers
labels: good first issue
---

## Description

Add support for **<wallet name>** adapter.

### Steps

1. Copy `packages/plugins/exampleAdapter.ts` to a new file.
2. Implement the `connect`, `disconnect`, and `signMessage` methods using the WalletConnect client.
3. Add a unit test in `tests/<wallet>-adapter.test.ts`.
4. Update the README with a usage example.

### Acceptance Criteria

- The new adapter can be imported as `@walletconnect-toolkit/plugins/<wallet>`.
- All tests pass (`pnpm test`).
"@ | Out-File -Encoding utf8 .github\ISSUE_TEMPLATE\good-first-issue.md

# -------------------------------------------------
# 11️⃣  Install all workspace dependencies
# -------------------------------------------------
Set-Location $repoPath
pnpm install

Write-Host "`nSetup complete! You can now run the demo with:`n  cd demo`n  pnpm dev`n"
