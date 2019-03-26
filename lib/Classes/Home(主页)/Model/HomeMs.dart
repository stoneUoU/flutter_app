class HomeMs {
	
//	{
//	"reportId":8,
//	"cover":"http://tu.chdesign.cn/test/upload/match/20180727/84763ae0e3d64467b23304136f84634b.jpg?x-oss-process=image/resize,m_fill,h_530,w_750,limit_0",
//	"title":"测试3",
//	"description":"Stone",
//	"salePrice":123213
//	}
	
	
	int reportId;
	String cover;
	String title;
	String description;
	String salePrice;
	
	HomeMs({this.reportId, this.cover, this.title, this.description, this.salePrice});
	
	HomeMs.fromJSON(Map json)
	    :   reportId = json['reportId'],
		    cover = json['cover'],
		    title = json['title'],
		    description = json['description'],
		    salePrice = json['salePrice'];
	
	Map toMap() {
		return {
			'reportId': reportId,
			'cover': cover,
			'title': title,
			'description': description,
			'salePrice': salePrice
		};
	}
}