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
    console.log(Creating a new project in  â€¦);
    // Future: generate files here
  });

program.parse(process.argv);
