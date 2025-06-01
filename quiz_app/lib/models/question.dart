class Question {
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;

  Question({
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
  });
}

// Sample quiz data
class QuizData {
  static List<Question> getQuestions() {
    return [
      Question(
        questionText: "What is the capital of France?",
        options: ["London", "Berlin", "Paris", "Madrid"],
        correctAnswerIndex: 2,
      ),
      Question(
        questionText: "Which planet is known as the Red Planet?",
        options: ["Venus", "Mars", "Jupiter", "Saturn"],
        correctAnswerIndex: 1,
      ),
      Question(
        questionText: "What is 2 + 2?",
        options: ["3", "4", "5", "6"],
        correctAnswerIndex: 1,
      ),
      Question(
        questionText: "Who painted the Mona Lisa?",
        options: ["Van Gogh", "Picasso", "Da Vinci", "Monet"],
        correctAnswerIndex: 2,
      ),
      Question(
        questionText: "What is the largest ocean on Earth?",
        options: ["Atlantic", "Indian", "Arctic", "Pacific"],
        correctAnswerIndex: 3,
      ),
      Question(
        questionText: "Which programming language is Flutter based on?",
        options: ["Java", "Dart", "Python", "JavaScript"],
        correctAnswerIndex: 1,
      ),
      Question(
        questionText: "What year did World War II end?",
        options: ["1944", "1945", "1946", "1947"],
        correctAnswerIndex: 1,
      ),
      Question(
        questionText: "Which is the smallest country in the world?",
        options: ["Monaco", "Vatican City", "San Marino", "Liechtenstein"],
        correctAnswerIndex: 1,
      ),
    ];
  }
}
