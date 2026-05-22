class TermModel {
  final int? id;
  final String subject;
  final String english;
  final String kannada;
  final String explanation;

  TermModel({
    this.id,
    required this.subject,
    required this.english,
    required this.kannada,
    required this.explanation,
  });

  Map<String, dynamic> toMap() {
    return {
      'subject': subject,
      'english': english,
      'kannada': kannada,
      'explanation': explanation,
    };
  }

  factory TermModel.fromMap(Map<String, dynamic> map) {
    return TermModel(
      id: map['id'],
      subject: map['subject'],
      english: map['english'],
      kannada: map['kannada'],
      explanation: map['explanation'],
    );
  }
}