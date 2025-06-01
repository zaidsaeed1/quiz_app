import 'package:flutter/material.dart';
import '../models/question.dart';
import 'home_screen.dart';

class ResultScreen extends StatefulWidget {
  final int score;
  final int totalQuestions;
  final List<Question> questions;
  final List<int?> selectedAnswers;

  const ResultScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
    required this.questions,
    required this.selectedAnswers,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen>
    with TickerProviderStateMixin {
  late AnimationController _scoreAnimationController;
  late AnimationController _detailsAnimationController;
  late Animation<double> _scoreAnimation;
  late Animation<double> _detailsAnimation;

  @override
  void initState() {
    super.initState();
    _scoreAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _detailsAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scoreAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _scoreAnimationController,
        curve: Curves.elasticOut,
      ),
    );

    _detailsAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _detailsAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _scoreAnimationController.forward();
    Future.delayed(const Duration(milliseconds: 500), () {
      _detailsAnimationController.forward();
    });
  }

  @override
  void dispose() {
    _scoreAnimationController.dispose();
    _detailsAnimationController.dispose();
    super.dispose();
  }

  String _getResultMessage() {
    double percentage = (widget.score / widget.totalQuestions) * 100;
    if (percentage >= 90) return "Excellent! 🏆";
    if (percentage >= 70) return "Good Job! 👏";
    if (percentage >= 50) return "Not Bad! 👍";
    return "Keep Trying! 💪";
  }

  Color _getResultColor() {
    double percentage = (widget.score / widget.totalQuestions) * 100;
    if (percentage >= 70) return Colors.green;
    if (percentage >= 50) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [_getResultColor().withOpacity(0.1), Colors.white],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Score section
              Expanded(
                flex: 2,
                child: Center(
                  child: ScaleTransition(
                    scale: _scoreAnimation,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _getResultMessage(),
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: _getResultColor(),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _getResultColor(),
                            boxShadow: [
                              BoxShadow(
                                color: _getResultColor().withOpacity(0.3),
                                blurRadius: 20,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${widget.score}',
                                  style: const TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'out of ${widget.totalQuestions}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '${((widget.score / widget.totalQuestions) * 100).round()}% Correct',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Details section
              Expanded(
                flex: 3,
                child: FadeTransition(
                  opacity: _detailsAnimation,
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Review Answers:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: ListView.builder(
                            itemCount: widget.questions.length,
                            itemBuilder: (context, index) {
                              final question = widget.questions[index];
                              final selectedAnswer =
                                  widget.selectedAnswers[index];
                              final isCorrect =
                                  selectedAnswer == question.correctAnswerIndex;

                              return Card(
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor:
                                        isCorrect ? Colors.green : Colors.red,
                                    child: Icon(
                                      isCorrect ? Icons.check : Icons.close,
                                      color: Colors.white,
                                    ),
                                  ),
                                  title: Text(
                                    'Q${index + 1}: ${question.questionText}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (selectedAnswer != null)
                                        Text(
                                          'Your answer: ${question.options[selectedAnswer]}',
                                          style: TextStyle(
                                            color:
                                                isCorrect
                                                    ? Colors.green
                                                    : Colors.red,
                                          ),
                                        ),
                                      if (!isCorrect)
                                        Text(
                                          'Correct: ${question.options[question.correctAnswerIndex]}',
                                          style: const TextStyle(
                                            color: Colors.green,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Action buttons
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                          (route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      child: const Text('Take Quiz Again'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
