import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'package:flutter/material.dart';
import 'package:flutter_app/Util/HttpUtil.dart';
import 'package:flutter_app/Util/LocalData.dart';
import './DesignReportDetailViewController.dart';
import '../../Home(主页)/Model/HomeMs.dart';
import '../../Home(主页)/View/HomeList.dart';
import '../../Home(主页)/Model/CarouselMs.dart';
import '../View/HomeBannerView.dart';

import 'package:flutter_app/Common/PlaceHolderView.dart';

import 'package:flutter_app/Util/NetCheckTools.dart';

import 'package:flutter_app/Util/EventBusTools.dart';
import '../../Start(登录)/Model/LoginEvent.dart';
import '../../../Macros.dart';

import'package:transparent_image/transparent_image.dart';

//import 'package:flutter_app/ThirdPart/Easy_reFresh/header/material_header.dart';
//import 'package:flutter_app/ThirdPart/Easy_reFresh/footer/material_footer.dart';

class DesignReportViewController extends StatefulWidget {
	DesignReportViewController({Key key}) : super(key: key);
	@override
	_DesignReportViewController createState() => _DesignReportViewController();
}

class _DesignReportViewController extends State<DesignReportViewController> with AutomaticKeepAliveClientMixin {
	List widgets = [];
	HomeMs renderData = HomeMs();
	List<CarouselChildMs> mResult = [];
	String bannerTitle = "";
	int pageSize = 10;
	int pageIndex = 1;
	bool netFlag = true;
	
	GlobalKey<EasyRefreshState> _DesignReportViewController_easyRefreshKey = new GlobalKey<EasyRefreshState>();
	GlobalKey<RefreshHeaderState> _DesignReportViewController_headerKey = new GlobalKey<RefreshHeaderState>();
	GlobalKey<RefreshFooterState> _DesignReportViewController_footerKey = new GlobalKey<RefreshFooterState>();
	
	@override
	bool get wantKeepAlive => true;
	
	@override
	void initState() {
		super.initState();
		
		_sendNet();
		
		_setEventBus();
	}
	
	showLoadingDialog() {
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
			if (showLoadingDialog()) {
				return getProgressDialog();
			} else {
				return new EasyRefresh(
					key: _DesignReportViewController_easyRefreshKey,
					child: getListView(),
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
					    loadingText: "正在加载更多数据中"+"...",
					    loadedText: "加载完成",
					    noMoreText: "暂无更多数据",
					    moreInfo: "更新数据...",
					    bgColor: Colors.transparent,
					    textColor: Colors.black87,
					    moreInfoColor: Colors.black54,
					    showMore: true,
				    ),
					onRefresh: () async{
						_pullRefresh();
					},
					loadMore: () async {
						_loadMore();
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
		super.build(context);//必须添加
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
			if (position == 0 && position != widgets.length) {
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
		return SingleChildScrollView(
		  child: new Container(
			  height: 160,
			  child: Column(
				  children: <Widget>[
					  Stack(
						  alignment: Alignment.bottomCenter,
						  children: <Widget>[
							  HomeBannerView(
								  data: mResult == null ? [] : mResult,
								  onPageChanged: onPageChanged,
								  buildShowView: (index, itemData) {
									  return new FadeInImage(
										placeholder: ExactAssetImage("images/1.png"),
										image: NetworkImage(mResult[index].imagePath));
								  },
								  onBannerClickListener: (index, itemData) {
//									  print("$index");
//									  print("$itemData");
									  LocalData.setPreference("AuthosStr", "");
								  },
							  ),
							  Container(
								  alignment: Alignment.topLeft,
								  padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
								  decoration: BoxDecoration(color: Colors.black38),
								  child: Text(
									  bannerTitle,
									  style: TextStyle(color: Colors.white),
								  ),
							  )
						  ],
					  )
				  ],
			  ),
		  )
		);
	}
	
	void onPageChanged(int index) {
		if (mounted) {
			setState (() {
				if (mResult != null && mResult.length > index) {
					this.bannerTitle = mResult[index].title;
				}
			});
		}
	}
	
	Widget _makeList(HomeMs homeMs){
		return new HomeList(
			homeMs: homeMs,
			onHomeItemClickListener: (reportId) {
				Navigator.of(context).push(new MaterialPageRoute(
				    builder: (context) {
					    return new DesignReportDetailViewController(
						    reportId: reportId,
					    );
				    }
				));
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
		_loadData(true);
	}
	
	_loadMore() {
		pageIndex++;
		_loadData(false);
	}
	
	_setEventBus() {
		EventBusTools.eventBus.on<LoginEvent>().listen((event) {
			if (!mounted) return;
			setState(() {
				if (event != null && event.token != null) {
//					print("DesignReportViewController_setEventBus");
				} else {
					print("空空如也=================");
				}
			});
		});
	}
	
	_sendNet() {
		NetworkCheck networkCheck = new NetworkCheck();
		networkCheck.checkInternet((netUseful){
			if (!netUseful) {
				if (!mounted) return;
				setState(() {
					netFlag = false;
				});
//				HudTips.showToast("没网");
			} else {
				netFlag = true;
				_loadData(true);
			}
		});
	}
	
	Future<Null> _loadData(bool freshBanner) async {
		
		String url = "/Exhibition/GetReportList";
		var data = {"pageIndex":pageIndex,"pageSize":pageSize};
		var response = await HttpUtil().post(url, data: data);
		//先获取列表数据，再获取轮播图：
		if (freshBanner) {
			_getIPAddress();
		}
		if (response["flag"] == 1) {
			print(response["rs"]);
			if (mounted) {
				setState(() {
					for (int i = 0; i < response["rs"].length; i++) {
						try {
							HomeMs cellData = new HomeMs.fromJSON(response["rs"][i]);
							widgets.add(cellData);
						} catch (e) {
							// No specified type, handles all
							print(e);
						}
					}
				});
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
			request.close();
		} catch (exception) {
			result = null;
		}
		
		if (!mounted) return;
		
		setState(() {
			mResult = result;
			bannerTitle = result[0].title;
		});
	}
}