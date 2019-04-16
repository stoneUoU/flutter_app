import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dio/dio.dart';
import '../../../Common/Util/LogUtil.dart';

class FutureViewController extends StatefulWidget {
  double tabbarSafeBottomM;

  //构造函数
  FutureViewController({Key key, this.tabbarSafeBottomM}) : super(key: key);

  @override
  _FutureViewControllerState createState() => _FutureViewControllerState();
}

class _FutureViewControllerState extends State<FutureViewController> {
  final log = Logger('_FutureViewController');

  String dataStr;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setData();
  }

  @override
  Widget build(BuildContext context) {
    
    return Container(
      child: Center(
        child: Text(
          "Future 同异步学习",
          style: new TextStyle(
            fontSize: ScreenUtil().setSp(60),
            color: Colors.red,
            decorationColor: Colors.black26, //线的颜色
            decoration: TextDecoration
                .lineThrough, //none无文字装饰   lineThrough删除线   overline文字上面显示线    underline文字下面显示线
            decorationStyle: TextDecorationStyle.solid,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  _testFuture() async {
    Dio dio = new Dio();
    Response response = await dio.get("https://www.easy-mock.com/mock/5b4db02b461ecb1842d1dbe2/example/type/list");
    log.fine("==========    ${response.data}");
    return response.data;
  }

  //HTTP的get请求返回值为Future<String>类型，即其返回值未来是一个String类型的值
  _getData() async {
    //async关键字声明该函数内部有代码需要延迟执行
    Dio dio = new Dio();
    Response response = await dio.get(
        "https://www.easy-mock.com/mock/5b4db02b461ecb1842d1dbe2/example/android");
//    log.fine("++++++++++++    ${response.data}");
    return response.data;
  }

  _setData() async {
//	  _getData(); //getData()延迟执行后赋值给data
    dataStr = await _getData(); //getData()延迟执行后赋值给data
    log.fine("++++++++++++    ${dataStr}");
  }
}
