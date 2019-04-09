import 'package:flutter/material.dart';
//import 'package:flutter_app/Common/BasefulWidget.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

import 'package:flutter_app/Macros.dart';
import 'package:flutter_app/Common/STStyle.dart';

class MineViewController extends StatefulWidget {
	
	int numberFlag;
	double tabbarSafeBottomM;
	//构造函数
	MineViewController({Key key,this.numberFlag,this.tabbarSafeBottomM}) : super(key: key);
	
	@override
	_MineViewController createState() => _MineViewController();
}

class _MineViewController extends State<MineViewController>  with AutomaticKeepAliveClientMixin,TickerProviderStateMixin{
	
	List dataLists = new List();
	@override
	void initState() {
		super.initState();
		dataLists = [
			[
				{"png":"wodeyinhangka.png","vals":"我的优惠券"},
				{"png":"wodetanwei.png","vals":"摊位管理"}
			],
			[
				{"png":"shouhuodizhi.png","vals":"收货地址"}
			],
			[
				{"png":"lianxikefu.png","vals":"联系客服"},
				{"png":"shezhi.png","vals":"设置"}
			],
			[
				{"png":"aboutUs.png","vals":"关于我们"}
			]
		];
	}
	
	@override
	void dispose() {
		super.dispose();
	}
	
	@override
	Widget build(BuildContext context) {
		super.build(context);
		return new Scaffold(
			body: new Builder(builder: (BuildContext context) {
				return Container(
					child: new Column(
						children: <Widget>[
//							_makeStatusAndNaviBar(context),
							returnSliverView(),
						],
					),
				);
			}),
		);
	}
	
	
	Widget returnSliverView() {
		if (widget.numberFlag == 1) {
			return new Container(
			    height:Macros.ScreenH(context),//-kToolbarHeight - Macros.StatusH(context),
			    child: new CustomScrollView(
				    slivers: _buildSlivers(context),
			    )
			);
		} else {
			return new Container(
			  height:Macros.ScreenH(context) - widget.tabbarSafeBottomM - kBottomNavigationBarHeight,//-kToolbarHeight - Macros.StatusH(context),
			  child: new CustomScrollView(
				  slivers: _buildSlivers(context),
			  )
			);
		}
	}
	
	List<Widget> _buildSlivers(BuildContext context) {
		List<Widget> slivers = new List<Widget>();
		
		slivers.add(_sliverBuilder(context,true));
		slivers.add(_sliverPersistentHeader(context,true));
//		slivers.add(SliverAppBar(
//			backgroundColor: Colors.blue,
//			expandedHeight: 200.0,  //展开高度200
//			pinned: true,
//		    flexibleSpace: FlexibleSpaceBar(
//			    centerTitle: true,
//			    title: Text('Flutter Strong'),
//			    background: Image.network(
//				  "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1531798262708&di=53d278a8427f482c5b836fa0e057f4ea&imgtype=0&src=http%3A%2F%2Fh.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2F342ac65c103853434cc02dda9f13b07eca80883a.jpg",
//				  fit: BoxFit.cover,
//			    ),
//		    ),
//		));
//		slivers.add(_buildBuilderExample());
//		slivers.addAll(_buildHeaderBuilderLists(context, i, i += 2));
//		slivers.add(_buildUnAtacticCell());
//		slivers.addAll(_buildGrids(context, i, i += 2));
		for (int index=0;index<dataLists.length;index++) {
			slivers.add(_makeFixedHeader(context));
			slivers.addAll(_buildLists(context, 0, index));
			slivers.add(_makeFixedFooter(context));
		}
		slivers.add(_makeFixedHeader(context));
//		slivers.addAll(_buildSideHeaderGrids(context, i, i += 1));
		return slivers;
		
	}
	
	List<Widget> _buildLists(BuildContext context, int firstIndex, int count) {
		return List.generate(1, (sliverIndex) {
			sliverIndex += firstIndex;
			return new SliverStickyHeader(
				header: _buildHeader(sliverIndex),
				sliver: new SliverList(
					delegate: new SliverChildBuilderDelegate(
						  (context, i) => InkWell(
							    onTap: () { // 按下
								    print(dataLists[count][i]);
							    },
								child:_makeCustomerCell(i,count)
						  ),
						childCount: dataLists[count].length,
					),
				),
			);
		});
	}
	
