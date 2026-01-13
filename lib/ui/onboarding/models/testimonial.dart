class Testimonial {
  const Testimonial({
    required this.name,
    required this.timestamp,
    required this.rating,
    required this.quote,
  });

  final String name;
  final String timestamp;
  final int rating;
  final String quote;
}
