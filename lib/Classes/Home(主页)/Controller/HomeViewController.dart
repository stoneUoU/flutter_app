
import 'package:flutter/material.dart';
import 'package:flutter_app/Classes/Mine(我的)/Controller/MineViewController.dart';
import 'package:flutter_app/Common/STStyle.dart';
import 'package:flutter_app/Common/PlaceHolderView.dart';
import 'package:flutter_app/Macros.dart';
import 'package:flutter_app/Util/NetCheckTools.dart';
import 'package:provide/provide.dart';
import 'package:flutter_app/Provider(状态管理)/Counter.dart';
import 'package:flutter_app/Provider(状态管理)/CountBLoC.dart';
import 'package:flutter_app/Provider(状态管理)/Bloc_provider.dart';
//import 'package:flutter_app/Util/HttpUtil.dart';
//import '../Model/ThemeMs.dart';

class HomeViewController extends StatefulWidget {
	HomeViewController({Key key}) : super(key: key);
	@override
	_HomeViewController createState() => _HomeViewController();
}

class _HomeViewController extends State<HomeViewController>
	with AutomaticKeepAliveClientMixin {
		
		bool flag = true;
		
		@override
		bool get wantKeepAlive => true;
		
		@override
		void initState() {
			super.initState();
//			_getThemeData();
		}
		
		@override
		Widget build(BuildContext context) {
			print("============${MediaQuery.of(context).padding.bottom}");
			super.build(context);//必须添加
			return Scaffold(
			    appBar: _appBar(),
			    body: _getBody()
			);
		}
		
		AppBar _appBar() {
			return new AppBar(
			  title: new Container(
				  child: new Row(
					  children: <Widget>[
						  new FlatButton.icon(
							  onPressed: (){
							  },
							  icon: new Icon(Icons.clear, color: Colors.white70),
							  label: new Text(""),
						  ),
						  new Expanded(
							child: new Center(
								child: new Text("YMY"),
							)
						  ),
						  new FlatButton(
							onPressed: (){
								Navigator.of(context).push(new MaterialPageRoute(
								  builder: (context) {
									  return new MineViewController(
										  numberFlag: 1,
									  );
								  }
								));
							},
							child: new Text("下一步", style: new TextStyle(color: Colors.white))
						  )
					  ],
				  ),
			  )
			);
		}
		
		_sendNet() {
			NetworkCheck networkCheck = new NetworkCheck();
			networkCheck.checkInternet((netUseful){
				setState(() {
					if (!netUseful) {
						flag = false;
						print("网络不可用");
					} else {
						flag = true;
						print("网络可用");
					}
				});
			});
		}
		
		_getBody() {
			if (!flag) {
				return new PlaceHolderView(
		            viewType: PlaceholderViewType.noGoods,
		            onPlaceHolderViewClickListener: (viewType) {
					if (viewType == PlaceholderViewType.noNetwork) {
						print("images/noNet.png");
					} else if (viewType == PlaceholderViewType.noGoods) {
						print("images/noShopCart.png");
					} else {
						print("images/noShopCart.png");
					}
				});
			} else {
				return new Container(
					child: new Column(
						children: <Widget>[
							StreamBuilder<int>(
							    stream: BlocProvider.of(context).stream,
							    initialData: BlocProvider.of(context).value,
							    builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
								    return ShowText(intShow: snapshot.data);
							    },
							),
							StreamBuilder<int>(
							    initialData: bLoC.value,
								stream: bLoC.stream,
							    builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
								  return ShowText(intShow: snapshot.data);
							    },
							),
							//方式-：
							StreamBuilder<Counter>(
								initialData: Provide.value<Counter>(context),
								stream: Provide.stream<Counter>(context).where((counter) => counter.value % 2 == 0),
								builder: (BuildContext context, AsyncSnapshot<Counter> snapshot) {
									return ShowText(intShow: snapshot.data.value);
								},
							),
							//方式二：
							Provide<Counter>(
								builder: (context, child, counter) => ShowText(intShow: counter.value)
							),
							ClickButton()
						],
					)
				);
			}
		}
		
//		{
//		    "activityID":"12",
//		    "userId":"vDdNA2oYY1F6qQ/+byMrZwO66A6+EJmNNvg2xNXuozdLkhmpWQaDRr6GfngmAbBS4Z9pDDGOsqOxQ9GF97qfVSbA3EzIAKaquCqCPijcLA2sU9T8RW5kC9TDKupgkqEkwtMCEk5YrXT7/TDwR6LZjafK57iYM4gbU3oyrtI94+k=",
//		    "page":1
//		}

//		经测试，model这样使用最好了：
//		Future<Null> _getThemeData() async {
//			String url = "/2.0.0/AT/GetAllReference";
//			var data = {"activityID":"12","page":1,"userId":"vDdNA2oYY1F6qQ/+byMrZwO66A6+EJmNNvg2xNXuozdLkhmpWQaDRr6GfngmAbBS4Z9pDDGOsqOxQ9GF97qfVSbA3EzIAKaquCqCPijcLA2sU9T8RW5kC9TDKupgkqEkwtMCEk5YrXT7/TDwR6LZjafK57iYM4gbU3oyrtI94+k="};
//			var response = await HttpUtil().post(url, data: data);
//			if (response["flag"] == 1) {
//				if (response["rs"] != null) {
//					ThemeMs cellData = new ThemeMs.fromJson(response["rs"]);
//					List<DList> dlist = cellData.dList;
//					List<ImgInfos> imgInfos = dlist[0].imgInfos;
//					print(dlist[0].imgInfos);
//					print(imgInfos[0].imgUrl);
//				}
//			}
//		}
	}


