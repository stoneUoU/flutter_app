import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Common/Util/LogUtil.dart';
import '../../../Common/Util/BXLifeTools.dart';

class GoodDetailViewController extends StatefulWidget {
  String goodId;

  GoodDetailViewController({Key key, this.goodId}) : super(key: key);
  @override
  _GoodDetailViewControllerState createState() =>
      _GoodDetailViewControllerState();
}

class _GoodDetailViewControllerState extends State<GoodDetailViewController> {
	
	final log = Logger('_GoodDetailViewController');
	
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getGoodDetail();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
              child: new Text("商品详情"),
            ))
          ],
        ),
      )),
      body: Container(
	      color: Colors.white,
	      child: Center(
		      child: Text(
			      "${widget.goodId}",
			      style: new TextStyle(
				      fontSize: ScreenUtil().setSp(28),
				      color: Colors.red,
			      ),
			      textAlign: TextAlign.center,
			      maxLines: 1,
			      overflow: TextOverflow.ellipsis,
		      ),
	      ),
      ),
    );
  }

  Future getGoodDetail() async {
	  String url = "wxmini/getGoodDetailById";
	  var data = {'goodId':widget.goodId};
	  var feedBack = await BXLifeTools().post(url, data: data);
	  log.fine("________${json.decode(feedBack)}");
  }
}
