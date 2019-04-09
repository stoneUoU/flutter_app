/*
 * Created by Stone on 2019/01/10.
 * email: stoneUoU@163.com
 * 网络请求封装
 */
import 'dart:io';
import 'package:dio/dio.dart';

import 'package:flutter_app/Macros.dart';

class NetTools {
	static NetTools instance;
	Dio dio;
	Options options;
	
	static NetTools getInstance() {
		print('getInstance');
		if (instance == null) {
			instance = new NetTools();
		}
		return instance;
	}
	
	NetTools() {
		// 或者通过传递一个 `options`来创建dio实例
		options = Options(
			// 请求基地址,可以包含子路径，如: "https://www.google.com/api/".
//			baseUrl: "https://app.shop.znrmny.com/api/ggshop/member/v5/",
			baseUrl: Macros.CMarketUrl,
			//连接服务器超时时间，单位是毫秒.
			connectTimeout: 10000,
			
			///  响应流上前后两次接受到数据的间隔，单位为毫秒。如果两次间隔超过[receiveTimeout]，
			///  [Dio] 将会抛出一个[DioErrorType.RECEIVE_TIMEOUT]的异常.
			///  注意: 这并不是接收数据的总时限.
			receiveTimeout: 3000,
			headers: {
				HttpHeaders.acceptHeader:"accept: application/json",
			},
		);
		dio = new Dio(options);
	}
	
	get(url, {authosStr, data, options, cancelToken}) async {
		Response response;
		dio.options.headers["token"] = authosStr;
		try {
			response = await dio.get(
				url,
				data: data,
				cancelToken: cancelToken,
			);
		} on DioError catch (e) {
			if (CancelToken.isCancel(e)) {
				print('get请求取消! ' + e.message);
			}
			print('get请求发生错误：$e');
		}
		return response.data;
	}
	
	post(url, {authosStr, data, options, cancelToken}) async {
		Response response;
		dio.options.headers["token"] = authosStr;
		try {
			response = await dio.post(
				url,
				data: data,
				cancelToken: cancelToken,
			);
		} on DioError catch (e) {
			if (CancelToken.isCancel(e)) {
				print('post请求取消! ' + e.message);
			}
			print('post请求发生错误：$e');
		}
		return response.data;
	}
}

