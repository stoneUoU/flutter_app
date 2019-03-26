class NoticeMs {
	int reportId;
	String cover;
	String title;
	String description;
	String salePrice;
	
	NoticeMs(
	  {this.reportId,
		  this.cover,
		  this.title,
		  this.description,
		  this.salePrice});
	
	NoticeMs.fromJson(Map<String, dynamic> json) {
		reportId = json['reportId'];
		cover = json['cover'];
		title = json['title'];
		description = json['description'];
		salePrice = json['salePrice'];
	}
	
	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['reportId'] = this.reportId;
		data['cover'] = this.cover;
		data['title'] = this.title;
		data['description'] = this.description;
		data['salePrice'] = this.salePrice;
		return data;
	}
}