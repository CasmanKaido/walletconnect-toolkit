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
