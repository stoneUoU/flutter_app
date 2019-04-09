
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../Model/RainBowHomeRotationMs.dart';
import 'package:flutter_app/Macros.dart';

class SwiperView extends StatefulWidget {
	List dataList = [];
	SwiperView({Key key, this.dataList}) : super(key: key);
	@override
	_SwiperView createState() => _SwiperView();
}

class _SwiperView extends State<SwiperView> {
	Widget build(BuildContext context) {
		return Container(
			width: Macros.ScreenW(context),
			height: 175,
			child: Swiper(
				itemBuilder: (BuildContext context, int index) {
					NewBannerList newBannerList = widget.dataList[index];
					return new FadeInImage.assetNetwork(
						placeholder: "assets/images/placeSite.jpg",
						fadeInDuration: const Duration(seconds: 1), // 持续时间，默认 700 ms
						image: "${newBannerList.imgUrl.toString()}",
						fit: BoxFit.cover,
					);
				},
				autoplay: true,
				itemCount: widget.dataList.length,
				loop: true,
				pagination: new SwiperPagination(),
			),
		);
	}
}