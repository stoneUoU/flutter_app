import 'dart:convert';

class RainBowHomeListMs {
	List<Rs> rs;
	int updateCount;
	
	RainBowHomeListMs({this.rs, this.updateCount});
	
	RainBowHomeListMs.fromJson(Map<String, dynamic> json) {
		
		if (json['rs'] != null) {
			rs = new List<Rs>();
			json['rs'].forEach((v) {
				rs.add(new Rs.fromJson(v));
			});
		}
		updateCount = json['UpdateCount'];
	}
	
	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.rs != null) {
			data['rs'] = this.rs.map((v) => v.toJson()).toList();
		}
		data['UpdateCount'] = this.updateCount;
		return data;
	}
}

class Rs {
	String bigImg;
	int imgHeight;
	int imgWidth;
	String time;
	String title;
	String priceUnit;
	String url;
	bool sex;
	int hits;
	String cateName;
	String city;
	List listImg;
	String headImage;
	int type;
	int budget;
	bool isAccessible;
	String mostFields;
	String userName;
	String content;
	int dataID;
	
	Rs(
	  {this.bigImg,
		  this.imgHeight,
		  this.imgWidth,
		  this.time,
		  this.title,
		  this.priceUnit,
		  this.url,
		  this.sex,
		  this.hits,
		  this.cateName,
		  this.city,
		  this.listImg,
		  this.headImage,
		  this.type,
		  this.budget,
		  this.isAccessible,
		  this.mostFields,
		  this.userName,
		  this.content,
		  this.dataID});
	
	Rs.fromJson(Map<String, dynamic> json) {
		bigImg = json['bigImg'] != null ? json['bigImg']:"";
		imgHeight = json['imgHeight'];
		imgWidth = json['imgWidth'];
		time = json['time'] != null ? json['time'] :"";
		title = json['title'] != null ? json['title'] :"";
		priceUnit = json['priceUnit'] != null ? json['priceUnit'] :"";
		url = json['url'] != null ? json['url'] :"";
		sex = json['sex'] != null ? json['sex'] :false;
		hits = json['hits'] != null ? json['hits'] : 0;
		cateName = json['cateName'] != null ? json['cateName'] :"";
		city = json['city'] != null ? json['city'] :"";
		listImg = json['listImg'] != null ? json['listImg'] :[];
		headImage = json['headImage'] != null ? json['headImage'] :"";
		type = json['type'];
		budget = json['Budget'] != null ? json['Budget'] :0;
		isAccessible = json['isAccessible'] != null ? json['isAccessible'] :false;
		mostFields = json['mostFields']!= null ? json['mostFields'] :"";
		userName = json['userName']!= null ? json['userName'] :"";
		content = json['content']!= null ? json['content'] :"";
		dataID = json['dataID'];
	}
	
	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['bigImg'] = this.bigImg;
		data['imgHeight'] = this.imgHeight;
		data['imgWidth'] = this.imgWidth;
		data['time'] = this.time;
		data['title'] = this.title;
		data['priceUnit'] = this.priceUnit;
		data['url'] = this.url;
		data['sex'] = this.sex;
		data['hits'] = this.hits;
		data['cateName'] = this.cateName;
		data['city'] = this.city;
		data['listImg'] = this.listImg;
		data['headImage'] = this.headImage;
		data['type'] = this.type;
		data['Budget'] = this.budget;
		data['isAccessible'] = this.isAccessible;
		data['mostFields'] = this.mostFields;
		data['userName'] = this.userName;
		data['content'] = this.content;
		data['dataID'] = this.dataID;
		return data;
	}
}