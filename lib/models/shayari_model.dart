class ShayariModel {
  final String id;
  final String text;
  final String authorName;
  final String category; // e.g., 'Love', 'Sad', 'Attitude', 'Motivation'
  int likesCount;
  bool isLiked;

  ShayariModel({
    required this.id,
    required this.text,
    required this.authorName,
    required this.category,
    this.likesCount = 0,
    this.isLiked = false,
  });
}

