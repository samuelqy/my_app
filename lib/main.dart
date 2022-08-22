
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    home: FirstRoute(),
  ));
}



class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var buttonSize = Size(width*0.5, 100);
    const textStyle = TextStyle(fontSize: 50.0, color: Colors.black);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('您的手机号: 1234567890',style: TextStyle(fontSize: 25.0, color: Colors.black) ),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              OutlinedButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(buttonSize),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>  const SecondRoute()));
                  },
                  child: const Text('买菜', style: textStyle),
              ),
              const SizedBox(height: 50),
              OutlinedButton(
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(buttonSize),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)))),
                onPressed: () => {},
                child: const Text('出行', style: textStyle),
              ),
            ],
        )
      ),
    );
  }

}

///////////////////////////////////////////////////////
////////////           搜索框         //////////////////
class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchState();
}

class _SearchState extends State<SearchWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: TextFormField(
        textAlign: TextAlign.center,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 5.0),
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 5.0),
            ),
            hintText: '搜索',
        ),
          )
    );
  }
}

///////////////////////////////////////////////////////
////////////           购物车         //////////////////

class ShoppingCart extends StatefulWidget {

  const ShoppingCart({required Key key}) : super(key: key);

  @override
  State<ShoppingCart> createState() => ShoppingCartState();
}

class ShoppingCartState extends State<ShoppingCart> {
  int _counter = 0;

  void _increment() {
    setState(() {
      _counter++;
    });
  }
    void _decrement() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var buttonSize = Size(width*0.2, 80);
    const textStyle = TextStyle(fontSize: 30.0, color: Colors.black);
    return Badge(
      badgeContent: Text('$_counter'),
      child: OutlinedButton(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(buttonSize),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
        ),
        onPressed: () => {},
        child: Wrap(crossAxisAlignment: WrapCrossAlignment.center,
          children: const [
            Text('已选中商品', style: textStyle),
            Icon(Icons.shopping_cart_outlined , color: Colors.black,  size: 35.0,)
          ]
        )
      )
    );
  }
}



///////////////////////////////////////////////////////
////////////           物品         //////////////////

class Item extends StatefulWidget {
  final String name;
  final GlobalKey<ShoppingCartState> cartKey;

  const Item({required this.name, required this.cartKey, super.key});

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> with AutomaticKeepAliveClientMixin {
  bool _selected = false;

  void _select() {
    setState(() {
      if(_selected){
         widget.cartKey.currentState?._decrement();
      } else{
         widget.cartKey.currentState?._increment();
      }
      _selected = !_selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: _selected
        ? ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
          side: MaterialStateProperty.all(const BorderSide(color: Colors.red, width: 5))
        )
        :ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
        ),
        onPressed: _select,
        child: Text(widget.name, style: const TextStyle(fontSize: 20.0, color: Colors.black))
    );
  }

  @override
  bool get wantKeepAlive => true;
}

///////////////////////////////////////////////////////
////////////           翻页         //////////////////

class MyPagination extends StatefulWidget {
  final CarouselController controller;

  const MyPagination({required this.controller, super.key});

  @override
  State<MyPagination> createState() => _MyPaginationState();
}

class _MyPaginationState extends State<MyPagination> {
  int _index = 1;

