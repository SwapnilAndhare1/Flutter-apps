import React, { useState, useEffect } from 'react';
import { Clock, AlertCircle, Trophy, Flower2 } from 'lucide-react';
import { Test, Question, StudentAnswer, TestResult } from '../../types';
import { useAuth } from '../../contexts/AuthContext';
import { calculateTestScore, saveTestResult } from '../../utils/database';

interface TestInterfaceProps {
  test: Test;
  onFinish: () => void;
}

const TestInterface: React.FC<TestInterfaceProps> = ({ test, onFinish }) => {
  const { user } = useAuth();
  const [currentQuestion, setCurrentQuestion] = useState(0);
  const [answers, setAnswers] = useState<{ [key: number]: number }>({});
  const [selectedOption, setSelectedOption] = useState<number | null>(null);
  const [showResult, setShowResult] = useState(false);
  const [testResult, setTestResult] = useState<TestResult | null>(null);
  const [timeLeft, setTimeLeft] = useState(test.total_questions * 90); // 1.5 minutes per question

  // Timer effect
  useEffect(() => {
    const timer = setInterval(() => {
      setTimeLeft(prev => {
        if (prev <= 1) {
          handleFinishTest();
          return 0;
        }
        return prev - 1;
      });
    }, 1000);

    return () => clearInterval(timer);
  }, []);

  // Update selected option when moving between questions
  useEffect(() => {
    const currentQuestionId = test.questions[currentQuestion]?.id!;
    setSelectedOption(answers[currentQuestionId] || null);
  }, [currentQuestion, answers]);

  /**
   * Handle option selection
   */
  const handleOptionSelect = (optionNumber: number) => {
    const questionId = test.questions[currentQuestion].id!;
    setSelectedOption(optionNumber);
    setAnswers(prev => ({
      ...prev,
      [questionId]: optionNumber
    }));
  };

  /**
   * Move to next question
   */
  const handleNext = () => {
    if (currentQuestion < test.questions.length - 1) {
      setCurrentQuestion(prev => prev + 1);
    } else {
      handleFinishTest();
    }
  };

  /**
   * Finish the test and calculate results
   */
  const handleFinishTest = () => {
    const scoreData = calculateTestScore(test.questions, answers);
    
    // Create student answers array
    const studentAnswers: StudentAnswer[] = test.questions.map(question => ({
      question_id: question.id!,
      selected_option: answers[question.id!] || 0,
      is_correct: answers[question.id!] === question.correct_option
    }));

    // Create test result
    const result: TestResult = {
      id: `result_${Date.now()}`,
      student_id: user!.id,
      test_id: test.id,
      score: scoreData.score,
      total_questions: test.questions.length,
      percentage: scoreData.percentage,
      answers: studentAnswers,
      completed_at: new Date().toISOString()
    };

    // Save result to database
    saveTestResult(result);
    setTestResult(result);
    setShowResult(true);
  };

  /**
   * Format time display
   */
  const formatTime = (seconds: number) => {
    const minutes = Math.floor(seconds / 60);
    const remainingSeconds = seconds % 60;
    return `${minutes}:${remainingSeconds.toString().padStart(2, '0')}`;
  };

  // Show result screen
  if (showResult && testResult) {
    const isPassed = testResult.percentage >= 35;
    
    return (
      <div className="min-h-screen bg-gradient-to-br from-blue-50 to-green-50 flex items-center justify-center p-4">
        <div className="bg-white rounded-2xl p-8 shadow-2xl max-w-md w-full text-center">
          {/* Result Icon */}
          <div className="mb-6">
            {isPassed ? (
              <div className="inline-flex items-center justify-center w-20 h-20 bg-yellow-100 rounded-full mb-4">
                <Trophy className="w-10 h-10 text-yellow-600" />
              </div>
            ) : (
              <div className="inline-flex items-center justify-center w-20 h-20 bg-red-100 rounded-full mb-4">
                <Flower2 className="w-10 h-10 text-red-600" />
              </div>
            )}
          </div>

          {/* Result Title */}
          <h2 className="text-2xl font-bold text-gray-800 mb-2">
            {isPassed ? 'Congratulations!' : 'Better Luck Next Time!'}
          </h2>
          
          <p className="text-gray-600 mb-6">
            {isPassed 
              ? 'You have successfully passed the test!'
              : 'You need at least 35% to pass. Keep practicing!'
            }
          </p>

          {/* Score Details */}
          <div className="bg-gray-50 rounded-lg p-4 mb-6">
            <div className="grid grid-cols-2 gap-4 text-center">
              <div>
                <p className="text-2xl font-bold text-blue-600">{testResult.score}</p>
                <p className="text-sm text-gray-600">Correct Answers</p>
              </div>
              <div>
                <p className="text-2xl font-bold text-green-600">{testResult.percentage}%</p>
                <p className="text-sm text-gray-600">Score</p>
              </div>
            </div>
            <div className="mt-3 pt-3 border-t border-gray-200">
              <p className="text-sm text-gray-600">
                {testResult.score} out of {testResult.total_questions} questions answered correctly
              </p>
            </div>
          </div>

          {/* Back to Dashboard Button */}
          <button
            onClick={onFinish}
            className="w-full bg-blue-500 hover:bg-blue-600 text-white py-3 px-6 rounded-lg font-medium transition-all duration-200 transform hover:scale-105"
          >
            Back to Dashboard
          </button>
        </div>
      </div>
    );
  }

  const currentQuestionData = test.questions[currentQuestion];

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 to-green-50">
      {/* Header with Timer and Progress */}
      <header className="bg-white shadow-lg">
        <div className="max-w-4xl mx-auto px-4 py-4">
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-xl font-bold text-gray-800">{test.title}</h1>
              <p className="text-gray-600">
                Question {currentQuestion + 1} of {test.questions.length}
              </p>
            </div>
            
            <div className="flex items-center space-x-4">
              {/* Timer */}
              <div className="flex items-center space-x-2 bg-red-50 px-3 py-2 rounded-lg">
                <Clock className="w-5 h-5 text-red-600" />
                <span className="font-medium text-red-600">{formatTime(timeLeft)}</span>
              </div>
              
              {/* Progress */}
              <div className="text-sm text-gray-600">
                Progress: {Math.round(((currentQuestion + 1) / test.questions.length) * 100)}%
              </div>
            </div>
          </div>
          
          {/* Progress Bar */}
          <div className="mt-4">
            <div className="w-full bg-gray-200 rounded-full h-2">
              <div 
                className="bg-blue-500 h-2 rounded-full transition-all duration-300"
                style={{ width: `${((currentQuestion + 1) / test.questions.length) * 100}%` }}
              ></div>
            </div>
          </div>
        </div>
      </header>

      {/* Question Content */}
      <div className="max-w-4xl mx-auto px-4 py-8">
        <div className="bg-white rounded-xl p-8 shadow-lg">
          {/* Warning - No Going Back */}
          <div className="bg-yellow-50 border border-yellow-200 rounded-lg p-4 mb-6 flex items-start space-x-3">
            <AlertCircle className="w-5 h-5 text-yellow-600 mt-0.5 flex-shrink-0" />
            <div>
              <p className="text-yellow-800 font-medium">Important:</p>
              <p className="text-yellow-700 text-sm">
                You cannot go back to previous questions once you proceed. Make sure to select your answer carefully.
              </p>
            </div>
          </div>

          {/* Question */}
          <div className="mb-8">
            <h2 className="text-xl font-semibold text-gray-800 mb-6">
              {currentQuestionData.question}
            </h2>

            {/* Options */}
            <div className="space-y-3">
              {[1, 2, 3, 4].map((optionNum) => {
                const optionText = currentQuestionData[`option${optionNum}` as keyof Question] as string;
                const isSelected = selectedOption === optionNum;
                
                return (
                  <button
                    key={optionNum}
                    onClick={() => handleOptionSelect(optionNum)}
                    className={`w-full p-4 text-left rounded-lg border-2 transition-all duration-200 ${
                      isSelected
                        ? 'border-blue-300 bg-blue-50 text-blue-800'
                        : 'border-gray-200 hover:border-blue-200 hover:bg-blue-25'
                    }`}
                  >
                    <div className="flex items-center space-x-3">
                      <div className={`w-6 h-6 rounded-full border-2 flex items-center justify-center ${
                        isSelected ? 'border-blue-500 bg-blue-500' : 'border-gray-300'
                      }`}>
                        {isSelected && <div className="w-3 h-3 rounded-full bg-white"></div>}
                      </div>
                      <span className="font-medium">{optionNum}.</span>
                      <span>{optionText}</span>
                    </div>
                  </button>
                );
              })}
            </div>
          </div>

          {/* Navigation */}
          <div className="flex justify-between items-center pt-6 border-t border-gray-200">
            <div className="text-sm text-gray-500">
              {Object.keys(answers).length} of {test.questions.length} questions answered
            </div>
            
            <button
              onClick={handleNext}
              disabled={selectedOption === null}
              className="bg-blue-500 hover:bg-blue-600 text-white px-6 py-3 rounded-lg font-medium transition-all duration-200 disabled:opacity-50 disabled:cursor-not-allowed transform hover:scale-105"
            >
              {currentQuestion === test.questions.length - 1 ? 'Finish Test' : 'Next Question'}
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};

export default TestInterface;