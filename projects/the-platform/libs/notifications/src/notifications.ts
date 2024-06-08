// class that implements the Notifications interface by sending and receiving notifications from a server

import { WebPubSubServiceClient } from '@azure/web-pubsub';

class AzureWebPubSubNotifications implements Notifications {
  private client: WebPubSubServiceClient;
  private handlers: { [topic: string]: ((message: string) => void)[] } = {};

  constructor(connectionString: string, hubName: string) {
    this.client = new WebPubSubServiceClient(connectionString, hubName);
  }

  register(topic: string, callback: (message: string) => void): void {
    if (!this.handlers[topic]) {
      this.handlers[topic] = [];
    }
    this.handlers[topic].push(callback);
  }

  unregister(topic: string, callback: (message: string) => void): void {
    if (!this.handlers[topic]) {
      return;
    }
    this.handlers[topic] = this.handlers[topic].filter(cb => cb !== callback);
  }

  async sendNotification(topic: string, message: string): Promise<void> {
    await this.client.sendToAll({ topic, message });
    if (this.handlers[topic]) {
      this.handlers[topic].forEach(cb => cb(message));
    }
  }
}

export { AzureWebPubSubNotifications };