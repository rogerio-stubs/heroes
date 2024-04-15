class HeroesDto {
  HeroesDto({
    required this.name,
    required this.image,
    required this.series,
    required this.events,
    });

  final String name;
  final String image;
  final List<String> series;
  final List<String> events;


  factory HeroesDto.fromJson(Map<String, dynamic> json) => HeroesDto(
    name: json['name'],
    image: json['thumbnail']['path'] + '.' + json['thumbnail']['extension'],
    series: List<String>.from(json['series']['items'].map((x) => x['name'])),
    events: List<String>.from(json['events']['items'].map((x) => x['name'])),
  );
}
  