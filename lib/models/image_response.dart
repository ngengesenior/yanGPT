class GeneratedImagesResponse {
  int? created;
  List<Url>? data;

  GeneratedImagesResponse({this.created, this.data});

  factory GeneratedImagesResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> dataJson = json['data'] ?? [];

    List<Url> data = dataJson.map((e) => Url.fromJson(e)).toList();

    return GeneratedImagesResponse(
      created: json['created'] ?? 0,
      data: data,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['created'] = created;
    data['data'] = this.data?.map((e) => e?.toJson())?.toList() ?? [];

    return data;
  }
}

class Url {
  String? url;

  Url({this.url});

  factory Url.fromJson(Map<String, dynamic> json) {
    return Url(
      url: json['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['url'] = url;

    return data;
  }
}