	Widget _makeCustomerCell(int i,int count) {
		return new Container(
		    height:44,
		    color:Colors.white,
		    child:Column(
			    children: <Widget>[
				    new Container(
					    height:43,
					    child: new Stack(
							children: <Widget>[
								new Container(
									margin:EdgeInsets.fromLTRB(15, 0, 0, 0),
									child: new Align(
									    alignment: FractionalOffset.centerLeft,
									    child:new Row(
											  mainAxisAlignment: MainAxisAlignment.center,
											  mainAxisSize: MainAxisSize.min,
											  children: <Widget>[
												  new Image.asset('assets/images/${dataLists[count][i]["png"]}'),//("${dataLists[count][i]["png"]}"),
												  Container(
													  margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
													  child: new Text(
														  "${dataLists[count][i]["vals"]}",
														  style: new TextStyle(
															  fontSize: 16.0, ),
													  ),
												  )
											  ],
									    )
									),
								),
								new Container(
			                        margin:EdgeInsets.fromLTRB(0, 0, 15, 0),
			                        child:new Align(
				                        alignment: FractionalOffset.centerRight,
				                        child:  new Container(
					                        child: new Image.asset('assets/images/seeIcon.png'),
				                        ),
			                        )
								),
							]
					    ),
				    ),new Container(
					    margin: EdgeInsets.all(0),
					    height:1,
					    color: "$i" == "${dataLists[count].length - 1}" ? Colors.white : Color(STColors.colorC08),
				    )
			    ],
		    )
		);
	}
	
	Widget _buildUnAtacticCell() {
		return  new SliverToBoxAdapter(
			child: new Container(
			  margin: EdgeInsets.only(top: 15.0,),
			  child: new Row(
				  children: <Widget>[
					  new Expanded(child: new Container(
						  child: new Text("新闻内容1",
							  style: new TextStyle(
								color: Colors.black45
							  ),
						  ),
						  color: Colors.redAccent,
						  padding: EdgeInsets.only(left: 20.0, top: 20.0),
						  margin: EdgeInsets.only(left: 15.0, right: 5.0),
						  height: 150,
//						  decoration: new BoxDecoration(
//							borderRadius: BorderRadius.all(
//							  const Radius.circular(5.0)),
//							image: DecorationImage(
//							  image: AssetImage(""),
//							  fit: BoxFit.cover)
//						  ),
					  )
					  ),
					  new Expanded(child: new Column(
						  children: <Widget>[
							  new Container(
								  child: new Text("新闻内容2",
									  style: new TextStyle(
										color: Colors.black45
									  ),
								  ),
								  height: 70,
								  color: Colors.redAccent,
								  padding: EdgeInsets.only(left: 10.0, top: 10.0),
								  margin: EdgeInsets.only(
									  left: 5.0,
									  right: 15.0,
									  bottom: 5.0,),
								  width: double.infinity,
//								  decoration: new BoxDecoration(
//									borderRadius: BorderRadius.all(
//									  const Radius.circular(5.0)),
//									image: DecorationImage(
//									  image: AssetImage(""),
//									  fit: BoxFit.fill)
//								  ),
							  ),
							  new Container(
								  padding: EdgeInsets.only(left: 10.0, top: 10.0),
								  color: Colors.redAccent,
								  margin: EdgeInsets.only(
									left: 5.0,
									right: 15,
									top: 5.0),
								  child: new Text("新闻内容3",
									  style: new TextStyle(
										color: Colors.black45
									  ),),
								  height: 70,
								  width: double.infinity,
//								  decoration: new BoxDecoration(
//									borderRadius: BorderRadius.all(
//									  const Radius.circular(5.0)),
//									image: DecorationImage(
//									  image: AssetImage(""),
//									  fit: BoxFit.fill)
//								  ),
							  )
						  ],
					  ))
				  ],
			  )
			),
		);
	}
	
	Widget _sliverBuilder(BuildContext context, bool innerBoxIsScrolled) {
		
		return  SliverAppBar(
				//标题居中
				centerTitle: true,
				//展开高度200
				expandedHeight: 200.0,
				//不随着滑动隐藏标题
				floating: false,
				//固定在顶部
				pinned: false,
				flexibleSpace: FlexibleSpaceBar(
					centerTitle: true,
					title: Text('我是一个FlexibleSpaceBar'),
					background: Image.network(
						"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1531798262708&di=53d278a8427f482c5b836fa0e057f4ea&imgtype=0&src=http%3A%2F%2Fh.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2F342ac65c103853434cc02dda9f13b07eca80883a.jpg",
						fit: BoxFit.cover,
					),
				),
			);
		}
	
	Widget _makeFixedHeader(BuildContext context) {
		
		return  SliverPersistentHeader(
		    pinned:false,
		    delegate: _UnFixHeaderDelegate(10.0, 10.0, new Container(
			    height: 10.0,
			    color: Color(STColors.colorC08),
		    ))
		);
	}
	