  void _increment() {
    setState(() {

      // hard coded, limit of pages
      if(_index<3){
        _index++;
      widget.controller.animateToPage(_index-1);
      }

    });
  }
  void _decrement() {
    setState(() {
      if(_index>1){
        _index--;
        widget.controller.animateToPage(_index-1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const size = 70.0;
    return Row( mainAxisAlignment: MainAxisAlignment.center,
               children: [
                    IconButton(
                      iconSize: size,
                     icon: const Icon(Icons.arrow_back_ios_new_outlined, size: size),
                     onPressed: _decrement
                 ),

                 const SizedBox(width: 20),
                 Column( mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                    Text('$_index', style: const TextStyle(fontSize: 30.0)),
                    const Text("点击翻页"),
                   ],
                 ),
                 const SizedBox(width: 20),
                 IconButton(
                   iconSize: size,
                     icon: const Icon(Icons.arrow_forward_ios_outlined, size: size),
                     onPressed: _increment
                 ),
                 ]
    );
  }
}


///////////////////////////////////////////////////////
////////////           录音         //////////////////
enum Status {
  none,
  recording,
  deciding
}

enum Action{
  publish,
  cancel,
  redo
}

class Record extends StatefulWidget {
  const Record({super.key});
  @override
  State<Record> createState() => _RecordState();
}

class _RecordState extends State<Record> {
  Status status = Status.none;

  void _reset() {
    setState(() {
      status = Status.none;
    });
  }
  void _record() {
    setState(() {
      status = Status.recording;
    });
  }

  void _decide() {
    setState(() {
      status = Status.deciding;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var buttonSize1 = Size(width*0.25, 80);
    const textStyle = TextStyle(fontSize: 30.0, color: Colors.black);
    switch(status){
      case Status.none:
        {
          return OutlinedButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(buttonSize1),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
                  ),
                  onPressed: _record,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                       SizedBox(width: 20),
                      Icon(Icons.mic, color: Colors.black, size: 40),
                       SizedBox(width: 30),
                       Text('点击开始录制需要的帮助', style: textStyle),
                    ],
                  )
              );
        }
      case Status.recording:{
        return  OutlinedButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(buttonSize1),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
                  ),
                  onPressed: _decide,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                       SizedBox(width: 20),
                        SizedBox(
                          width: 42.0,
                          height: 42.0,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.red
                            ),
                          ),
                        ),
                       SizedBox(width: 30),
                       Text('停止录制', style: textStyle),
                    ],
                  )
              );
      }
      case Status.deciding:{
        return  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                       OutlinedButton(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(buttonSize1),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
                        ),
                        onPressed:  () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text(''),
          content: const Text('发布成功，稍后有人工客服联系你', style: textStyle,),
          actions: <Widget>[
            OutlinedButton(
              style: ButtonStyle(minimumSize: MaterialStateProperty.all(buttonSize1)),
              onPressed: () {
                Navigator.pop(context);
                _reset();
                },
              child: const Text('好的', style: textStyle),
            ),
          ],
        ),
      ),
                        child: const Text('发布', style: textStyle),
                      ),
                      const SizedBox(width: 30),
                      OutlinedButton(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(buttonSize1),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
                        ),
                        onPressed: _reset,
                        child: const Text('取消', style: textStyle),
                      ),
                      const SizedBox(width: 30),
                      OutlinedButton(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(buttonSize1),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
                        ),
                        onPressed: _record,
                        child: const Text('重新录制', style: textStyle),
                      ),
                    ],
                  );
      }
    }

  }
}


///////////////////////////////////////////////////////
class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var buttonSize1 = Size(width*0.2, 80);
    const textStyle = TextStyle(fontSize: 30.0, color: Colors.black);
    CarouselController buttonCarouselController = CarouselController();
  GlobalKey<ShoppingCartState> cartKey = GlobalKey();
  return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SearchWidget(),
          const SizedBox(height: 20),
          Row( mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 const SizedBox(width: 40),
                ShoppingCart(key: cartKey),
                 const SizedBox(width: 20),
                 OutlinedButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(buttonSize1),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
                  ),
                  onPressed: () => {},
                  child: const Text('发布任务', style: textStyle),
              )
              ],
          ),
          // Item(name: '葱', cartKey: cartKey),
          // Item(name: '姜', cartKey: cartKey),
          // Item(name: '蒜', cartKey: cartKey),
          // Item(name: '五花肉', cartKey: cartKey),
          CarouselSlider(
            items: [
              GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 50,
                padding: const EdgeInsets.all(20),
                children: ["葱", "姜", "蒜", "猪肉","牛肉","鸡肉","奶茶","咖啡","鸳鸯","西瓜","葡萄","苹果",].map(
                        (food) => Item(name: food, cartKey: cartKey)
                ).toList()
              ),
              GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 50,
                padding: const EdgeInsets.all(20),
                children: List.generate(12, (index) {
                  return Item(name: index.toString(), cartKey: cartKey);
                }),
              ),
              GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 50,
                padding: const EdgeInsets.all(20),
                children: List.generate(12, (index) {
                  return Item(name: index.toString(), cartKey: cartKey);
                }),
              )
            ],
            carouselController: buttonCarouselController,
            options: CarouselOptions(
                enlargeCenterPage: true,
                viewportFraction: 0.9,
                enableInfiniteScroll: false,
                height: 500,
                scrollPhysics: const NeverScrollableScrollPhysics()
              ),
            ),

          MyPagination(controller: buttonCarouselController),
          const Record(),
        ],
      )
    );



  }
}