class ShowText extends StatefulWidget {
	
	int intShow = 0;
	
	ShowText({Key key,this.intShow}) : super(key: key);
	
	@override
	
	_ShowText createState() => _ShowText();
	
}

class _ShowText extends State<ShowText> {
	
	@override
	void initState() {
		super.initState();
	}
	
	@override
	Widget build(BuildContext context) {
		return new Container(
		    margin:EdgeInsets.fromLTRB(0, 30.0, 0,0),
		    child:new Center(
			    child: new Text("${widget.intShow}",
			      style: new TextStyle(fontSize: 30.0, color: Colors.red),
			      textAlign: TextAlign.center
			    ),
		    ),
		);
	}
}


class ClickButton extends StatelessWidget {
	
	const ClickButton({Key key})
	  : super(key: key);
	
	@override
	Widget build(BuildContext context) {
//		final currentCounter = Provide.value<Counter>(context);
		return new Container(
		  margin:EdgeInsets.fromLTRB(0, 58.0, 0,0),
		  height:45,
		  width: Macros.ScreenW(context) - 30,
		  child:new RaisedButton(
			  onPressed: (){
			  	  // Bloc 方式的状态管理
				  BlocProvider.of(context).increment();
				  bLoC.increment();
				  Provide.value<Counter>(context).increment();
			  },
			  shape: StadiumBorder(),
			  child: new Text("点击改变状态",style: TextStyle(fontSize: 16.0,color: Colors.white)),
			  color:Color(STColors.colorC09),
		  )
		);
	}
}

//provide 的步骤书写：

//import 'package:flutter/material.dart';
//
//class Counter with ChangeNotifier {
//	int _value;
//
//	int get value => _value;
//
//	Counter(this._value);
//
//	void increment() {
//		_value++;
//		notifyListeners();
//	}
//}


//import 'package:provide/provide.dart';
//import 'package:flutter_app/Provider(状态管理)/Counter.dart';
//在改变状态的组件中:final currentCounter = Provide.value<Counter>(context);
//在点击函数里调用其方法： currentCounter.increment();


//在接收状态改变的组件中:
//Provide<Counter>(
//builder: (context, child, counter) => Text("${counter.value}"),
//),


//在main()函数中:
//void main() {
////	debugPaintSizeEnabled = true;      //打开视觉调试开关
//
//	final providers = Providers()
//		..provide(Provider.function((context) => Counter(0)));
//
//	runApp(ProviderNode(
//		providers: providers,
//		child: CustomerApp(),
//	));
//}


//Bloc 的步骤书写： (方式一)

//import 'dart:async';
//
//class CountBLoC {
//	int _count = 0;
//	var _countController = StreamController<int>.broadcast();
//
//	Stream<int> get stream => _countController.stream;
//	int get value => _count;
//
//	increment() {
//		_countController.sink.add(++_count);
//	}
//
//	dispose() {
//		_countController.close();
//	}
//}
//CountBLoC bLoC = CountBLoC();

//StreamBuilder<int>(
//	initialData: bLoC.value,
//	stream: bLoC.stream,
//	builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
//		return ShowText(intShow: snapshot.data);
//	},
//),

//bLoC.increment();


//Bloc 的步骤书写： (方式二)

//import 'dart:async';
//
//class CountBLoC {
//	int _count = 0;
//	var _countController = StreamController<int>.broadcast();
//
//	Stream<int> get stream => _countController.stream;
//	int get value => _count;
//
//	increment() {
//		_countController.sink.add(++_count);
//	}
//
//	dispose() {
//		_countController.close();
//	}
//}

//import 'package:flutter/material.dart';
//import './CountBLoC.dart';
//
//class BlocProvider extends InheritedWidget {
//
//	CountBLoC bLoCTest = CountBLoC();
//
//	BlocProvider({Key key, Widget child}) : super(key: key, child: child);
//
//	@override
//	bool updateShouldNotify(_) => true;
//
//	static CountBLoC of(BuildContext context) =>
//	  (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider).bLoCTest;
//}

//StreamBuilder<int>(
//	stream: BlocProvider.of(context).stream,
//	initialData: BlocProvider.of(context).value,
//	builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
//		return ShowText(intShow: snapshot.data);
//	},
//),

//BlocProvider.of(context).increment();

//class CustomerApp extends StatelessWidget {
//	// This widget is the root of your application.
//	@override
//	Widget build(BuildContext context) {
////		debugShowCheckedModeBanner: false, // 在调试期间，右上角的DEBUG字样
//		return BlocProvider(
//		  child: MaterialApp(
//			title: 'Wifi伴侣',
//			debugShowCheckedModeBanner: false,  // 设置这一属性即可
//			home: CustomerTabBarPage.getInstance()
//		  )
//		);
//	}
//}


