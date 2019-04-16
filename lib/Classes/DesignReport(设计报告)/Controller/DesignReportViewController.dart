import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Common/Util/HttpUtil.dart';
import '../../Home(主页)/Model/HomeMs.dart';
import '../../Home(主页)/View/HomeList.dart';
import 'package:flutter_app/Classes/DesignReport(设计报告)/Model/CarouselMs.dart';
import '../View/HomeBannerView.dart';
import 'package:flutter_app/Common/PlaceHolderView.dart';
import 'package:flutter_app/Common/Util/NetCheckTools.dart';

import '../../../Routes(路由)/Routes.dart';
import '../../../Application.dart';

import '../../../Common/Util/LogUtil.dart';

//class DesignReportViewController extends StatefulWidget {
//	DesignReportViewController({Key key}) : super(key: key);
//	@override
//	_DesignReportViewController createState() => _DesignReportViewController();
//}
//
//class _DesignReportViewController extends State<DesignReportViewController> {
//	@override
//	void initState() {
//		super.initState();
//	}
//
//	@override
//	void dispose() {
//		print('移除时：dispose');
//		super.dispose();
//	}
//
//	@override
//	Widget build(BuildContext context) {
//		return Scaffold(
//			appBar: new AppBar(
//			  title: new Container(
//				  child: new Row(
//					  children: <Widget>[
//						  new Expanded(
//							child: new Center(
//								child: new Text("设计报告"),
//							)
//						  )
//					  ],
//				  ),
//			  )
//			),
//			body: Container(),//getBody(),
//		);
//	}
//}

class DesignReportViewController extends StatefulWidget {
	DesignReportViewController({Key key}) : super(key: key);
	@override
	_DesignReportViewControllerState createState() => _DesignReportViewControllerState();
}

class _DesignReportViewControllerState extends State<DesignReportViewController> {
	List widgets = [];
	HomeMs renderData = HomeMs();
	List<CarouselChildMs> mResult = [];
	int pageSize = 10;
	int pageIndex = 1;
	bool netFlag = true;

	GlobalKey<EasyRefreshState> _DesignReportViewController_easyRefreshKey = new GlobalKey<EasyRefreshState>();
	GlobalKey<RefreshHeaderState> _DesignReportViewController_headerKey = new GlobalKey<RefreshHeaderState>();
	GlobalKey<RefreshFooterState> _DesignReportViewController_footerKey = new GlobalKey<RefreshFooterState>();
	
	final log = Logger('_DesignReportViewController');
	
	@override
	void initState() {
		super.initState();
		_sendNet();
	}

	@override
	void dispose() {
		super.dispose();
		print('移除时：dispose');
	}

	_showLoadingDialog() {
		if (widgets.length == 0) {
			return true;
		}
		return false;
	}

