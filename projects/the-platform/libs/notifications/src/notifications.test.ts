import { WebPubSubServiceClient } from '@azure/web-pubsub';
import { AzureWebPubSubNotifications } from './notifications';
import { jest } from '@jest/globals';
import { beforeEach } from '@jest/globals';

jest.mock('@azure/web-pubsub');

let notifications: AzureWebPubSubNotifications;
let mockSendToAll: jest.Mock;

beforeEach(() => {
  mockSendToAll = jest.fn();
  (WebPubSubServiceClient as jest.Mock).mockImplementation(() => {
    return {
      sendToAll: mockSendToAll,
    };
  });
  notifications = new AzureWebPubSubNotifications('connectionString', 'hubName');
});

test('register adds a callback to the handlers', () => {
  const callback = jest.fn();
  notifications.register('topic', callback);
  expect(notifications['handlers']['topic']).toContain(callback);
});

test('unregister removes a callback from the handlers', () => {
  const callback = jest.fn();
  notifications.register('topic', callback);
  notifications.unregister('topic', callback);
  expect(notifications['handlers']['topic']).not.toContain(callback);
});

test('sendNotification sends a message and calls the callbacks', async () => {
  const callback = jest.fn();
  notifications.register('topic', callback);
  await notifications.sendNotification('topic', 'message');
  expect(mockSendToAll).toHaveBeenCalledWith({ topic: 'topic', message: 'message' });
  expect(callback).toHaveBeenCalledWith('message');
});