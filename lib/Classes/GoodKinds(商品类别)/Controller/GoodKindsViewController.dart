import 'package:flutter/material.dart';
import '../../../Common/Util/LogUtil.dart';
import 'package:flutter_app/Macros.dart';
import './LeftNaviViewController.dart';
import './RightGoodViewController.dart';

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
  }

  @override
  Widget build(BuildContext context) {
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
      width: 120,
      child:LeftNaviViewController(tabbarSafeBottomM:widget.tabbarSafeBottomM),
    );
  }

  Widget _makeRightView() {
    return Container(
      width: Macros.ScreenW(context) - 120,
      child: RightGoodViewController(tabbarSafeBottomM:widget.tabbarSafeBottomM,statusH:Macros.StatusH(context) ,),
    );
  }
  @override
  bool get wantKeepAlive => true;
}
