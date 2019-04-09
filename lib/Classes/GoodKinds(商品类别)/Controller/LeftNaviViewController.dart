import 'package:flutter/material.dart';
import 'dart:convert';
import '../../../Common/Util/BXLifeTools.dart';
import '../../../Common/Util/LogUtil.dart';
import '../Model/KindMs.dart';
import 'package:flutter_app/Macros.dart';
import '../View/LeftNaviFontCell.dart';

import 'package:provide/provide.dart';
import '../../../Provider(状态管理)/LeftNaviProvider.dart';

class LeftNaviViewController extends StatefulWidget {
  double tabbarSafeBottomM;
  //构造函数
  LeftNaviViewController({Key key, this.tabbarSafeBottomM}) : super(key: key);
  @override
  _LeftNaviViewControllerState createState() => _LeftNaviViewControllerState();
}

class _LeftNaviViewControllerState extends State<LeftNaviViewController> {
  final log = Logger('_LeftNaviViewController');
  List<int> clickFlag = [];
  KindMs kindMs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getKindMs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
        child: _makeLeftNavi(),
      ),
    );
  }

  Widget _makeLeftNavi() {
    return Container(
        child: Row(
      children: <Widget>[
        Container(
          width: 119,
          height: Macros.ScreenH(context) -
              Macros.NaviH -
              Macros.StatusH(context) -
              widget.tabbarSafeBottomM -
              kBottomNavigationBarHeight,
          child: _getContent(),
        ),
        Container(
            width: 1,
            height: Macros.ScreenH(context) -
                Macros.NaviH -
                Macros.StatusH(context) -
                widget.tabbarSafeBottomM -
                kBottomNavigationBarHeight,
            color: Colors.black12),
      ],
    ));
  }

  Widget _getContent() {
    if (kindMs == null) {
      return Container();
    } else {
      return _getLeftListView();
    }
  }

  ListView _getLeftListView() => ListView.builder(
        itemCount: kindMs.data.length,
        itemBuilder: (BuildContext context, int position) {
          return getLeftListRow(position);
        },
      );

  Widget getLeftListRow(int i) {
    KindData kindData = kindMs.data[i];
    return StreamBuilder<LeftNaviProvider>(
	    initialData: Provide.value<LeftNaviProvider>(context),
	    stream: Provide.stream<LeftNaviProvider>(context),
	    builder: (BuildContext context,
	      AsyncSnapshot<LeftNaviProvider> snapshot) {
		    return Container(
		      color: snapshot.data.leftClickFlag[i] == 1 ? Colors.green : Colors.white,
		      child: LeftNaviFontCell(
			      kindData: kindData,
			      changeColor: snapshot.data.leftClickFlag[i],
			      onLeftNaviFontCellClickListener: (KindData kindData) {
				      //解决再一次点击问题
				      if (clickFlag[i] != 1) {
					      for (var j=0;j<clickFlag.length;j++) {
						      if (clickFlag[j] == 1){
							      clickFlag[j] = 0;
						      }
					      }
					      clickFlag[i] = 1;
					      Provide.value<LeftNaviProvider>(context).putLeftClickFlag(clickFlag);
					      Provide.value<LeftNaviProvider>(context).putKindDataValue(kindData);
					      Provide.value<LeftNaviProvider>(context).putCategoryId(kindData.mallCategoryId);
				      }
			      },
		      ));
	    },
    );
  }

  Future getKindMs() async {
    String url = "wxmini/getCategory";
    var data = {};
    var feedBack = await BXLifeTools().post(url, data: data);
    setState(() {
      kindMs = KindMs.fromJson(json.decode(feedBack));
      KindData kindData = kindMs.data[0];
      if(clickFlag != null){
	      clickFlag.clear();
      }
      for (var i=0;i<kindMs.data.length;i++) {
      	if(i == 0) {
	        clickFlag.add(1);
        } else {
	        clickFlag.add(0);
        }
      }
      Provide.value<LeftNaviProvider>(context).putKindDataValue(kindData);
      Provide.value<LeftNaviProvider>(context).putLeftClickFlag(clickFlag);
    });
  }
}
