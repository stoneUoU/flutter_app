
import 'package:flutter/material.dart';
import 'package:flutter_app/Common/STStyle.dart';
import 'package:flutter_app/Macros.dart';
import 'package:flutter_app/Common/Util/LocalData.dart';
import 'package:flutter_app/Common/Util/HudTips.dart';
import '../../Start(登录)/CustomerTabBarPage.dart';

import 'package:flutter_app/Common/Util/EventBusTools.dart';
import '../../Start(登录)/Model/LoginEvent.dart';

class HotViewController extends StatefulWidget {
	
	HotViewController({Key key}) : super(key: key);
	
	@override
	
	_HotViewController createState() => _HotViewController();
}

class _HotViewController extends State<HotViewController> with AutomaticKeepAliveClientMixin {
	
	@override
	bool get wantKeepAlive => true;
	
	@override
	void initState() {
		super.initState();
	}
	
	@override
	void dispose() {
		super.dispose();
	}
	
	@override
	Widget build(BuildContext context) {
		return Scaffold(
		    body: new Container(
		        width: MediaQuery.of(context).size.width,
		        height: MediaQuery.of(context).size.height,
		        color:Color(STColors.colorC02),
		        child: new Center(
			        child:new Container(
					    margin:EdgeInsets.fromLTRB(0, 58.0, 0,0),
					    height:45,
					    width: Macros.ScreenW(context) - 30,
					    child:new RaisedButton(
						    onPressed: (){
							    _onExit();
						    },
						    shape: StadiumBorder(),
						    child: new Text("注销",style: TextStyle(fontSize: 16.0,color: Colors.white)),
						    color:Color(0xFF63CA6C),
					    )
			        ),
		        )
		    )
		);
	}
	
	_onExit() {
		showDialog(
		    builder: (context) => new AlertDialog(
			    title: new Text('提示'),
			    content: new Text('是否要退出登录?'),
			    actions: <Widget>[
				    new FlatButton(
						onPressed: () {
							Navigator.pop(context);
						},
						child: new Text('取消')),
				    new FlatButton(
						onPressed: () {
							Navigator.pop(context);
							HudTips.showToast("注销成功");
							LocalData.setPreference("AuthosStr", "");
							EventBusTools.eventBus.fire(new LoginEvent(null));
							CustomerTabBarPage.getInstance().selectedFirstTab();
						},
						child: new Text('是的'))
			        ],
		    ),
		    context: context
		);
	}
}