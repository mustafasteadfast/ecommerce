import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ecommerce/models/slider.dart';

class SliderService {
  static const String baseUrl = 'http://143.198.199.41:9999';
  static const String slidersEndpoint = '/api/v1/sliders';

  Future<SliderResponse> getSliders() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl$slidersEndpoint'));

      if (response.statusCode == 200) {
        return SliderResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load sliders: ${response.statusCode}');
      }
    } catch (e) {
      return _getMockSliderResponse();
    }
  }

// API DATA
  SliderResponse _getMockSliderResponse() {
    final mockJson = {
      "message": "Sliders showed successfully",
      "data": {
        "2": {
          "slider_type": "Slider Shop",
          "sliders": [
            {
              "id": 8,
              "title": null,
              "sub_title": null,
              "link": null,
              "status": "active",
              "full_image":
                  "http://143.198.199.41:9999/storage/media/QIaJ2U6LNlNOMiOp8ACJPGNo637lZG7FJnWZsviN.png",
              "small_image":
                  "http://143.198.199.41:9999/storage/media/0HO3swfAsJr0FNcIZWJNWOnoz4raYs2dHmrIw94J.png"
            },
            {
              "id": 9,
              "title": null,
              "sub_title": null,
              "link": null,
              "status": "active",
              "full_image":
                  "http://143.198.199.41:9999/storage/media/vJfoF3NLFCrpfFmyKwRSYnbhYohaD18f2P4TWs4K.png",
              "small_image":
                  "http://143.198.199.41:9999/storage/media/cFkzAoucxB06ClI6pAGh8jdTyvV3OXwsx4lz4jtC.png"
            },
            {
              "id": 10,
              "title": null,
              "sub_title": null,
              "link": "https://www.daraz.com.bd/#?sssss",
              "status": "active",
              "full_image":
                  "http://143.198.199.41:9999/storage/media/Yeak1VD3Cq7NqIAWBpEPtiDVAYG9ovAy3lbB9gHn.png",
              "small_image":
                  "http://143.198.199.41:9999/storage/media/HGqToMrwmq7AJGD2CGeCATkoOnGiIlrOpFKgdh0l.jpg"
            }
          ]
        }
      }
    };

    return SliderResponse.fromJson(mockJson);
  }
}
