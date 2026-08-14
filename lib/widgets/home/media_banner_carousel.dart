import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

enum MediaType { image, video }

class MediaBannerItem {
  final MediaType type;
  final String path; // asset path — images/xyz.png OR videos/xyz.mp4

  const MediaBannerItem({required this.type, required this.path});
}

class MediaBannerCarousel extends StatelessWidget {
  final List<MediaBannerItem> items;
  final double height;

  const MediaBannerCarousel({
    Key? key,
    required this.items,
    this.height = 220,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: CarouselSlider(
        options: CarouselOptions(
          height: height,
          viewportFraction: 1.0,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 5),
          enlargeCenterPage: false,
        ),
        items: items.map((item) {
          return SizedBox(
            width: double.infinity,
            height: height, // yehi carousel ka height parameter
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: item.type == MediaType.image
                    ? _ImageSlide(path: item.path)
                    : _VideoSlide(path: item.path),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _ImageSlide extends StatelessWidget {
  final String path;
  const _ImageSlide({required this.path});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }
}

class _VideoSlide extends StatefulWidget {
  final String path;
  const _VideoSlide({required this.path});

  @override
  State<_VideoSlide> createState() => _VideoSlideState();
}

class _VideoSlideState extends State<_VideoSlide> {
  late VideoPlayerController _controller;
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.path)
      ..initialize().then((_) {
        if (!mounted) return;
        setState(() => _ready = true);
        _controller
          ..setLooping(true)
          ..setVolume(0) // muted autoplay
          ..play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready) {
      return Container(
        color: Colors.grey.shade200,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    // Poore available rectangle (carousel height x full width) ko force fill karo
    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.cover,
        clipBehavior: Clip.hardEdge, // extra safety, ClipRRect already hai upar
        child: SizedBox(
          width: _controller.value.size.width,
          height: _controller.value.size.height,
          child: VideoPlayer(_controller),
        ),
      ),
    );
  }
}
