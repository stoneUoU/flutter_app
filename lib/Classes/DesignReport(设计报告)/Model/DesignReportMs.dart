class DesignReportMs {

//	{
//		reportId: 8,
//		cover: "http://tu.chdesign.cn//test/upload/match/20180727/18cc1a79656d40b7b3dfe1e36914b144.jpg?x-oss-process=image/resize,m_fill,h_530,w_750,limit_0",
//		title: "2019春夏欧洲童装趋势分析报告分析报告分析报告分析报告",
//		subTitle: "金牌设计通会员专",
//		salesPrice: 5000,
//		price: 8000,
//		description: "透明色与绚丽彩色的PVC，带有橡胶感的磨砂雨衣PVC，都是各大时装品牌以面料的形式运用到包款设计上，作为时尚未来的新兴趋势。 在本季韩国商拍中PVC以多种形式出现，带来款式繁多的透明材质包款",
//		content: "<p style='text-align:left;'><img src='http://tu.chdesign.cn/test/pics/activity/2018/07/27/fe2caf6a106f47ee9c677426d0167a87.jpg' alt='' /></p>"
//	}
	
	int reportId;
	String cover;
	String title;
	String subTitle;
	String salesPrice;
	String price;
	String description;
	String content;
	
	DesignReportMs({this.reportId, this.cover, this.title, this.subTitle, this.salesPrice, this.price, this.description, this.content});
	
	DesignReportMs.fromJSON(Map json)
	  :   reportId = json['reportId'],
		  cover = json['cover'],
		  title = json['title'],
		  subTitle = json['subTitle'],
		  salesPrice = json['salesPrice'],
		  price = json['price'],
		  description = json['description'],
		  content = json['content'];
	
	Map toMap() {
		return {
			'reportId': reportId,
			'cover': cover,
			'title': title,
			'subTitle': subTitle,
			'salesPrice': salesPrice,
			'price': price,
			'description': description,
			'content': content
		};
	}
}