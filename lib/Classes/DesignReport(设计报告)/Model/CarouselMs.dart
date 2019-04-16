import 'dart:convert' show json;


class CarouselMs {
	
	int errorCode;
	String errorMsg;
	List<CarouselChildMs> data;
	
	
	CarouselMs.fromParams({this.errorCode, this.errorMsg, this.data});
	
	factory CarouselMs(jsonStr) => jsonStr is String ? CarouselMs.fromJson(json.decode(jsonStr)) : CarouselMs.fromJson(jsonStr);
	
	CarouselMs.fromJson(jsonRes) {
		errorCode = jsonRes['errorCode'];
		errorMsg = jsonRes['errorMsg'];
		data = [];
		for (var dataItem in jsonRes['data']) {
			data.add (new CarouselChildMs.fromJson(dataItem));
		}
	}
	
	@override
	String toString() {
		return '{"errorCode": $errorCode,"errorMsg": ${errorMsg != null?'${json.encode(errorMsg)}':'null'},"data": $data}';
	}
}



class CarouselChildMs {
	
	int id;
	int isVisible;
	int order;
	int type;
	String desc;
	String imagePath;
	String title;
	String url;
	
	
	CarouselChildMs.fromParams({this.id, this.isVisible, this.order, this.type, this.desc, this.imagePath, this.title, this.url});
	
	CarouselChildMs.fromJson(jsonRes) {
		id = jsonRes['id'];
		isVisible = jsonRes['isVisible'];
		order = jsonRes['order'];
		type = jsonRes['type'];
		desc = jsonRes['desc'];
		imagePath = jsonRes['imagePath'];
		title = jsonRes['title'];
		url = jsonRes['url'];
		
	}
	
	@override
	String toString() {
		return '{"id": $id,"isVisible": $isVisible,"order": $order,"type": $type,"desc": ${desc != null?'${json.encode(desc)}':'null'},"imagePath": ${imagePath != null?'${json.encode(imagePath)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'},"url": ${url != null?'${json.encode(url)}':'null'}}';
	}
}
