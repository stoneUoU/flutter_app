import 'package:flutter/material.dart';
import 'dart:convert';
import '../../../Common/Util/BXLifeTools.dart';
import '../../../Common/Util/LogUtil.dart';
import '../Model/KindMs.dart';
import '../Model/GoodMs.dart';
import 'package:flutter_app/Macros.dart';
import '../View/RightTopNaviFontCell.dart';
import '../View/RightGridCell.dart';
import 'package:flutter_app/Common/PlaceHolderView.dart';
import 'package:provide/provide.dart';
import '../../../Provider(状态管理)/LeftNaviProvider.dart';
import '../../../Provider(状态管理)/RightGoodViewProvider.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

//  在这个文件中：Macros.StatusH(context)会等于0
class RightGoodViewController extends StatefulWidget {
  double statusH;
  double tabbarSafeBottomM;
  //构造函数
  RightGoodViewController({Key key, this.tabbarSafeBottomM, this.statusH})
      : super(key: key);
  @override
  _RightGoodViewControllerState createState() =>
      _RightGoodViewControllerState();
}

class _RightGoodViewControllerState extends State<RightGoodViewController>
    with AutomaticKeepAliveClientMixin {
  final log = Logger('_RightGoodViewController');
  GoodMs goodMs;
  KindData kindData;
  BxMallSubDto firstBxMallSubDto = BxMallSubDto();
  List<int> clickFlag = [];
  int page = 1;
  GlobalKey<EasyRefreshState> _RightGoodViewController_easyRefreshKey = new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshFooterState> _RightGoodViewController_footerKey = new GlobalKey<RefreshFooterState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstBxMallSubDto.mallSubId = "";
    firstBxMallSubDto.mallCategoryId = "";
    firstBxMallSubDto.mallSubName = "全部";
    firstBxMallSubDto.comments = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
        child: _makeRightView(),
      ),
    );
  }

  Widget _makeRightView() {
    return Container(
      child: new Container(
          child: new Column(
        children: <Widget>[
          Container(
            height: 43,
            child: StreamBuilder<LeftNaviProvider>(
              initialData: Provide.value<LeftNaviProvider>(context),
              stream: Provide.stream<LeftNaviProvider>(context),
              builder: (BuildContext context,
                  AsyncSnapshot<LeftNaviProvider> snapshot) {
	              page = 1;
                _getGoodMs("", page,
                    categoryId:
                        "${Provide.value<LeftNaviProvider>(context).categoryId}");
                if (snapshot.data.kindData.image == null) {
                  return Container();
                } else {
                  if (kindData != null) {
                    kindData.bxMallSubDto.removeAt(0);
                    snapshot.data.kindData.bxMallSubDto
                        .insert(0, firstBxMallSubDto);
                  } else {
                    snapshot.data.kindData.bxMallSubDto
                        .insert(0, firstBxMallSubDto);
                  }
                  kindData = snapshot.data.kindData;
                  if (clickFlag != null) {
                    clickFlag.clear();
                  }
                  for (var i = 0; i < kindData.bxMallSubDto.length; i++) {
                    if (i == 0) {
                      clickFlag.add(1);
                    } else {
                      clickFlag.add(0);
                    }
                  }
                  Provide.value<RightGoodViewProvider>(context)
                      .putTopClickFlag(clickFlag);
                  Provide.value<RightGoodViewProvider>(context).putCategorySubId(firstBxMallSubDto.mallSubId);
                  return _getRightListView(kindData);
                }
              },
            ),
          ),
          Container(
            width: Macros.ScreenW(context) - 120,
            height: 1,
            color: Colors.black12,
          ),
          Container(
            width: Macros.ScreenW(context) - 120,
            height: Macros.ScreenH(context) -
                Macros.NaviH -
                widget.tabbarSafeBottomM -
                widget.statusH -
                44 -
                kBottomNavigationBarHeight,
            child: StreamBuilder<RightGoodViewProvider>(
	            initialData: Provide.value<RightGoodViewProvider>(context),
	            stream: Provide.stream<RightGoodViewProvider>(context),
	            builder: (BuildContext context,
	              AsyncSnapshot<RightGoodViewProvider> snapshot) {
		            if (snapshot.data.goodMs != null) {
			            return _getContent(snapshot.data.goodMs,snapshot.data.categorySubId);
		            } else {
			            return Container();
		            }
		            
	            },
            ),
          )
        ],
      )),
    );
  }

  ListView _getRightListView(KindData kindData) => ListView.builder(
        itemCount: kindData.bxMallSubDto.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int position) {
          return getRightListRow(position, kindData);
        },
      );

  Widget getRightListRow(int i, KindData kindData) {
    BxMallSubDto bxMallSubDto = kindData.bxMallSubDto[i];
    return StreamBuilder<RightGoodViewProvider>(
      initialData: Provide.value<RightGoodViewProvider>(context),
      stream: Provide.stream<RightGoodViewProvider>(context),
      builder: (BuildContext context,
          AsyncSnapshot<RightGoodViewProvider> snapshot) {
        return Container(
            child: RightTopNaviFontCell(
          bxMallSubDto: bxMallSubDto,
          changeColor: snapshot.data.topClickFlag[i],
          onRightTopNaviFontCellClickListener: (BxMallSubDto bxMallSubDto) {
            for (var j = 0; j < clickFlag.length; j++) {
              if (clickFlag[j] == 1) {
                clickFlag[j] = 0;
              }
            }
            clickFlag[i] = 1;
            Provide.value<RightGoodViewProvider>(context)
                .putTopClickFlag(clickFlag);
            Provide.value<RightGoodViewProvider>(context)
              .putCategorySubId(bxMallSubDto.mallSubId);
            page = 1;
            _getGoodMs("${bxMallSubDto.mallSubId}", page,
                categoryId: "${kindData.mallCategoryId}");
          },
        ));
      },
    );
  }

  Widget _getContent(GoodMs goodMs,String categorySubId) {
    if (goodMs == null ||goodMs.data == null) {
      return new Center(
	      child: Text(
		      "暂无数据！！！",
		      style: TextStyle(color: Colors.red, fontSize: 24),
		      maxLines: 1,
		      overflow: TextOverflow.ellipsis,
	      ),
      );
    } else {
      return new EasyRefresh(
	      key: _RightGoodViewController_easyRefreshKey,
	      child: _getRightGridView(goodMs),
	      refreshFooter: ClassicsFooter(
		      key: _RightGoodViewController_footerKey,
		      loadText: "上拉可以加载更多",
		      loadReadyText: "松开立即加载更多",
		      loadingText: "加载数据中"+"...",
		      loadedText: "加载完成",
		      noMoreText: "暂无更多数据",
		      moreInfo: "更新数据...",
		      bgColor: Colors.transparent,
		      textColor: Colors.black87,
		      moreInfoColor: Colors.black54,
		      showMore: true,
	      ),
	      loadMore: () async {
	      	page++;
	        _getGoodMs(categorySubId, page,
		      categoryId: "${kindData.mallCategoryId}");
	      },
      );
    }
  }

  GridView _getRightGridView(GoodMs goodMs) => GridView.custom(
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
//      横轴数量 这里的横轴就是x轴 因为方向是垂直的时候 主轴是垂直的
          crossAxisCount: 2,
          mainAxisSpacing: 2.0,
          crossAxisSpacing: 2.0,
          childAspectRatio: 0.9,
        ),
        childrenDelegate: new SliverChildBuilderDelegate(
          (context, index) {
          	
            return getRightGridRow(goodMs,index);
          },
          childCount: goodMs.data.length,
        ),
      );

  Widget getRightGridRow(GoodMs goodMs,int i) {
    GoodData goodData = goodMs.data[i];
    return RightGridCell(goodData: goodData);
  }

  Future _getGoodMs(String categorySubId, int page, {String categoryId}) async {
    String url = "wxmini/getMallGoods";
    var data = {
      'categoryId': "${categoryId}" == "null" ? '4' : categoryId,
      'categorySubId': categorySubId,
      'page': page
    };
    var feedBack = await BXLifeTools().post(url, data: data);
    Provide.value<RightGoodViewProvider>(context)
      .putGoodMs(GoodMs.fromJson(json.decode(feedBack)));
  }

  @override
  bool get wantKeepAlive => true;
}
