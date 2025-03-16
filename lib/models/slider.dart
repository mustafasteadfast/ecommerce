class SliderModel {
  final int id;
  final String? title;
  final String? subTitle;
  final String? link;
  final String status;
  final String fullImage;
  final String smallImage;

  SliderModel({
    required this.id,
    this.title,
    this.subTitle,
    this.link,
    required this.status,
    required this.fullImage,
    required this.smallImage,
  });

  factory SliderModel.fromJson(Map<String, dynamic> json) {
    return SliderModel(
      id: json['id'],
      title: json['title'],
      subTitle: json['sub_title'],
      link: json['link'],
      status: json['status'],
      fullImage: json['full_image'],
      smallImage: json['small_image'],
    );
  }
}

class SliderCategory {
  final String sliderType;
  final List<SliderModel> sliders;

  SliderCategory({
    required this.sliderType,
    required this.sliders,
  });

  factory SliderCategory.fromJson(Map<String, dynamic> json) {
    return SliderCategory(
      sliderType: json['slider_type'],
      sliders: (json['sliders'] as List)
          .map((slider) => SliderModel.fromJson(slider))
          .toList(),
    );
  }
}

class SliderResponse {
  final String message;
  final Map<String, SliderCategory> data;

  SliderResponse({
    required this.message,
    required this.data,
  });

  factory SliderResponse.fromJson(Map<String, dynamic> json) {
    Map<String, SliderCategory> sliderCategories = {};

    (json['data'] as Map<String, dynamic>).forEach((key, value) {
      sliderCategories[key] = SliderCategory.fromJson(value);
    });

    return SliderResponse(
      message: json['message'],
      data: sliderCategories,
    );
  }
}
