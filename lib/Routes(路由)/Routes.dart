import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import './Route_handlers.dart';

class Routes {
	static String root = "/";
	static String designView = "/designReportView/designReportView";
	static String designDetailView = "/designReportView/designReportDetailView";
	static String goodDetailView = "/goodKindsView/goodDetailView";
	
	static void configureRoutes(Router router) {
		router.notFoundHandler = new Handler(
		  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
			  print("ROUTE WAS NOT FOUND !!!");
		  });
		router.define(root, handler: rootHandler);
		router.define(designView, handler: designReportViewHandler);
		router.define(designDetailView, handler: designReportDetailViewHandler);
		router.define(goodDetailView, handler: goodDetailViewHandler);
	}
}