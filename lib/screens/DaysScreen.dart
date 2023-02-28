import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:html/parser.dart';
import 'package:magnifyapp/extensions/HexColor.dart';
import 'package:magnifyapp/model/day_model.dart';

final currentItem = Provider<Day>((_) => throw UnimplementedError());

class DayListScreen extends HookConsumerWidget {
  const DayListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
        future: Hive.openBox<Day>('days'),
        builder: (context, AsyncSnapshot<Box<Day>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ValueListenableBuilder<Box<Day>>(
                valueListenable: Hive.box<Day>('days').listenable(),
                builder: (context, box, widget) {
                  var items = box.values.toList();
                  items.sort(
                    (a, b) => a.day!.compareTo(b.day!),
                  );
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
                              children: <Widget>[const DayTile()]),
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

class DayTile extends HookConsumerWidget {
  const DayTile({Key? key}) : super(key: key);

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
        'День ${item.day}',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        _parseHtmlString(item.comment ?? item.comment!)!,
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
        //Navigator.of(context).pushNamed('/day');
        Navigator.push(
            context,
            MaterialPageRoute<Widget>(
                builder: (context) => DayScreen(item.copyWith())));
      },
    );
  }
}

class DayScreen extends HookConsumerWidget {
  const DayScreen(this.day, {Key? key}) : super(key: key);

  final Day? day;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Day day1 = ref.watch(displayItem).copyWith();
    // print(day1);
    return Scaffold(
      body: SingleChildScrollView(
        key: UniqueKey(),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                'Дзень ${day!.day}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '${day!.title}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Html(
                data: day!.comment!
                    .replaceAll(RegExp("<br>"), "")
                    .replaceAll(RegExp("<p>&nbsp;&nbsp;</p>"), ""),
                style: {
                  "p": Style(
                    margin: EdgeInsets.all(5),
                    //lineHeight: LineHeight(1)
                  )
                },
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Подумай',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '${day!.questions}',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text('День ${day!.day}', style: TextStyle(fontFamily: 'Pacifico'),),
        backgroundColor: HexColor("#C3AEF6"),
      ),
    );
  }
}
