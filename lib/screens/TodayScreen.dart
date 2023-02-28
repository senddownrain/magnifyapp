// ignore_for_file: unnecessary_this

import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:magnifyapp/extensions/HexColor.dart';
import 'package:magnifyapp/model/Today.dart';
import 'package:magnifyapp/repositories/day_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final dbProvider = Provider<Database>((ref) => Database(ref));

class TodayScreen extends HookConsumerWidget {
  const TodayScreen({Key? key}) : super(key: key);
  
//final hookAnimation = useAnimationController(duration: Duration(milliseconds: 500), initialValue: 0);
     //final hookScroll = scrollController(hookAnimation);

  Widget _buildExp(BuildContext context, WidgetRef ref, Today day) {
    final data = [
      day!.magru,
      day!.magbel,
      day!.litsmir,
      day!.litdov,
    ];

    return 
                  ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
         physics: const NeverScrollableScrollPhysics(),
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) => ExpansionTile(
          textColor: HexColor("#C3AEF6"),
              title: Text(data[index]!.title!),
              children: [
                Html(data: data[index]!.text!, style: {
                  "p": Style(
                    margin: EdgeInsets.all(5),
                    //lineHeight: LineHeight(1)
                  )
                })
              ],
            ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var repo = ref.watch(dbProvider).getToday();
    // print(day1);

    return FutureBuilder<Today>(
        future: repo, // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<Today> snapshot) {
          if (snapshot.hasData) {
            var day = snapshot.data;

            return Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  key: UniqueKey(),
                  child: Padding(
                    padding: const EdgeInsets.all(1),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),

                        Text(
                          'День ${day!.today.day}',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            day!.today.title!,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),

                        const SizedBox(
                          height: 5,
                        ),
                        //Text(day!.today.comment!),

                        Html(
                          data: day!.today.comment!
                              .replaceAll(RegExp("<br>"), ""),
                          style: {
                            "p": Style(
                              margin: EdgeInsets.all(5),
                              //lineHeight: LineHeight(1)
                            )
                          },
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Подумай',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        Html(data: day!.today.questions),
                        const SizedBox(
                          height: 5,
                        ),
                        
                        Text(
                          'Молитва',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        _buildExp(context, ref, day),
                        const SizedBox(
                          height: 5,
                        ),
                         Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5 ),
                          child:
                        Text(
                          'Молись о Духе утешения и радости. Молись, чтобы твоё участие в Magnify было благословенным и укреплено сестринством. Молись за себя и своих сестёр.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),),
                         const SizedBox(
                          height: 5,
                        ),
                         Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5 ),
                          child:
                        Text(
                          'Найди время для Адорации. Даже если это несколько минут среди забот о семье, даже если это поздний час, даже если это раз в месяц... Пожалуйста, постарайся сделать всё возможное, чтобы быть в присутствии Иисуса перед Святыми Дарами. Тебе не нужно делать или говорить что-либо (хоть ты, конечно, можешь!), просто скажи Ему, как сильно ты любишь Его, как ты благодарна за Его жертву, как ты хочешь стать ближе к Его Святому Сердцу и Его матери Марии. Молись за других. Молись за священников. Молись об исцелении и единстве. Молись о духовном росте. Молись, чтобы твоя слабость открылась тебе. Проси о добродетели. Попроси силы. Проси верности и смелости. Проси ясный взгляд сердца, чтобы видеть и отважно любить. После выдохни и слушай..',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),),
                         const SizedBox(
                          height: 10,
                        ),
                        // Text(
                        //   '${day!.verse}',
                        //   style: Theme.of(context).textTheme.subtitle1,
                        // ),
                        // Html(data: day!.bible),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        // Text(
                        //   'РАЗВАЖАННІ',
                        //   style: Theme.of(context).textTheme.subtitle1,
                        // ),
                        // Html(data: day!.comment),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: Text('loading...'));
          }
        });
  }
}

// class ExpItemListNotifier extends StateNotifier<List<ExpItem>>{
//    ExpItemListNotifier(super.state);
//   void expend(int index, bool isExpanded){
//     state[index].isExpanded = !isExpanded;
//   }
//   void load(List<ExpItem> items){
//     state.addAll(items);    
//   }
// } 

// final enp = StateNotifierProvider<ExpItemListNotifier, List<ExpItem>>(((ref) => ExpItemListNotifier([])));
 
// class ExpListNotifierChange extends ChangeNotifier{
//   List<ExpItem> items = const [];
//    void expend(int index, bool isExpanded){
//     items[index].isExpanded = !isExpanded;
//     notifyListeners();
//   }
//   void load(List<ExpItem> items){
//     items.addAll(items);    
//     notifyListeners();
//   }
// }

// final echp = ChangeNotifierProvider(((ref) => ExpListNotifierChange()));



class HookScroller extends Hook<ScrollController> {
  AnimationController controller;
  HookScroller(this.controller);
  @override
  _HookScrollerState createState() => _HookScrollerState();
}

class _HookScrollerState extends HookState<ScrollController,HookScroller> {
  ScrollController scroller = new ScrollController();

  void scrollAnimation(AnimationController controler, ScrollController scrollController) {
    if(scrollController.position.userScrollDirection == ScrollDirection.forward) {
      controler.forward();
    }
    else if(scrollController.position.userScrollDirection == ScrollDirection.reverse){
      controler.reverse();
    }
    else {
      print("not scrolling rn");
    }
  }

  @override
  void initHook() {
    // TODO: implement initHook
    super.initHook();
    scroller = ScrollController()..addListener((){
      scrollAnimation(hook.controller, scroller);
    });
  }

  @override
  ScrollController build(BuildContext context) {
    return scroller;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scroller.dispose();
  }
}

ScrollController scrollController(AnimationController controller) {
  return Hook.use(HookScroller(controller));
}