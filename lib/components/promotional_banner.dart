import 'package:ecommerce/blocs/combine/combine_state.dart';
import 'package:ecommerce/blocs/slider/slider_bloc.dart';
import 'package:ecommerce/blocs/slider/slider_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/models/slider.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:url_launcher/url_launcher.dart';
// Uncomment if using cached_network_image:
// import 'package:cached_network_image/cached_network_image.dart';

class PromotionalBanner extends StatefulWidget {
  final String sliderType;
  final double height;
  final double borderRadius;
  final EdgeInsets padding;

  const PromotionalBanner({
    super.key,
    required this.sliderType,
    this.height = 180,
    this.borderRadius = 8,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  });

  @override
  State<PromotionalBanner> createState() => _PromotionalBannerState();
}

class _PromotionalBannerState extends State<PromotionalBanner> {
  int _currentIndex = 0;

  // Removed initState since FetchSliders is triggered in BlocProvider
  // @override
  // void initState() {
  //   super.initState();
  //   context.read<SliderBloc>().add(FetchSliders());
  // }

  void _openLink(String? url) async {
    if (url != null && url.isNotEmpty) {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SliderBloc, CombineState>(
      builder: (context, state) {
        if (state is CombineLoading) {
          return SizedBox(
            height: widget.height,
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        if (state is CombineError) {
          return SizedBox(
            height: widget.height,
            child: Center(child: Text(state.message)),
          );
        }

        if (state is CombineLoaded) {
          final sliderResponse = state.response;

          // Find the slider category that matches the requested type
          SliderCategory? category;
          for (var entry in sliderResponse.data.entries) {
            if (entry.value.sliderType == widget.sliderType) {
              category = entry.value;
              break;
            }
          }

          if (category == null || category.sliders.isEmpty) {
            return SizedBox(
              height: widget.height,
              child: Center(
                child: Text('No banners available for ${widget.sliderType}'),
              ),
            );
          }

          return Padding(
            padding: widget.padding,
            child: Stack(
              children: [
                FlutterCarousel(
                  items: category.sliders.map((slider) {
                    return Builder(
                      builder: (BuildContext context) {
                        return GestureDetector(
                          onTap: () => _openLink(slider.link),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(widget.borderRadius),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(widget.borderRadius),
                              child: Image.network(
                                slider.fullImage,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey[300],
                                    child: const Center(
                                      child: Icon(Icons.error_outline, size: 40),
                                    ),
                                  );
                                },
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Container(
                                    color: Colors.grey[200],
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              // Optional: Use CachedNetworkImage instead (uncomment if added)
                              // child: CachedNetworkImage(
                              //   imageUrl: slider.fullImage,
                              //   fit: BoxFit.cover,
                              //   placeholder: (context, url) => Container(
                              //     color: Colors.grey[200],
                              //     child: const Center(child: CircularProgressIndicator()),
                              //   ),
                              //   errorWidget: (context, url, error) => Container(
                              //     color: Colors.grey[300],
                              //     child: const Center(child: Icon(Icons.error_outline, size: 40)),
                              //   ),
                              // ),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: widget.height,
                    viewportFraction: 1.0,
                    enlargeCenterPage: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 5),
                    showIndicator: false,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: category.sliders.asMap().entries.map((entry) {
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentIndex == entry.key
                              ? Colors.white
                              : Colors.white.withOpacity(0.5),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          );
        }

        // Default case (SliderInitial)
        return SizedBox(
          height: widget.height,
          child: const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}