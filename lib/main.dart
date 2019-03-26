
import 'package:flutter/material.dart';
import './Classes/Start(登录)/CustomerTabBarPage.dart';
import './Classes/DesignReport(设计报告)/Controller/DesignReportViewController.dart';
import 'package:provide/provide.dart';
import './Provider(状态管理)/Counter.dart';
import './Provider(状态管理)/Bloc_provider.dart';

void main() {
//	debugPaintSizeEnabled = true;      //打开视觉调试开关
	var counter = Counter(0);
	final providers = Providers()
		..provide(Provider.function((context) => counter));
	
	runApp(ProviderNode(
		providers: providers,
		child: CustomerApp(),
	));
}

class CustomerApp extends StatelessWidget {
    // This widget is the root of your application.
    @override
    Widget build(BuildContext context) {
//		debugShowCheckedModeBanner: false, // 在调试期间，右上角的DEBUG字样
		return BlocProvider(
			child: MaterialApp(
			  title: 'Wifi伴侣',
			  debugShowCheckedModeBanner: false,  // 设置这一属性即可
			  home:
			  //DesignReportViewController()
			  CustomerTabBarPage.getInstance()
			)
		);
    }
}

//	loadData() async {
////		Dio dio = new Dio();
////		Response response = await dio.get("https://www.easy-mock.com/mock/5b4db02b461ecb1842d1dbe2/example/android");
////		print(response);
//
//		Dio dio = new Dio();
//		Response response=await dio.get("https://www.google.com/");
//		print(response.data);
//
////		Response response;
////		Dio dio=new Dio();
////		response=await dio.get("http://www.baidu.com");
////		print(response.data.toString());
//
////		setState(() {
////			print(json.decode(response.data));
////			widgets = json.decode(response.data)["data"];
////		});
//	}
//     body: new Container(
//					padding: new EdgeInsets.all(20.0),
//					child:new Column(
//					children:[new Row(
//			            mainAxisAlignment: MainAxisAlignment.start,
//			            children:[new Container(
//							padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
//				            height: 40.0,
//							child: new RaisedButton(
//								onPressed: () => print("被点击"),
//								child: const Text("I am Stone"),
//								color: Colors.black,//按钮的背景颜色
//								textColor: Colors.white,//文字的颜色
//								textTheme:ButtonTextTheme.normal ,//按钮的主题
//								onHighlightChanged: (bool b){//水波纹高亮变化回调
//								},
//								disabledTextColor: Colors.black54,//按钮禁用时候文字的颜色
//								disabledColor: Colors.black54,//按钮被禁用的时候显示的颜色
//								splashColor: Colors.white,//水波纹的颜色
//								colorBrightness: Brightness.light,//按钮主题高亮
//								elevation: 10.0,//按钮下面的阴影
//								highlightElevation: 10.0,//高亮时候的阴影
//								disabledElevation: 10.0,//按下的时候的阴影
//							),
//						),new Container(
//			                padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
//				            width: 120.0,
//				            color:Colors.green,
//				            child: new Text(
//					            'I am Stone 按钮禁用时候文字的颜',
//					            textDirection: TextDirection.ltr,
//					            softWrap: false, //是否自动换行 false文字不考虑容器大小  单行显示   超出；屏幕部分将默认截断处理
//							    overflow: TextOverflow.ellipsis, //文字超出屏幕之后的处理方式  TextOverflow.clip剪裁   TextOverflow.fade 渐隐  TextOverflow.ellipsis省略号
//							    maxLines: 10, //最大行数
//					            style: new TextStyle(
//									color: Colors.red,
//									fontWeight: FontWeight.w800,
//									fontFamily: 'Roboto',
//									letterSpacing: 0.5,
//									fontSize: 16.0,
//								),
//				            ),
//			            )]
//					),new Container(
//						margin: const EdgeInsets.fromLTRB(0.0, 120.0, 0.0, 0.0),
//						height: 40.0,
//						width: MediaQuery.of(context).size.width - 10.0,
//						child: new RaisedButton(
//							onPressed: () => print("被点击"),
//							child: const Text("I am Stone"),
//							color: Colors.black,//按钮的背景颜色
//							textColor: Colors.white,//文字的颜色
//							textTheme:ButtonTextTheme.normal ,//按钮的主题
//							onHighlightChanged: (bool b){//水波纹高亮变化回调
//							},
//							disabledTextColor: Colors.black54,//按钮禁用时候文字的颜色
//							disabledColor: Colors.black54,//按钮被禁用的时候显示的颜色
//							splashColor: Colors.white,//水波纹的颜色
//							colorBrightness: Brightness.light,//按钮主题高亮
//							elevation: 10.0,//按钮下面的阴影
//							highlightElevation: 10.0,//高亮时候的阴影
//							disabledElevation: 10.0,//按下的时候的阴影
//						),
//					)]
//				)
//			),

