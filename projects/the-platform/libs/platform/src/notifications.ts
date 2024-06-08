interface Notifications {
    // function to register for notifications for a topic
    register(topic: string, callback: (message: string) => void): void;
    // function to unregister for notifications for a topic
    unregister(topic: string, callback: (message: string) => void): void;
}


