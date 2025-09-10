// Local database utilities for Excel data storage
import { Test, Question, TestResult, ExcelData } from '../types';

// Database keys for localStorage
const DB_KEYS = {
  TESTS: 'quiz-tests',
  RESULTS: 'quiz-results',
  UPDATES: 'quiz-updates'
};

/**
 * Save tests to local database
 */
export const saveTestsToDatabase = (tests: Test[]): void => {
  localStorage.setItem(DB_KEYS.TESTS, JSON.stringify(tests));
};

/**
 * Get all tests from local database
 */
export const getTestsFromDatabase = (): Test[] => {
  const tests = localStorage.getItem(DB_KEYS.TESTS);
  return tests ? JSON.parse(tests) : [];
};

/**
 * Create test from Excel data
 */
export const createTestFromExcelData = (
  fileName: string, 
  excelData: ExcelData[], 
  createdBy: string
): Test => {
  const testId = `test_${Date.now()}`;
  
  const questions: Question[] = excelData.map((row, index) => ({
    id: index + 1,
    question: row.question,
    option1: row.option1,
    option2: row.option2,
    option3: row.option3,
    option4: row.option4,
    correct_option: row.correct_option,
    test_id: testId
  }));

  return {
    id: testId,
    title: fileName.replace('.xlsx', '').replace('.xls', ''),
    description: `Quiz created from ${fileName}`,
    questions,
    created_by: createdBy,
    created_at: new Date().toISOString(),
    total_questions: questions.length
  };
};

/**
 * Save test result to database
 */
export const saveTestResult = (result: TestResult): void => {
  const results = getTestResults();
  results.push(result);
  localStorage.setItem(DB_KEYS.RESULTS, JSON.stringify(results));
};

/**
 * Get all test results from database
 */
export const getTestResults = (): TestResult[] => {
  const results = localStorage.getItem(DB_KEYS.RESULTS);
  return results ? JSON.parse(results) : [];
};

/**
 * Get test results for specific student
 */
export const getStudentResults = (studentId: string): TestResult[] => {
  const results = getTestResults();
  return results.filter(result => result.student_id === studentId);
};

/**
 * Validate Excel data format
 */
export const validateExcelData = (data: any[]): { isValid: boolean; errors: string[] } => {
  const errors: string[] = [];
  const requiredColumns = ['question', 'option1', 'option2', 'option3', 'option4', 'correct_option'];
  
  if (!data || data.length === 0) {
    errors.push('Excel file is empty');
    return { isValid: false, errors };
  }

  // Check if all required columns exist
  const firstRow = data[0];
  const columns = Object.keys(firstRow);
  
  for (const col of requiredColumns) {
    if (!columns.includes(col)) {
      errors.push(`Missing required column: ${col}`);
    }
  }

  // Validate each row
  data.forEach((row, index) => {
    const rowNum = index + 1;
    
    // Check if question is not empty
    if (!row.question || row.question.trim() === '') {
      errors.push(`Row ${rowNum}: Question cannot be empty`);
    }
    
    // Check if all options are provided
    for (let i = 1; i <= 4; i++) {
      const option = row[`option${i}`];
      if (!option || option.trim() === '') {
        errors.push(`Row ${rowNum}: Option ${i} cannot be empty`);
      }
    }
    
    // Check if correct_option is valid (1-4)
    const correctOption = parseInt(row.correct_option);
    if (isNaN(correctOption) || correctOption < 1 || correctOption > 4) {
      errors.push(`Row ${rowNum}: Correct option must be a number between 1 and 4`);
    }
  });

  return { isValid: errors.length === 0, errors };
};

/**
 * Calculate test score
 */
export const calculateTestScore = (questions: Question[], answers: { [key: number]: number }): {
  score: number;
  percentage: number;
  correctAnswers: number;
} => {
  let correctAnswers = 0;
  
  questions.forEach(question => {
    const studentAnswer = answers[question.id!];
    if (studentAnswer === question.correct_option) {
      correctAnswers++;
    }
  });
  
  const percentage = Math.round((correctAnswers / questions.length) * 100);
  
  return {
    score: correctAnswers,
    percentage,
    correctAnswers
  };
};