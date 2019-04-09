
import 'package:flutter/material.dart';
import 'package:flutter_app/Macros.dart';
import 'package:flutter_custom_bottom_tab_bar/eachtab.dart';

import './FollowViewController.dart';
import './HotViewController.dart';
import './NoticeViewController.dart';

class FindViewController extends StatefulWidget {
	
	double tabbarSafeBottomM;
	
	FindViewController({Key key,this.tabbarSafeBottomM}) : super(key: key);
	
	@override
	
	_FindViewController createState() => _FindViewController();
}

class _FindViewController extends State<FindViewController> with SingleTickerProviderStateMixin {
	
	TabController _tabController;
	var titles = ['推荐', '科技', '汽车'];
	var _selectedIndex = 0;
	@override
	void dispose() {
		_tabController.dispose();
		super.dispose();
	}
	
	void initState() {
		super.initState();
		_tabController =
		new TabController(vsync: this, initialIndex: 0, length: titles.length);
		_tabController.addListener(() {
			setState(() => _selectedIndex = _tabController.index);
		});
	}
	
	@override
	Widget build(BuildContext context) {
		return new Scaffold(
			body: Column(
				children: <Widget>[
					_makeStatusAndNaviBar(),
					_makeSubView()
				],
			)
		);
	}
	
	Widget _makeSubView() {
		return Container(
			width:Macros.ScreenW(context),
			height: Macros.ScreenH(context) - Macros.StatusH(context) - kToolbarHeight - widget.tabbarSafeBottomM - kBottomNavigationBarHeight,
			child:	IndexedStack(
				index: _selectedIndex,
				children: <Widget>[
					new FollowViewController(),
					new NoticeViewController(),
					new HotViewController()
				],
			),
		);
	}
	

	
	Widget _makeStatusAndNaviBar() {
		return new Container(
		    width:Macros.ScreenW(context),
		    height:Macros.StatusH(context) + kToolbarHeight,
		    color:Colors.redAccent,
		    child:Container(
			    margin: EdgeInsets.fromLTRB(0, Macros.StatusH(context), 0, 0),
			    child: new TabBar(
				    isScrollable: false,
				    controller: _tabController,
				    indicatorColor: Colors.transparent,
				    labelColor: Colors.green,
				    labelPadding: EdgeInsets.all(0),
				    unselectedLabelColor: Colors.white,
				    tabs: <Widget>[
					    EachTab(
					      height: 40,
					      text: titles[0],
					      textStyle: TextStyle(fontSize: 16)),
					    EachTab(
					      height: 40,
					      text: titles[1],
					      textStyle: TextStyle(fontSize: 16)),
					    EachTab(
					      height: 40,
					      text: titles[2],
					      textStyle: TextStyle(fontSize: 16)),
				    ],
			    )
		    )
		);
	}
}