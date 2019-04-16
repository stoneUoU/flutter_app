import '../../../Common/Util/LogUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:flutter_app/Macros.dart';
import 'package:flutter_app/Common/Config/STStyle.dart';
import '../Model/RainBowHomeRotationMs.dart';
import '../Model/RainBowHomeListMs.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_app/Common/Util/HudTips.dart';
import '../View/RainBowHorizontalView.dart';
import '../View/SwiperView.dart';
import '../View/MarqueeView.dart';

import '../View/CustomScrollViewCells/PrivateSchoolCell.dart';
import '../View/CustomScrollViewCells/DesignerNoPhotoCell.dart';
import '../View/CustomScrollViewCells/DesignerPhotoCell.dart';
import '../View/CustomScrollViewCells/DesignRealStuffCell.dart';
import '../View/CustomScrollViewCells/PurchaseNoPhotoCell.dart';
import '../View/CustomScrollViewCells/PurchasePhotoCell.dart';

import '../../../Routes(路由)/Routes.dart';
import '../../../Application.dart';

class RainBowHomeViewController extends StatefulWidget {
  //构造函数
  RainBowHomeViewController({Key key}) : super(key: key);

  @override
  _RainBowHomeViewController createState() => _RainBowHomeViewController();
}

class _RainBowHomeViewController extends State<RainBowHomeViewController>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  final log = Logger('_RainBowHomeViewController');
  List dataLists = [
    {"index": 0, "picStr": "images/findDesigner.png", "textStr": "找设计师"},
    {"index": 1, "picStr": "images/designReport.png", "textStr": "设计报告"},
    {"index": 2, "picStr": "images/findDesigner.png", "textStr": "找设计师"},
    {"index": 3, "picStr": "images/privateSchool.png", "textStr": "作品私馆"},
    {"index": 4, "picStr": "images/planningCase.png", "textStr": "看策划案"},
    {"index": 5, "picStr": "images/findDesigner.png", "textStr": "找设计师"},
    {"index": 6, "picStr": "images/designCourse.png", "textStr": "设计课"},
  ];
  Dio dio;
  Options options;
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();
  int flag = 0;
  int _pageIndex = 1;
  Future _futureBuilderFuture;
  List<Rs> loadMoreRs = [];
  List<Map<String, dynamic>> loadMoreJson = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (!mounted) return;
    _futureBuilderFuture = _sendMutilR(1, 0, 1);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return new Scaffold(
        body: FutureBuilder(
            future: _futureBuilderFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                RainBowHomeRotationMs rotationMs =
                    RainBowHomeRotationMs.fromJson(snapshot.data[0].data["rs"]);
                RainBowHomeListMs homeListMs =
                    RainBowHomeListMs.fromJson(snapshot.data[1].data);
                return returnSliverView(rotationMs, homeListMs);
              } else {
                return Center(child: SpinKitFadingCircle(
                  itemBuilder: (_, int index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        color: index.isEven ? Colors.red : Colors.green,
                      ),
                    );
                  },
                ));
              }
            }));
  }

  Widget returnSliverView(
      RainBowHomeRotationMs rotationMs, RainBowHomeListMs listMs) {
    return new Container(
        width: Macros.ScreenW(context),
        height: Macros.ScreenH(context) -
            kBottomNavigationBarHeight -
            Macros.TabbarSafeBottomM(context),
        child: new EasyRefresh(
          key: _easyRefreshKey,
          autoControl: false,
          behavior: ScrollOverBehavior(),
          child: new CustomScrollView(
            // 手动维护semanticChildCount,用于判断是否没有更多数据
            slivers: _buildSlivers(context, rotationMs, listMs),
          ),
          refreshHeader: ClassicsHeader(
              key: _headerKey,
              refreshText: "下拉可以  刷新",
              refreshReadyText: "松开立即刷新",
              refreshingText: "正在刷新数据中" + "...",
              refreshedText: "刷新完成",
              bgColor: Colors.transparent,
              textColor: Colors.black87,
              moreInfoColor: Colors.black54,
              showMore: true,
              moreInfo: "最后更新：%T"),
          refreshFooter: ClassicsFooter(
            key: _footerKey,
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
          onRefresh: () async {
            //await new Future.delayed(const Duration(seconds: 3), () {
            setState(() {
              _pageIndex = 1;
              _futureBuilderFuture = _sendMutilR(_pageIndex, 0, 0);
            });
            //});
          },
          loadMore: () async {
            setState(() {
              _pageIndex++;
              _futureBuilderFuture = _sendMutilR(_pageIndex, 1, 0);
            });
          },
        ));
  }

  List<Widget> _buildSlivers(BuildContext context,
      RainBowHomeRotationMs rotationMs, RainBowHomeListMs listMs) {
    List<Widget> slivers = new List<Widget>();
    slivers.add(_makeTopHeader(context, rotationMs));
    for (int index = 0; index < listMs.rs.length; index++) {
      slivers.add(_makeFixedHeader(context));
      slivers.addAll(_buildLists(context, 0, index, listMs));
    }
    return slivers;
  }

  List<Widget> _buildLists(BuildContext context, int firstIndex, int count,
      RainBowHomeListMs listMs) {
    return List.generate(1, (sliverIndex) {
      sliverIndex += firstIndex;
      return new SliverStickyHeader(
        header: _buildHeader(sliverIndex),
        sliver: new SliverList(
          delegate: new SliverChildBuilderDelegate(
            (context, i) => InkWell(
                onTap: () {}, child: _makeCustomerCell(i, count, listMs)),
            childCount: 1,
          ),
        ),
      );
    });
  }

  //type   1:作品   2:案例  3:设计师  4:设计干货  5:策划案  6:私馆  7:课程  8:广告  9:采购  10:主题  11:设计报告
  Widget _makeCustomerCell(int i, int count, RainBowHomeListMs listMs) {
    Rs listRs = listMs.rs[count];
//    print("====== ${listRs.type}");
    if (listRs.type == 6 ||
        listRs.type == 1 ||
        listRs.type == 2 ||
        listRs.type == 5 ||
        listRs.type == 10 ||
        listRs.type == 11) {
      return PrivateSchoolCell(
        rs: listRs,
        onPrivateSchoolCellClickListener: (String str) {
          if (listRs.type == 11) {
            String routeStr = Routes.designDetailView;
            var bodyJson = '{"user_id":10001,"reportId":$str}';
            Application.router
              .navigateTo(context, routeStr+"?data="+bodyJson,)
              .then((result) {
              //pop返回的回掉
              print(result);
            });
          }
          print("_______${str}");
        },
      );
    } else if (listRs.type == 3) {
      if (listRs.listImg.length == 3) {
        return DesignerPhotoCell(rs: listRs);
      } else {
        return DesignerNoPhotoCell(rs: listRs);
      }
    } else if (listRs.type == 4) {
      return DesignRealStuffCell(rs: listRs);
    } else if (listRs.type == 9) {
      if (listRs.bigImg.length == 0) {
        return PurchaseNoPhotoCell(rs: listRs);
      } else {
        return PurchasePhotoCell(rs: listRs);
      }
    } else {
      return Container(
        height: 64,
        color: Color(STColors.colorC06),
      );
    }
  }

  Widget _makeTopHeader(
      BuildContext context, RainBowHomeRotationMs rotationMs) {
    List<NewBannerList> carouselLists = rotationMs.newBannerList;
    List<NewsList> newsLists = rotationMs.newsList;
    return SliverPersistentHeader(
        pinned: false,
        delegate: _UnFixHeaderDelegate(
            295.0,
            295.0,
            Container(
              child: Column(
                children: <Widget>[
                  SwiperView(
                    dataList: carouselLists,
                  ),
                  RainBowHorizontalView(
                    dataList: dataLists,
                    onHorizontalViewClickListener: (int index) {
                      if (index == 1) {
                        String routeStr = Routes.designView;
                        Application.router
                            .navigateTo(
                          context,
                          routeStr,
                        ).then((result) {
                          //pop返回的回掉
                          print(result);
                        });
                      } else {}
                    },
                  ),
                  MarqueeView(
                    newLists: newsLists,
                  ),
                ],
              ),
            )));
  }

  Widget _makeFixedHeader(BuildContext context) {
    return SliverPersistentHeader(
        pinned: false,
        delegate: _UnFixHeaderDelegate(
            10.0,
            10.0,
            new Container(
              height: 10.0,
              color: Color(STColors.colorC11),
            )));
  }

  Widget _buildHeader(int index, {String text}) {
    return new Container();
  }

  // TODO: 两个网络请求一起   firstR:是否第一次请求
  Future _sendMutilR(int pageindex, int ifLoad, int firstR) async {
    print("_RainBowHomeViewController请求了");
    String url1 = "/Home/GetHomeInfoTop"; //图片轮播+跑马灯
    String url2 = "/2.0.0/User/DataRecommendationList"; //list列表数据

    var data1 = {"userType": "1"};
    var data2 = {
      "TouristID": "9F2DB667-E32F-47BB-9A5E-23ED1C013800",
      "userId":
          "xiYKGnf7tf\/pNKH3y6K3iAdaU7OHRAZVEsSdBBd+hD+rTcelwJ3VYgfZVJlXRNjHAtPZ\/RRORrHvwEYdXQhLsMrp12F0FKrvFT2rUHwO0Aj3TLXMPB9MJzRwXpGf44sM3JuE1as+ISilADt4ChTE5aZdCJZJWbEOdo5dN6Q7x9o=",
      "pageindex": pageindex
    };
    options = Options(
      headers: {
        HttpHeaders.acceptHeader: "accept: application/json",
      },
    );
    List<Response> response;
    dio = new Dio(options);
    response = await Future.wait([
      dio.post("${Macros.RainBowUrl}${url1}", data: data1),
      dio.post("${Macros.RainBowUrl}${url2}", data: data2)
    ]);
    if (firstR == 0) {
      //刷新完成
      if (ifLoad == 1) {
        _easyRefreshKey.currentState.callLoadMoreFinish();
      } else {
        _easyRefreshKey.currentState.callRefreshFinish();
      }
    }
    if (ifLoad == 0) {
      if (int.parse(response[1].data["UpdateCount"].toString()) > 0) {
        HudTips.showToast(
            "成功为您更新${response[1].data["UpdateCount"].toString()}条推荐");
      } else {
        HudTips.showToast("暂无更新");
      }
    }
    log.fine('response.data.length: ${response[1].data["rs"].length}');
    loadMoreRs.clear();
    if (ifLoad == 1) {
      List resRs = response[1].data["rs"];
      for (var i = 0; i < resRs.length; i++) {
        Rs lastRs = Rs.fromJson(resRs[i]);
        loadMoreRs.add(lastRs);
      }
    } else {
      loadMoreJson.clear();
      List resRs = response[1].data["rs"];
      for (var i = 0; i < resRs.length; i++) {
        Rs lastRs = Rs.fromJson(resRs[i]);
        loadMoreRs.add(lastRs);
      }
    }
    for (var i = 0; i < loadMoreRs.length; i++) {
      Rs lastRs = loadMoreRs[i];
      Map<String, dynamic> resStr = lastRs.toJson();
      loadMoreJson.add(resStr);
    }
    response[1].data["rs"] = loadMoreJson;
    return response;
  }

  @override
  bool get wantKeepAlive => true;
}

class _UnFixHeaderDelegate extends SliverPersistentHeaderDelegate {
  _UnFixHeaderDelegate(
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  );
  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(child: child);
  }

  @override
  bool shouldRebuild(_UnFixHeaderDelegate oldDelegate) {
    return false;
  }
}