//             body:new Container(
//					padding: new EdgeInsets.all(20.0),
//					child: new Column(
//						children: [new Row(
//							mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//							children: [
//								new Column(
//									children: [
//										new Icon(Icons.kitchen, color: Colors.green[500]),
//										new Text('PREP:'),
//										new Text('25 min'),
//									],
//								),
//								new Column(
//									children: [
//										new Icon(Icons.timer, color: Colors.green[500]),
//										new Text('COOK:'),
//										new Text('1 hr'),
//									],
//								),
//								new Column(
//									children: [
//										new Icon(Icons.restaurant, color: Colors.green[500]),
//										new Text('FEEDS:'),
//										new Text('4-6'),
//									],
//								),
//							],
//						),new Row(
//						  crossAxisAlignment: CrossAxisAlignment.center,
//						  children: [
//							  new Expanded(
//								  child: new Image.asset('images/1.png'),
//							  ),
//							  new Expanded(              //使用Expanded控件对Image控件进行包裹
//								  flex: 2,               //flex值默认为1，这里改成2之后，其子控件2倍放大
//								  child: new Image.asset('images/2.png'),
//							  ),
//							  new Expanded(
//								  child: new Image.asset('images/3.png'),
//							  ),
//						  ]
//						),new Row(
////							padding: new EdgeInsets.all(20.0),
//							mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//							children: [
//								new Row(
//									mainAxisSize: MainAxisSize.min,       //mainAxisSize，可压缩或伸长行内控件的间距
//									children: [
//										new Icon(Icons.star, color: Colors.green[500]),
//										new Icon(Icons.star, color: Colors.green[500]),
//										new Icon(Icons.star, color: Colors.green[500]),
//										new Icon(Icons.star, color: Colors.green[500]),
//										new Icon(Icons.star, color: Colors.green[500]),
//									],
//								),
//								new Text(
//									'170 Reviews',
//									style: new TextStyle(
//										color: Colors.red,
//										fontWeight: FontWeight.w800,
//										fontFamily: 'Roboto',
//										letterSpacing: 0.5,
//										fontSize: 16.0,
//									),
//								),
//							],
//						),new Padding(
//							padding: const EdgeInsets.all(32.0),
//							child: new RaisedButton(
//								onPressed: () => print("被点击"),
//								child: const Text("I am Stone"),
//								color: Colors.black,//按钮的背景颜色
//								padding: EdgeInsets.all(10.0),//按钮距离里面内容的内边距
//								textColor: Colors.white,//文字的颜色
//								textTheme:ButtonTextTheme.normal ,//按钮的主题
//								onHighlightChanged: (bool b){//水波纹高亮变化回调
//								},
//								disabledTextColor: Colors.black54,//按钮禁用时候文字的颜色
//								disabledColor: Colors.black54,//按钮被禁用的时候显示的颜色
//								splashColor: Colors.white,//水波纹的颜色
//								colorBrightness: Brightness.light,//按钮主题高亮
//								elevation: 10.0,//按钮下面的阴影
//								highlightElevation: 10.0,//高亮时候的阴影
//								disabledElevation: 10.0,//按下的时候的阴影
//							),
//						)],
//					)
//				),
//          floatingActionButton: new FloatingActionButton(
//            onPressed: () => print("floatingActionButton"),
//            child: new Icon(Icons.add)),



//      new Image.asset(
//          'images/5.png',             //图片的路径
//          width: 600.0,               //图片控件的宽度
//          height: 240.0,              //图片控件的高度
//          fit: BoxFit.cover,          //告诉引用图片的控件，图像应尽可能小，但覆盖整个控件。
//          ),

//      ListView(children: _getListData()),

//    _getListData() {
//        List<Widget> widgets = [];
//        for (int i = 0; i < 100; i++) {
//            widgets.add(GestureDetector(
//                child: Padding(
//                    padding: EdgeInsets.all(50.0),
//                    child: Column(
//                        children:[
//                            Text("Row ====  $i"),
//                            Icon (Icons.star, color: Colors.green)
//                        ]
//                    )
//                ),
//                onTap: () {
//                    print('row tapped——i');
//                },
//            ));
//        }
//        return widgets;
//    }