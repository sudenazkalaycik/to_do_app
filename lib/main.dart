import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> tasks = []; // Görevleri ve durumları depolayacağımız liste
  final TextEditingController controller = TextEditingController(); // TextField kontrolcüsü

  void _showTaskOptions(int index) {
    final isCompleted = tasks[index]['completed'];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Görev Seçenekleri'),
          content: const Text('Bu görevle ilgili ne yapmak istersiniz?'),
          actions: <Widget>[
            if (isCompleted) ...[
              TextButton(
                onPressed: () {
                  setState(() {
                    tasks[index]['completed'] = false; // Görevi tamamlanmadı olarak işaretle
                  });
                  Navigator.of(context).pop(); // Diyalogdan çık
                },
                child: const Text('Tamamlanmadı'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    tasks.removeAt(index); // Görevi sil
                  });
                  Navigator.of(context).pop(); // Diyalogdan çık
                },
                child: const Text('Sil'),
              ),
            ] else ...[
              TextButton(
                onPressed: () {
                  setState(() {
                    tasks[index]['completed'] = true; // Görevi tamamla
                  });
                  Navigator.of(context).pop(); // Diyalogdan çık
                },
                child: const Text('Tamamla'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    tasks.removeAt(index); // Görevi sil
                  });
                  Navigator.of(context).pop(); // Diyalogdan çık
                },
                child: const Text('Sil'),
              ),
            ],
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          backgroundColor: Colors.teal,
          title: const Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.playlist_add_check_rounded,
                  color: Colors.white,
                  size: 90.0,
                ),
                SizedBox(width: 10.0),
                Text(
                  'To Do',
                  style: TextStyle(
                    fontSize: 70,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                color: Colors.teal,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${tasks.length} Task',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.7), fontSize: 25),
                  ),
                ),
                margin: const EdgeInsets.only(left: 35),
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(40.0),
                ),
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown.withOpacity(0.9),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        onPressed: () {
                          _showTaskOptions(index); // Görev seçeneklerini göster
                        },
                        child: Text(
                          task['text'], // Sadece görev metnini göster
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            decoration: task['completed']
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            decorationColor: Colors.white, // Çizgi rengini beyaz yapar
                            decorationThickness: 2.0, // Çizgi kalınlığını ayarlar
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.teal,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white54.withOpacity(0.5),
                  hintText: 'Görev eklemek için dokun',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(
                      color: Colors.brown,
                      width: 3.0,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                ),
                cursorColor: Colors.brown,
              ),
            ),
            const SizedBox(width: 10.0),
            SizedBox(
              width: 60.0,
              height: 60.0,
              child: FloatingActionButton(
                onPressed: () {
                  if (controller.text.isNotEmpty) {
                    setState(() {
                      tasks.add({'text': controller.text, 'completed': false}); // Yeni görevi ekle
                      controller.clear(); // TextField'ı temizle
                    });
                  }
                },
                child: const Icon(
                  Icons.add_task_outlined,
                  color: Colors.white,
                ),
                backgroundColor: Colors.brown.withOpacity(1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(56.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
