import "package:dio/dio.dart";
import 'dart:async';
import 'dart:io';

const serviceUrl= 'http://v.jspang.com:8088/baixing/';
//const serviceUrl= 'http://test.baixingliangfan.cn/baixing/';
const servicePath={
	'getMallGoods': serviceUrl+'wxmini/getMallGoods', //商品分类的商品列表
};

Future request(url,{formData})async{
	try{
		Response response;
		Dio dio = new Dio();
		dio.options.contentType=ContentType.parse("application/x-www-form-urlencoded");
		if(formData==null){
			
			response = await dio.post(servicePath[url]);
		}else{
			response = await dio.post(servicePath[url],data:formData);
		}
		print(servicePath[url]);
		if(response.statusCode==200){
			return response.data;
		}else{
			throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
		}
	}catch(e){
		return print('ERROR:======>${e}');
	}
	
}