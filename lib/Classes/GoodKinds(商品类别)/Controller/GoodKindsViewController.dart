import 'package:flutter/material.dart';
import '../../../Common/Util/LogUtil.dart';
import 'package:flutter_app/Macros.dart';
import './LeftNaviViewController.dart';
import './RightGoodViewController.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

//class GoodKindsViewController extends StatefulWidget {
//  double tabbarSafeBottomM;
//  //构造函数
//  GoodKindsViewController({Key key, this.tabbarSafeBottomM}) : super(key: key);
//  @override
//  _GoodKindsViewControllerState createState() =>
//      _GoodKindsViewControllerState();
//}
//
//class _GoodKindsViewControllerState extends State<GoodKindsViewController> with AutomaticKeepAliveClientMixin{
//  @override
//  void initState() {
//    super.initState();
//  }
//
//  @override
//  void dispose() {
//    print('移除时：dispose');
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: new AppBar(
//          title: new Container(
//        child: new Row(
//          children: <Widget>[
//            new Expanded(
//                child: new Center(
//              child: new Text("设计报告"),
//            ))
//          ],
//        ),
//      )),
//      body: Container(), //getBody(),
//    );
//  }
//  @override
//  bool get wantKeepAlive => true;
//}

class GoodKindsViewController extends StatefulWidget {
  double tabbarSafeBottomM;
  //构造函数
  GoodKindsViewController({Key key, this.tabbarSafeBottomM}) : super(key: key);
  @override
  _GoodKindsViewControllerState createState() =>
      _GoodKindsViewControllerState();
}

class _GoodKindsViewControllerState extends State<GoodKindsViewController>
    with AutomaticKeepAliveClientMixin {
  final log = Logger('_GoodKindsViewController');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    if (!mounted) return Container();
    return Scaffold(
      appBar: new AppBar(
          title: new Container(
        child: new Row(
          children: <Widget>[
            new Expanded(
                child: new Center(
              child: new Text("商品分类"),
            ))
          ],
        ),
      )),
      body: new Container(
        height: Macros.ScreenH(context) -
          Macros.NaviH -
          Macros.StatusH(context) -
          widget.tabbarSafeBottomM -
          kBottomNavigationBarHeight,
        child: Row(
          children: <Widget>[_makeLeftView(), _makeRightView()],
        ),
      ),
    );
  }

  Widget _makeLeftView() {
    return Container(
      width: ScreenUtil().setWidth(180),
      child:LeftNaviViewController(tabbarSafeBottomM:widget.tabbarSafeBottomM),
    );
  }

  Widget _makeRightView() {
    return Container(
      width: Macros.ScreenW(context) - ScreenUtil().setWidth(180),
      child: RightGoodViewController(tabbarSafeBottomM:widget.tabbarSafeBottomM,statusH:Macros.StatusH(context) ,),
    );
  }
  @override
  bool get wantKeepAlive => true;
}
