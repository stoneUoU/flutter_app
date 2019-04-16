
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_app/Macros.dart';
import '../Model/CarouselMs.dart';

class HomeBannerView extends StatefulWidget {
	List<CarouselChildMs> carouselChildMs;
	HomeBannerView({Key key, this.carouselChildMs}) : super(key: key);
	@override
	_HomeBannerView createState() => _HomeBannerView();
}

class _HomeBannerView extends State<HomeBannerView> {
	Widget build (BuildContext context) {
		return Container (
			width: Macros.ScreenW (context),
			height: 160,
			child: Swiper (
				itemBuilder: (BuildContext context, int index) {
					return new FadeInImage.assetNetwork(
						placeholder: "assets/images/placeSite.jpg",
						fadeInDuration: const Duration(seconds: 1),
						// 持续时间，默认 700 ms
						image: "${widget.carouselChildMs[index].imagePath
						  .toString ()}",
						fit: BoxFit.cover,
					);
				},
				duration:5,
				autoplay: true,
				itemCount: widget.carouselChildMs.length == 0 ? 0 :widget.carouselChildMs.length,
				loop: true,
				pagination: new SwiperPagination(
					alignment: Alignment.bottomRight
				),
			),
		);
	}
}