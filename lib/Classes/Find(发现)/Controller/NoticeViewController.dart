import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/Macros.dart';
import 'package:flutter_app/Common/STStyle.dart';
//import 'package:provide/provide.dart';
//import 'package:flutter_app/Provider(状态管理)/Counter.dart';
//import 'package:flutter_app/Provider(状态管理)/CountBLoC.dart';
//import 'package:flutter_app/Provider(状态管理)/Bloc_provider.dart';
import 'package:flutter_app/Common/Util/HttpUtil.dart';
import '../Model/NoticeMs.dart';
import '../../Home(主页)/View/HomeList.dart';

class NoticeViewController extends StatefulWidget {
	
	NoticeViewController({Key key}) : super(key: key);
	
	@override
	
	_NoticeViewController createState() => _NoticeViewController();
	
}

class _NoticeViewController extends State<NoticeViewController> with AutomaticKeepAliveClientMixin {
	
	List widgets = [];
	
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
		return new MaterialApp(
		    theme: Macros.themeData,
		    home: new Scaffold(
				body:FutureBuilder(
		            future:_loadData(),
					builder: (context,snapshot){
					if(snapshot.hasData){
//						print(snapshot.data);
						var data=snapshot.data;
						for (int i = 0; i < data.length; i++) {
							NoticeMs cellData = new NoticeMs.fromJson(data[i]);
							widgets.add(cellData);
						}
						return Column(
							children: <Widget>[
								new Container(
									width: Macros.ScreenW(context),
									height: Macros.ScreenH(context) - Macros.TabbarSafeBottomM(context) - kBottomNavigationBarHeight - kToolbarHeight - Macros.StatusH(context),
									child: getListView(),
								)
							],
						);
					}else{
						return Center(
							child: Text('加载中'),
						);
					}
				})
		    )
		);
	}
	
	ListView getListView() => ListView.builder(
		itemCount: widgets.length,
		itemBuilder: (BuildContext context, int position) {
			return getRow(position);
		},
	);
	
	Widget getRow(int i) {
		NoticeMs renderData = widgets[i];
		return _makeList(renderData);
	}
	
	Widget _makeList(NoticeMs noticeMs){
		return new Text (noticeMs.description, style: new TextStyle(fontSize:10));
	}
	
	Future _loadData() async {
		
		String url = "/Exhibition/GetReportList";
		var data = {"pageIndex":1,"pageSize":10};
		var response = await HttpUtil().post(url, data: data);
		//先获取列表数据，再获取轮播图：
		if (response["flag"] == 1) {
			return response["rs"];
		} else {
			return response;
		}
	}
}


//new Column(
//children: <Widget>[
//new Center(
//child: Provide<Counter>(
//builder: (context, child, counter) => new Center(
//child: new Text("${counter.value}",
//style: new TextStyle(fontSize: 60.0, color: Colors.red),
//textAlign: TextAlign.center
//),
//),
//),
//),
//new Center(
//child: StreamBuilder<int>(
//initialData: bLoC.value,
//stream: bLoC.stream,
//builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
//return new Text("${snapshot.data}",
//style: new TextStyle(fontSize: 60.0, color: Colors.red),
//textAlign: TextAlign.center
//);
//},
//),
//),
//new Center(
//child: StreamBuilder<int>(
//initialData: BlocProvider.of(context).value,
//stream: BlocProvider.of(context).stream,
//builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
//return new Text("${snapshot.data}",
//style: new TextStyle(fontSize: 60.0, color: Colors.red),
//textAlign: TextAlign.center
//);
//},
//),
//),
//],
//)