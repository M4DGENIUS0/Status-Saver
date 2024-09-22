class FBDownloader {
  bool? success;
  int? parser; // Fixes the typo "praser"
  String? version;
  String? title;
  String? thumbnail;
  String? url;
  Links? links;
  List<Media>? media;

  FBDownloader(
      {this.success,
      this.parser, // Fixed
      this.version,
      this.title,
      this.thumbnail,
      this.url,
      this.links,
      this.media});

  FBDownloader.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    parser = json['parser']; // Fixed
    version = json['version'];
    title = json['title'];
    thumbnail = json['thumbnail'];
    url = json['url'];
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
    if (json['media'] != null) {
      media = json['media'].map<Media>((v) => Media.fromJson(v)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['parser'] = parser; // Fixed
    data['version'] = version;
    data['title'] = title;
    data['thumbnail'] = thumbnail;
    data['url'] = url;
    if (links != null) {
      data['links'] = links!.toJson();
    }
    if (media != null) {
      data['media'] = media!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Links {
  String? downloadLowQuality;
  String? downloadHighQuality;

  Links({this.downloadLowQuality, this.downloadHighQuality});

  Links.fromJson(Map<String, dynamic> json) {
    downloadLowQuality = json['Download Low Quality'];
    downloadHighQuality = json['Download High Quality'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Download Low Quality'] = downloadLowQuality;
    data['Download High Quality'] = downloadHighQuality;
    return data;
  }
}

class Media {
  String? id;
  String? jsp;
  String? type;
  String? image;
  String? sdUrl;
  String? hdUrl;
  int? width;
  int? height;

  Media(
      {this.id,
      this.jsp,
      this.type,
      this.image,
      this.sdUrl,
      this.hdUrl,
      this.width,
      this.height});

  Media.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jsp = json['jsp'];
    type = json['type'];
    image = json['image'];
    sdUrl = json['sd_url'];
    hdUrl = json['hd_url'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['jsp'] = jsp;
    data['type'] = type;
    data['image'] = image;
    data['sd_url'] = sdUrl;
    data['hd_url'] = hdUrl;
    data['width'] = width;
    data['height'] = height;
    return data;
  }
}
