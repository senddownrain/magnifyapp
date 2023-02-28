

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:magnifyapp/extensions/HexColor.dart';
import 'package:magnifyapp/firebase_options.dart';
import 'package:magnifyapp/model/day_model.dart';
import 'package:magnifyapp/model/note_model.dart';
import 'package:magnifyapp/repositories/day_repository.dart';
import 'package:magnifyapp/screens/DaysScreen.dart';
import 'package:magnifyapp/screens/NotesScreen.dart';
import 'package:magnifyapp/screens/TodayScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  Hive.registerAdapter(DayAdapter());
  Hive.registerAdapter(NoteAdapter());

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magnify 40',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        textTheme: TextTheme(
          bodyText2: TextStyle(fontSize: 15, height: 1.3),
          subtitle1: TextStyle(fontSize: 20, fontWeight: FontWeight.w600,),
        )
        
      ),
      home: HomeScreen(),
    );
  }
}

final dbProvider = Provider<Database>((ref) => Database(ref));

class HomeScreen extends HookConsumerWidget {
  final _pages = [
    new NoteListScreen(),
    new TodayScreen(),
    new DayListScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navIndex = useState(1);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(3),
        child: _pages[navIndex.value],
      ),
      appBar: AppBar(
        title: const Text("Magnify 40", style: TextStyle(fontFamily: 'Pacifico'),),
        backgroundColor: HexColor("#C3AEF6"), // #C3AEF6
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.update_outlined),
            tooltip: 'Show Snackbar',
            onPressed: () {
              var rep = ref.watch(dbProvider);
              rep.updateAllCache();

              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Database was updated!')));
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navIndex.value,
        onTap: (index) => navIndex.value = index,
        backgroundColor: Colors.white,
        selectedItemColor: HexColor("#C3AEF6"),
        unselectedItemColor: HexColor("#E0D5FB"),
        selectedFontSize: 15,
        items: const [
          BottomNavigationBarItem(
            label: "Введение",
            icon: Icon(Icons.note),
          ),
          BottomNavigationBarItem(
            label: "Сегодня",
            icon: Icon(Icons.calendar_today),
          ),
          BottomNavigationBarItem(
            label: "Дни",
            icon: Icon(Icons.list),
          ),
        ],
      ),
    );
  }
}

