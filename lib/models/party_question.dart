class PartyQuestion {
  final int? id;
  final String text;

  PartyQuestion({this.id, required this.text});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
    };
  }

  factory PartyQuestion.fromMap(Map<String, dynamic> map) {
    return PartyQuestion(
      id: map['id'],
      text: map['text'],
    );
  }
}