	getBody() {
		if (!netFlag) {
			return new PlaceHolderView(
			  viewType: PlaceholderViewType.noNetwork,
			  onPlaceHolderViewClickListener: (viewType) {
				  if (viewType == PlaceholderViewType.noNetwork) {
					  _sendNet();
				  } else if (viewType == PlaceholderViewType.noGoods) {
					  print("images/noShopCart.png");
				  } else {
					  print("images/noShopCart.png");
				  }
			  });
		} else {
			if (_showLoadingDialog()) {
				return getProgressDialog();
			} else {
				return new EasyRefresh(
					key: _DesignReportViewController_easyRefreshKey,
					child: getListView(),
				    autoControl: false,
				    refreshHeader: ClassicsHeader(
					    key: _DesignReportViewController_headerKey,
					    refreshText: "下拉可以刷新",
					    refreshReadyText: "松开立即刷新",
					    refreshingText: "正在刷新数据中" + "...",
					    refreshedText: "刷新完成",
					    bgColor: Colors.transparent,
					    textColor: Colors.black87,
					    moreInfoColor: Colors.black54,
					    showMore: true,
				      moreInfo: "最后更新：%T"
				    ),
					refreshFooter: ClassicsFooter(
						key: _DesignReportViewController_footerKey,
						loadText: "上拉可以加载更多",
						loadReadyText: "松开立即加载更多",
						loadingText: "加载数据中" + "...",
						loadedText: "加载完成",
						noMoreText: "暂无更多数据",
						moreInfo: "更新数据...",
						bgColor: Colors.transparent,
						textColor: Colors.black87,
						moreInfoColor: Colors.black54,
					),
					onRefresh: () async{
						await _pullRefresh();
					},
					loadMore: () async {
						await _loadMore();
					},
				);
			}
		}
	}
	getProgressDialog() {
		return SpinKitFadingCircle(
			itemBuilder: (_, int index) {
				return DecoratedBox(
					decoration: BoxDecoration(
						color: index.isEven ? Colors.red : Colors.green,
					),
				);
			},
		);
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
								child: new Text("设计报告"),
							)
						  )
					  ],
				  ),
			  )
			),
			body: getBody(),
		);
	}

	ListView getListView() => ListView.builder(
		itemCount: widgets.length + 1,
		itemBuilder: (BuildContext context, int position) {
			if (position == 0) {
				return _makeCarousel();
			} else {
				return getRow(position);
			}
		},
	);

	Widget getRow(int i) {
		renderData = widgets[i !=0 ?i-1:0];
		return _makeList(renderData);
	}

	@override
	Widget _makeCarousel() {
		if (mResult.length == 0) {
			return new Container(
			);
		}
		return new Container(
		  height: 160,
		  child: HomeBannerView(carouselChildMs:mResult)
		);
	}

	Widget _makeList(HomeMs homeMs){
		return new HomeList(
			homeMs: homeMs,
			onHomeItemClickListener: (reportId) {
				String routeStr = Routes.designDetailView;
				var bodyJson = '{"user_id":10001,"reportId":$reportId}';
				Application.router
				  .navigateTo(context, routeStr+"?data="+bodyJson,)
				  .then((result) {
					//pop返回的回掉
					print(result);
				});
			},
		);
	}

	/*
        * 存储数据
        */
	Future _setPreference(String accountStr) async {
		SharedPreferences preferences = await SharedPreferences.getInstance();
		preferences.setString('accountStr', accountStr);
		print('存储accountStr为:$accountStr');
	}

	/*
	    * 读取数据
	    */
	Future<String> _getPreference() async {
		SharedPreferences preferences = await SharedPreferences.getInstance();
		String accountStr = preferences.get('accountStr');
		return accountStr;
	}

	_pullRefresh() {
		pageIndex = 1;
		widgets.clear();
		_loadData(true,false,false);
	}

	_loadMore() {
		pageIndex++;
		_loadData(false,true,false);
	}

	_sendNet() {
		NetworkCheck networkCheck = new NetworkCheck();
		networkCheck.checkInternet((netUseful){
			if (!netUseful) {
				if (!mounted) return;
				setState(() {
					netFlag = false;
				});
			} else {
				netFlag = true;
				_loadData(true,false,true);
			}
		});
	}

	Future<Null> _loadData(bool freshBanner,bool ifLoad, bool firstR) async {

		String url = "/Exhibition/GetReportList";
		var data = {"pageIndex":pageIndex,"pageSize":pageSize};
		var response = await HttpUtil().post(url, data: data);
		//先获取列表数据，再获取轮播图：
		if (freshBanner) {
			_getIPAddress();
		}
		if (response["flag"] == 1) {
			_cancelRefresh(ifLoad,firstR);
			if (!mounted) return;
			setState(() {
				for (int i = 0; i < response["rs"].length; i++) {
					HomeMs cellData = new HomeMs.fromJSON(response["rs"][i]);
					widgets.add(cellData);
				}
			});
		} else {
			_cancelRefresh(ifLoad,firstR);
		}
	}

	void _cancelRefresh(bool ifLoad, bool firstR) {
		if (!firstR) {
			//刷新完成
			if(ifLoad) {
				_DesignReportViewController_easyRefreshKey.currentState.callLoadMoreFinish();
			} else {
				_DesignReportViewController_easyRefreshKey.currentState.callRefreshFinish();
			}
		}
	}

	_getIPAddress() async {
		var url = 'http://www.wanandroid.com/banner/json';
		var httpClient = new HttpClient();
		List<CarouselChildMs> result;
		try {
			var request = await httpClient.getUrl(Uri.parse(url));
			var response = await request.close();
			if (response.statusCode == HttpStatus.OK) {
				var resJson = await response.transform(utf8.decoder).join();
				result = new CarouselMs.fromJson(json.decode(resJson)).data;
			} else {
				result = null;
			}
			if (!mounted) return;
			setState(() {
				mResult = result;

			});
			request.close();
		} catch (exception) {
			result = null;
		}
	}
}