
import 'package:flutter/material.dart';
import './Classes/Start(登录)/CustomerTabBarPage.dart';
import 'package:fluro/fluro.dart';
import 'package:provide/provide.dart';
import './Provider(状态管理)/Counter.dart';
import './Provider(状态管理)/Bloc_provider.dart';
import './Provider(状态管理)/LeftNaviProvider.dart';
import './Provider(状态管理)/RightGoodViewProvider.dart';
import './Routes(路由)/Routes.dart';
import './Application.dart';
import './Common/Util/LogUtil.dart';
import './Classes/GoodKinds(商品类别)/Model/KindMs.dart';

void main() {
	//Colors.red  Colors.blue   Colors.green
	//Color(STColors.white)
//	debugPaintSizeEnabled = true;      //打开视觉调试开关
	var counter = Counter(0);
	var leftNaviProvider = LeftNaviProvider(KindData());
	var rightGoodViewProvider = RightGoodViewProvider();
	final providers = Providers()
		..provide(Provider.function((context) => counter))
		..provide(Provider.function((context) => leftNaviProvider))
		..provide(Provider.function((context) => rightGoodViewProvider));
	Logger.root.level = Level.ALL; // defaults to Level.INFO
	Logger.root.onRecord.listen((record) {
		print('${record.level.name}: ${record.loggerName}: ${record.time}: ${record.message}');
	});
	runApp(ProviderNode(
		providers: providers,
		child: CustomerApp(),
	));
}

class CustomerApp extends StatelessWidget {
    // This widget is the root of your application.
	CustomerApp () {
		final router = new Router();
		Routes.configureRoutes(router);
		Application.router = router;
	}
    @override
    Widget build(BuildContext context) {
//		debugShowCheckedModeBanner: false, // 在调试期间，右上角的DEBUG字样
		final app = BlocProvider(
			child: MaterialApp(
			  title: 'Wifi伴侣',
			  debugShowCheckedModeBanner: false,  // 设置这一属性即可
				onGenerateRoute: Application.router.generator,
			  home:CustomerTabBarPage.getInstance(),
			)
		);
		return app;
    }
}
