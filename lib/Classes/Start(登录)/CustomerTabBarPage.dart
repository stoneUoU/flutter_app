import 'package:flutter/material.dart';
import '../DesignReport(设计报告)/Controller/DesignReportViewController.dart';
import '../DesignReport(设计报告)/Controller/DesignReportDetailViewController.dart';
import '../Start(登录)/CodeLoginViewController.dart';
import '../Find(发现)/Controller/FindPageViewController.dart';
import '../Mine(我的)/Controller/MineViewController.dart';
import '../Home(主页)/Controller/HomeViewController.dart';
import '../GoodKinds(商品类别)/Controller/GoodKindsViewController.dart';
import 'package:flutter_app/Common/Util/LocalData.dart';
import 'package:flutter_app/Common/Util/EventBusTools.dart';
import './Model/LoginEvent.dart';
import 'package:flutter_app/Macros.dart';
import 'package:flutter_custom_bottom_tab_bar/eachtab.dart';
import '../RainBowHome(彩虹设计通)/Controller/RainBowHomeViewController.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomerTabBarPage extends StatefulWidget {
	
	static CustomerTabBarPage instance;
	
	static CustomerTabBarPage getInstance() {
		if (instance == null) {
			instance = new CustomerTabBarPage();
		}
		return instance;
	}
	
	CustomerTabBarPage({Key key}) : super(key: key);
	
	_CustomerTabBarPageState customerTabBarPageState = _CustomerTabBarPageState();
	
	void selectedFirstTab() {
		customerTabBarPageState.selectedFirstTab();
	}
	
	void selectedSecondTab() {
		customerTabBarPageState.selectedSecondTab();
	}
	
	void selectedThirdTab() {
		customerTabBarPageState.selectedThirdTab();
	}
	
	@override
	_CustomerTabBarPageState createState() => customerTabBarPageState;
}

class _CustomerTabBarPageState extends State<CustomerTabBarPage> with TickerProviderStateMixin {
	
	TabController _tabController;
	int _selectedIndex = 0;
	var titles = ['首页','发现','我的'];
	
	@override
	void initState() {
		super.initState ();
		_tabController =
		new TabController(vsync: this, initialIndex: 0, length: titles.length);
		_tabController.addListener(() {
			Future<String> loginFlagStr = LocalData.getPreference("AuthosStr");
			loginFlagStr.then((String loginFlagStr) {
				if (loginFlagStr == null || loginFlagStr == "") {
					if (_tabController.index == 1) {
						_pushCodeLoginViewController(2);
					} else if (_tabController.index == 2) {
						_pushCodeLoginViewController(3);
					}
					setState(() {
						_tabController.index = 0;
						_selectedIndex = 0;
					});
					return;
				} else {
					if (_tabController.index == 1) {
						EventBusTools.eventBus.fire(new LoginEvent(loginFlagStr));
					}
					setState(() =>
						_selectedIndex = _tabController.index
					);
					return;
				}
			});
		});
	}
	
	@override
	void dispose() {
		super.dispose();
	}
	
	@override
	Widget build(BuildContext context) {
		
		return Scaffold(
			bottomNavigationBar: Container(
				height: kBottomNavigationBarHeight + Macros.TabbarSafeBottomM(context),
				child: Column(
					children: <Widget>[
						Divider(
							height: 2,
						),
						new TabBar(
							isScrollable: false,
							controller: _tabController,
							indicatorColor: Colors.transparent,
							labelColor: Colors.red,
							labelPadding: EdgeInsets.all(0),
							unselectedLabelColor: Colors.black54,
							tabs: <Widget>[
								EachTab(
								  width: 70,
								  badgeNo: '8',
								  badgeColor: Colors.red,
								  height: 48,
								  padding: EdgeInsets.all(0),
								  icon: _selectedIndex == 0
									? Image.asset(
									  'assets/images/mine_icon_store_click.png',
									  width: 20,
									  height: 20,
								  )
									: Image.asset(
									  'assets/images/mine_icon_store_onclick.png',
									  width: 20,
									  height: 20,
								  ),
								  text: titles[0],
								  iconPadding: EdgeInsets.fromLTRB(0, 4, 0, 2),
								  textStyle: TextStyle(fontSize: 10)),
								EachTab(
								  height: 40,
								  padding: EdgeInsets.all(0),
								  icon: _selectedIndex == 1
									? Image.asset(
									  'assets/images/icon_shoppingcar_click.png',
									  width: 20,
									  height: 20,
								  )
									: Image.asset(
									  'assets/images/icon_shoppingcar_onclick.png',
									  width: 20,
									  height: 20,
								  ),
								  text: titles[1],
								  iconPadding: EdgeInsets.fromLTRB(0, 4, 0, 2),
								  textStyle: TextStyle(fontSize: 10),
								),
								EachTab(
								  width: 70,
								  height: 48,
								  padding: EdgeInsets.all(0),
								  icon: _selectedIndex == 2
									? Image.asset(
									  'assets/images/mine_icon_mine_click.png',
									  width: 20,
									  height: 20,
								  )
									: Image.asset(
									  'assets/images/mine_icon_mine_onclick.png',
									  width: 20,
									  height: 20,
								  ),
								  text: titles[2],
								  iconPadding: EdgeInsets.fromLTRB(0, 4, 0, 2),
								  textStyle: TextStyle(fontSize: 10)),
							],
						),
					],
				),
			),
			body:TabBarView(
				physics: NeverScrollableScrollPhysics(), //设置滑动的效果，这个禁用滑动
				controller: _tabController,
				children: <Widget>[
					//GoodKindsViewController(tabbarSafeBottomM:Macros.TabbarSafeBottomM(context)),
					RainBowHomeViewController(),
					//这不是一个完美的解决方案:
					FindViewController(tabbarSafeBottomM:Macros.TabbarSafeBottomM(context)),
					MineViewController(tabbarSafeBottomM:Macros.TabbarSafeBottomM(context))
				],
			)
		);
	}
	
	void selectedFirstTab() {
		setState(() {
			_tabController.index = 0;
			_selectedIndex = 0;
		});
	}
	
	void selectedSecondTab() {
		setState(() {
			_tabController.index = 1;
			_selectedIndex = 1;
		});
	}
	
	void selectedThirdTab() {
		setState(() {
			_tabController.index = 2;
			_selectedIndex = 2;
		});
	}
	
	_pushCodeLoginViewController(int code) {
		Navigator.of(context).push(new MaterialPageRoute(
		  builder: (context) {
			  return new CodeLoginViewController(code: code);
		  }
		));
	}
	//用这个eachtab计算Macros.TabbarSafeBottomM(context)会出现问题，由于次界面没有问题，所以我传参过去了，暂时解决
}