	Widget _makeFixedFooter(BuildContext context) {
		
		return  SliverPersistentHeader(
		  pinned:false,
		  delegate: _UnFixHeaderDelegate(0.0, 0.0, new Container(
			  height: 0,
			  color: Color(STColors.colorC08),
		  ))
		);
	}
	
	Widget _sliverPersistentHeader(BuildContext context, bool innerBoxIsScrolled) {
		
		return  SliverPersistentHeader(
			pinned:true,
		    delegate: _SliverAppBarDelegate(
		        TabBar(
			        labelColor: Colors.redAccent,
			        indicatorColor: Colors.redAccent,
			        unselectedLabelColor: Colors.grey,
			        tabs: [
				        Tab(icon: Icon(Icons.cake), text: '左侧'),
				        Tab(icon: Icon(Icons.golf_course), text: '右侧'),
			        ],
			        controller: TabController(length: 2, vsync: this),
		        )
		    )
		);
	}
	
	Widget _buildSideHeader(BuildContext context, int index, {String text}) {
		return Padding(
			padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
			child: Align(
				alignment: Alignment.centerLeft,
				child: new SizedBox(
					height: 44.0,
					width: 44.0,
					child: GestureDetector(
						onTap: () => Scaffold
						  .of(context)
						  .showSnackBar(new SnackBar(content: Text('$index'))),
						child: new CircleAvatar(
							backgroundColor: Colors.orangeAccent,
							foregroundColor: Colors.white,
							child: new Text('$index'),
						),
					),
				),
			),
		);
	}
	
