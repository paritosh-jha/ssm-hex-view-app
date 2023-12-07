import 'package:carousel_slider/carousel_slider.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:hex_view/screens/home/widgets/vehicle_info.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  final Map<String, String> vehicles;
  const HomeScreen({super.key, required this.vehicles});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text('Hex Zone'),
            expandedHeight: 50,
            floating: false,
            backgroundColor: Colors.white,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(FluentIcons.alert_16_filled),
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 20.0),
            sliver: SliverToBoxAdapter(
              child: CarouselSlider(
                carouselController: _controller,
                items: widget.vehicles.entries.map((vehicle) {
                  return Builder(builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade300,
                      ),
                      child: Center(
                        child: Text(
                          vehicle.key,
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ),
                    );
                  });
                }).toList(),
                options: CarouselOptions(
                    enableInfiniteScroll: false,
                    autoPlay: false,
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 9,
                    enlargeStrategy: CenterPageEnlargeStrategy.scale,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Center(
                child: AnimatedSmoothIndicator(
                  activeIndex: _current,
                  count: widget.vehicles.length,
                  effect: ExpandingDotsEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      activeDotColor: Colors.black87,
                      dotColor: Colors.grey.shade200),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: VehicleInfo(
                  vehicle: widget.vehicles.entries.elementAt(_current).key)),
        ],
      ),
    );
  }
}
