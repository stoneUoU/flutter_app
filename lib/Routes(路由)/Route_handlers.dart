import '../Classes/Home(主页)/Controller/HomeViewController.dart';
import '../Classes/DesignReport(设计报告)/Controller/DesignReportViewController.dart';
import '../Classes/DesignReport(设计报告)/Controller/DesignReportDetailViewController.dart';
import '../Classes/GoodKinds(商品类别)/Controller/GoodDetailViewController.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

var rootHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
	  return new HomeViewController();
  });

var designReportDetailViewHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  	print("${json.decode(params["data"][0])["reportId"]}");
	  int reportId = int.parse("${json.decode(params["data"][0])["reportId"]}");
	  return new DesignReportDetailViewController(
		reportId: reportId,);
  });


var designReportViewHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
	  return new DesignReportViewController();
  });


var goodDetailViewHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
	  print("${json.decode(params["data"][0])["goodId"]}");
	  String goodId = "${json.decode(params["data"][0])["goodId"]}";
	  return new GoodDetailViewController(
		  goodId: goodId);
  });