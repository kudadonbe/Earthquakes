# Decoding structured JSON

## Starting Project

Use this project to code along with [Decoding structured JSON](https://developer.apple.com/tutorials/app-dev-training/decoding-structured-json).


### **Key Differences to Keep in Mind:**
- In Swift, especially with iOS development, you’ll interact with APIs using `URLSession` instead of `Axios` or `fetch`.
- Swift’s `async/await` works similarly to JavaScript’s `async/await`.
- Instead of `JSON.parse()`, Swift uses `Codable` with `JSONDecoder` and `JSONEncoder` for JSON handling.

---

### 🚀 **Let’s Break Down a Simple CRUD Example in Swift**

We’ll simulate a basic **Todo** app interacting with an API like `jsonplaceholder.typicode.com`.

---

### **1️⃣ CREATE (POST Request)**

```swift
struct Todo: Codable {
    let userId: Int
    let title: String
    let completed: Bool
}

func createTodo() async throws {
    guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos") else { return }
    
    let newTodo = Todo(userId: 1, title: "Learn Swift", completed: false)
    let jsonData = try JSONEncoder().encode(newTodo)
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = jsonData
    
    let (data, _) = try await URLSession.shared.data(for: request)
    let createdTodo = try JSONDecoder().decode(Todo.self, from: data)
    
    print("Created Todo: \(createdTodo)")
}

Task {
    try await createTodo()
}
```

---

### **2️⃣ READ (GET Request)**

```swift
func fetchTodos() async throws {
    guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos") else { return }
    
    let (data, _) = try await URLSession.shared.data(from: url)
    let todos = try JSONDecoder().decode([Todo].self, from: data)
    
    for todo in todos.prefix(5) { // Just to limit output
        print("Todo: \(todo.title) - Completed: \(todo.completed)")
    }
}

Task {
    try await fetchTodos()
}
```

---

### **3️⃣ UPDATE (PUT Request)**

```swift
func updateTodo() async throws {
    guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1") else { return }
    
    let updatedTodo = Todo(userId: 1, title: "Updated Title", completed: true)
    let jsonData = try JSONEncoder().encode(updatedTodo)
    
    var request = URLRequest(url: url)
    request.httpMethod = "PUT"  // Use PATCH if updating only specific fields
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = jsonData
    
    let (data, _) = try await URLSession.shared.data(for: request)
    let todo = try JSONDecoder().decode(Todo.self, from: data)
    
    print("Updated Todo: \(todo)")
}

Task {
    try await updateTodo()
}
```

---

### **4️⃣ DELETE (DELETE Request)**

```swift
func deleteTodo() async throws {
    guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1") else { return }
    
    var request = URLRequest(url: url)
    request.httpMethod = "DELETE"
    
    let (_, response) = try await URLSession.shared.data(for: request)
    
    if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
        print("Todo deleted successfully.")
    } else {
        print("Failed to delete todo.")
    }
}

Task {
    try await deleteTodo()
}
```

---

### **Comparing with Laravel/Express/Vue:**

| **Concept**               | **Laravel/Express/Vue/React**         | **Swift (iOS)**                  |
|:--------------------------|:-------------------------------------|:---------------------------------|
| HTTP Requests             | `axios.get()`, `fetch()`             | `URLSession.shared.data()`       |
| Data Serialization        | `JSON.stringify()`, `JSON.parse()`   | `JSONEncoder()`, `JSONDecoder()` |
| Async Handling            | `async/await`, Promises              | `async/await`, `Task {}`         |
| Error Handling            | `try/catch`                          | `do-try-catch`                   |
| API Communication         | RESTful APIs (routes/controllers)    | RESTful APIs via `URLRequest`    |

---

### **What’s Next?**
- **State Management:** Look into SwiftUI’s `@State`, `@ObservedObject`, and `@EnvironmentObject`.
- **Advanced Networking:** Explore third-party libraries like **Alamofire** for simplified networking.
- **Persistence:** Learn about `CoreData` or `UserDefaults` for local data storage.

Let me know if you’d like to dive deeper into any specific part, or if you'd like help building a mini project in Swift!
