import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minhas Tarefinhas ✨',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 16),
          titleLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      home: const TodoListScreen(),
    );
  }
}

class Task {
  String name;
  bool isDone;

  Task(this.name, {this.isDone = false});
}

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Task> _tasks = [];

  void _addTask() {
    String text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _tasks.add(Task(text));
        _controller.clear();
      });
    }
  }

  void _toggleTask(Task task) {
    setState(() {
      task.isDone = !task.isDone;
    });
  }

  void _removeTask(Task task) {
    setState(() {
      _tasks.remove(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        backgroundColor: Colors.teal.shade400,
        title: const Text('✨ Minhas Tarefinhas'),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Campo de texto + botão
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'O que precisa ser feito?',
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 14.0,
                        horizontal: 16.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal.shade400,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _addTask,
                  child: const Text('adicionar'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Lista
            Expanded(
              child:
                  _tasks.isEmpty
                      ? const Center(
                        child: Text(
                          'Nenhuma tarefa por enquanto 🙌',
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                      : ListView.builder(
                        itemCount: _tasks.length,
                        itemBuilder: (context, index) {
                          final task = _tasks[index];
                          return Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            margin: const EdgeInsets.symmetric(
                              vertical: 6,
                              horizontal: 0,
                            ),
                            child: ListTile(
                              leading: GestureDetector(
                                onTap: () => _toggleTask(task),
                                child: Icon(
                                  task.isDone
                                      ? Icons.check_circle_rounded
                                      : Icons.radio_button_unchecked,
                                  color:
                                      task.isDone
                                          ? Colors.teal
                                          : Colors.grey.shade400,
                                ),
                              ),
                              title: Text(
                                task.name,
                                style: TextStyle(
                                  fontSize: 16,
                                  decoration:
                                      task.isDone
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                  color:
                                      task.isDone
                                          ? Colors.grey.shade600
                                          : Colors.black87,
                                ),
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete_outline_rounded),
                                color: Colors.redAccent,
                                onPressed: () => _removeTask(task),
                              ),
                            ),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
