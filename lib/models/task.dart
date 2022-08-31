class Task {
  String content;
  DateTime timestamp;
  bool done;

  Task({required this.content, required this.done, required this.timestamp});

// factory method are extension upon the constructor class which takes the arguments and return instances
  factory Task.fromMap(Map task) {
    return Task(
        content: task["content"],
        done: task["done"],
        timestamp: task["timestamp"]);
  }

// take the class and return a map , map is a key value pairs.

  Map toMap() {
    return {
      "content": content,
      "timestamp": timestamp,
      "done": done,
    };
  }
}
