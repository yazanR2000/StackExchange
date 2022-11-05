import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class QuestionImages extends StatefulWidget {
  final List<dynamic> _images;
  QuestionImages(this._images);
  @override
  State<QuestionImages> createState() => _QuestionImagesState();
}

class _QuestionImagesState extends State<QuestionImages> {
  final CarouselController _controller = CarouselController();
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CarouselSlider.builder(
            itemCount: widget._images.length,
            itemBuilder: (context, index, realIndex) {
              return InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: ((context) {
                      return Dialog(
                        insetPadding: EdgeInsets.zero,
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        child: InteractiveViewer(
                          child: Container(
                            height: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image(
                                image: NetworkImage(
                                  widget._images[index],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    //color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(widget._images[index]),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              );
            },
            carouselController: _controller,
            options: CarouselOptions(
                enableInfiniteScroll: false,
                autoPlay: false,
                enlargeCenterPage: true,
                aspectRatio: 1.5,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget._images.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 12.0,
                height: 12.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (_current == entry.key ? Colors.black : Colors.grey)
                        .withOpacity(_current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
