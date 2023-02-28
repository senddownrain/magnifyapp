import 'package:magnifyapp/extensions/HexColor.dart';
import 'package:magnifyapp/model/note_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:html/parser.dart';

final currentItem = Provider<Note>((_) => throw UnimplementedError());

class NoteListScreen extends HookConsumerWidget {
  const NoteListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
        future: Hive.openBox<Note>('notes'),
        builder: (context, AsyncSnapshot<Box<Note>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ValueListenableBuilder<Box<Note>>(
                valueListenable: Hive.box<Note>('notes').listenable(),
                builder: (context, box, widget) {
                  var items = box.values.toList();
                  items.sort((a, b) => a.num! - b.num!);

                  return ListView.builder(
                    itemCount: box.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = items[index];
                      return ProviderScope(
                        overrides: [currentItem.overrideWithValue(item)],
                        child: Card(
                          margin: EdgeInsets.all(3),
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[const NoteTile()]),
                        ),
                      );
                    },
                  );
                });
          } else {
            return Center(child: Text('loading...'));
          }
        });
  }
}

class NoteTile extends HookConsumerWidget {
  const NoteTile({Key? key}) : super(key: key);

  String? _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final parsedString = parse(document.body?.text);
//f(parsedString != null){
    return parsedString!.documentElement?.text!;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(currentItem);
    return ListTile(
      key: ValueKey(item.id),
      title: Text(
        '${item.title}',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        _parseHtmlString(item.text!)!,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        softWrap: false,
      ),
      onTap: () {
        //displayItem.overrideWithValue(item.copyWith());
        // Navigator.push(context,
        //     MaterialPageRoute<Widget>(builder: (BuildContext context) {
        //   return Center(
        //     child: Text('ss'),
        //   );
        //}));
        //Navigator.of(context).pushNamed('/Note');
        Navigator.push(
            context,
            MaterialPageRoute<Widget>(
                builder: (context) => NoteScreen(item.copyWith())));
      },
    );
  }
}

class NoteScreen extends HookConsumerWidget {
  const NoteScreen(this.note, {Key? key}) : super(key: key);

  final Note? note;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Note day1 = ref.watch(displayItem).copyWith();
    // print(day1);
    return Scaffold(
      body: SingleChildScrollView(
        key: UniqueKey(),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                '${note!.title}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(
                height: 10,
              ),
              Html(data: note!.text!
                    .replaceAll(RegExp("<br>"), "")
                    .replaceAll(RegExp("<p>&nbsp;&nbsp;</p>"), ""),
                style: {
                  "p": Style(
                    margin: EdgeInsets.all(5),
                    //lineHeight: LineHeight(1)
                  )
                },),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text("Введение", style: TextStyle(fontFamily: 'Pacifico')),
        backgroundColor: HexColor("#C3AEF6"),
      ),
    );
  }
}
