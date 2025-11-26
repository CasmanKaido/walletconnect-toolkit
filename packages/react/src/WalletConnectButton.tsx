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
      className={\wallet-btn \\}
    >
      {connected ? 'Connected âœ…' : 'Connect Wallet'}
    </button>
  );
};
