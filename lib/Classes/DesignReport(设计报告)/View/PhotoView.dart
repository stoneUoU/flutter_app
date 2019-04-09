import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef void OnBannerClickListener(int index, dynamic itemData);
typedef Widget BuildShowView(int index, dynamic itemData);

class PhotoView extends StatefulWidget {
	final OnBannerClickListener onBannerClickListener;
	final List data;
	final BuildShowView buildShowView;
	final ValueChanged<int> onPageChanged;
	
	PhotoView(
	  {Key key,
		  @required this.data,
		  @required this.buildShowView,
		  this.onBannerClickListener,
		  this.onPageChanged,})
	  : super(key: key);
	
	@override
	State<StatefulWidget> createState() => new PhotoViewState();
}

class PhotoViewState extends State<PhotoView> {
	
	var pageController;
	
	PhotoViewState() {
	
	}
	
	@override
	void initState() {
		super.initState();
		pageController = new PageController(initialPage: widget.data.length);
//		if (pageController.positions.isNotEmpty) {
//			var i = pageController.page.toInt() + 1;
//			pageController.animateToPage(i == widget.data.length ? 0 : i,
//			  duration: new Duration(milliseconds: widget.scrollTime),
//			  curve: Curves.linear);
//		}
	}
	
	@override
	Widget build(BuildContext context) {
		return new SizedBox(
		  child: widget.data.length == 0
			? null
			: new GestureDetector(
			  onTap: () {
				  widget.onBannerClickListener(pageController.page.round(),
					widget.data[pageController.page.round()]);
			  },
			  child: new PageView.builder(
				  controller: pageController,
				  onPageChanged: widget.onPageChanged,
				  physics: const PageScrollPhysics(parent: const ClampingScrollPhysics()),
				  itemBuilder: (BuildContext context, int index) {
					  return widget.buildShowView(index, widget.data[index]);
				  },
				  itemCount: widget.data.length,
			  ),
		  ));
	}
	
	@override
	void dispose() {
		super.dispose();
	}
}