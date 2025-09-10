// Type definitions for the Quiz Application
export interface User {
  id: string;
  username: string;
  role: 'teacher' | 'student';
  created_at: string;
}

export interface Question {
  id?: number;
  question: string;
  option1: string;
  option2: string;
  option3: string;
  option4: string;
  correct_option: number;
  test_id: string;
}

export interface Test {
  id: string;
  title: string;
  description?: string;
  questions: Question[];
  created_by: string;
  created_at: string;
  total_questions: number;
}

export interface StudentAnswer {
  question_id: number;
  selected_option: number;
  is_correct: boolean;
}

export interface TestResult {
  id: string;
  student_id: string;
  test_id: string;
  score: number;
  total_questions: number;
  percentage: number;
  answers: StudentAnswer[];
  completed_at: string;
}

export interface AuthContextType {
  user: User | null;
  login: (username: string, password: string, role: 'teacher' | 'student') => Promise<boolean>;
  logout: () => void;
  isLoading: boolean;
}

export interface ExcelData {
  question: string;
  option1: string;
  option2: string;
  option3: string;
  option4: string;
  correct_option: number;
}

export interface UpdateData {
  message: string;
  timestamp: string;
}