	List<Widget> _buildSideHeaderGrids(
	    BuildContext context, int firstIndex, int count) {
			return List.generate(count, (sliverIndex) {
				sliverIndex += firstIndex;
				return new SliverStickyHeader(
					overlapsContent: true,
					header: _buildSideHeader(context, sliverIndex),
					sliver: new SliverPadding(
						padding: new EdgeInsets.only(left: 60.0),
						sliver: new SliverGrid(
							gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
							  crossAxisCount: 3,
							  crossAxisSpacing: 4.0,
							  mainAxisSpacing: 4.0,
							  childAspectRatio: 1.0),
							delegate: new SliverChildBuilderDelegate( (context, i) =>
							    GestureDetector(
									onTap: () => Scaffold.of(context).showSnackBar(
									  new SnackBar(content: Text('Grid tile #$i'))),
									child: new GridTile(
										child: Card(
											child: new Container(
												color: Colors.orange,
											),
										),
										footer: new Container(
											color: Colors.white.withOpacity(0.5),
											child: Padding(
												padding: const EdgeInsets.all(8.0),
												child: new Text(
													'Grid tile #$i',
													style: const TextStyle(color: Colors.black),
												),
											),
										),
									),
								),
								childCount: 12,
							),
						),
					),
				);
			});
		}
	
	
	List<Widget> _buildGrids(BuildContext context, int firstIndex, int count) {
		return List.generate(count, (sliverIndex) {
			sliverIndex += firstIndex;
			return new SliverStickyHeader(
				header: _buildHeader(sliverIndex),
				sliver: new SliverGrid(
					gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
					  crossAxisCount: 3, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
					delegate: new SliverChildBuilderDelegate(
						  (context, i) => GestureDetector(
							onTap: () => Scaffold.of(context).showSnackBar(
							  new SnackBar(content: Text('Grid tile #$i'))),
							child: new GridTile(
								child: Card(
									child: new Container(
										color: Colors.green,
									),
								),
								footer: new Container(
									color: Colors.white.withOpacity(0.5),
									child: Padding(
										padding: const EdgeInsets.all(8.0),
										child: new Text(
											'Grid tile #$i',
											style: const TextStyle(color: Colors.black),
										),
									),
								),
							),
						),
						childCount: 9,
					),
				),
			);
		});
	}
	
	Widget _buildHeader(int index, {String text}) {
		return new Container(
//			height: 60.0,
//			color: Colors.lightBlue,
//			padding: EdgeInsets.symmetric(horizontal: 16.0),
//			alignment: Alignment.centerLeft,
//			child: new Text(
//				text ?? 'Header #$index',
//				style: const TextStyle(color: Colors.white),
//			),
		);
	}
	
	List<Widget> _buildHeaderBuilderLists(
	    BuildContext context, int firstIndex, int count) {
			return List.generate(count, (sliverIndex) {
				sliverIndex += firstIndex;
				return new SliverStickyHeaderBuilder(
					builder: (context, state) =>
					  _buildAnimatedHeader(context, sliverIndex, state),
					sliver: new SliverList(
						delegate: new SliverChildBuilderDelegate(
							  (context, i) => new ListTile(
								leading: new CircleAvatar(
									child: new Text('$sliverIndex'),
								),
								title: new Text('List tile #$i'),
							),
							childCount: 4,
						),
					),
				);
			});
		}
	
	Widget _buildAnimatedHeader(
	    BuildContext context, int index, SliverStickyHeaderState state) {
			return GestureDetector(
				onTap: () => Scaffold.of(context).showSnackBar(new SnackBar(content: Text('$index'))),
				child: new Container(
					height: 60.0,
					color: (state.isPinned ? Colors.pink : Colors.lightBlue)
					  .withOpacity(1.0 - state.scrollPercentage),
					padding: EdgeInsets.symmetric(horizontal: 16.0),
					alignment: Alignment.centerLeft,
					child: new Text(
						'Header #$index',
						style: const TextStyle(color: Colors.white),
					),
				),
			);
		}
	
	
	Widget _buildExample(BuildContext context) {
		return new SliverStickyHeader(
			header: new Container(
			    height: kToolbarHeight + Macros.StatusH(context),
				color: Colors.lightBlue,
				padding: EdgeInsets.symmetric(horizontal: 16.0),
				alignment: Alignment.centerLeft,
			    child: new Container(
				    margin: EdgeInsets.fromLTRB(0, Macros.StatusH(context), 0, 0),
				    height:kToolbarHeight,
				    child: new Center(
					    child:new Text(
						    '测试',
						    style: TextStyle(color: Colors.white,fontSize: 24),
					    ),
				    ),
			    )
			),
			sliver: new SliverList(
				delegate: new SliverChildBuilderDelegate(
					  (context, i) => new ListTile(
						leading: new CircleAvatar(
							child: new Text('0'),
						),
						title: new Text('List tile #$i'),
					),
					childCount: 4,
				),
			),
		);
	}
	
	Widget _buildBuilderExample() {
		return new SliverStickyHeaderBuilder(
			builder: (context, state) => new Container(
				height: kToolbarHeight + Macros.StatusH(context),
				color: (state.isPinned ? Colors.pink : Colors.lightBlue)
				  .withOpacity(1.0 - state.scrollPercentage),
				padding: EdgeInsets.symmetric(horizontal: 16.0),
				alignment: Alignment.centerLeft,
				child: new Container(
					margin: EdgeInsets.fromLTRB(0, Macros.StatusH(context), 0, 0),
					height:kToolbarHeight,
					child: new Center(
						child:new Text(
							'测试',
							style: TextStyle(color: Colors.white,fontSize: 24),
						),
					),
				)
			),
			sliver: new SliverList(
				delegate: new SliverChildBuilderDelegate(
					  (context, i) => new ListTile(
						leading: new CircleAvatar(
							child: new Text('0'),
						),
						title: new Text('List tile #$i'),
					),
					childCount: 100,
				),
			),
		);
	}
	
	Widget _makeStatusAndNaviBar(BuildContext context) {
		
		return new Container(
		    width:Macros.ScreenW(context),
		    height:Macros.StatusH(context) + kToolbarHeight,
		    child: new Container(
			    margin: EdgeInsets.fromLTRB(15.0, Macros.StatusH(context), 15.0, 0),
			    width:Macros.ScreenW(context) - 30.0,
			    height: kToolbarHeight,
			    child:new Stack(
					children: <Widget>[
						new Align(
							alignment: FractionalOffset.centerLeft,
							child:GestureDetector(
								onTap: () { // 按下
									Navigator.pop(context);
								},
								child: new Container(
									child: new Image.asset('assets/images/clickBack.png'),
								),
							),
						),
						new Align(
							alignment: FractionalOffset.centerRight,
							child: GestureDetector(
								onTap: () { // 按下
									print("按下了哈哈哈哈哈");
								},
								child: new Container(
									child: new Image.asset('assets/images/clickBack.png'),
								),
							),
						),
					]
			    ),
		    )
		);
	}
	
	@override
	bool get wantKeepAlive => true;
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
	_SliverAppBarDelegate(this._tabBar);
	
	final TabBar _tabBar;
	
	@override
	double get minExtent => _tabBar.preferredSize.height;
	
	@override
	double get maxExtent => _tabBar.preferredSize.height;
	
	@override
	Widget build(
	  BuildContext context, double shrinkOffset, bool overlapsContent) {
		return Container(
			color: Colors.white,
			child: _tabBar,
		);
	}
	
	@override
	bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
		return false;
	}
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

