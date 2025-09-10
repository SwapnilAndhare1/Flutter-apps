import React, { createContext, useContext, useState, useEffect } from 'react';
import { AuthContextType, User } from '../types';

const AuthContext = createContext<AuthContextType | undefined>(undefined);

// Hardcoded credentials for demo purposes
const TEACHER_CREDENTIALS = { username: 'abc', password: '123' };
const STUDENT_CREDENTIALS = [
  { username: 'student1', password: 'pass1' },
  { username: 'student2', password: 'pass2' },
  { username: 'demo', password: 'demo' }
];

export const AuthProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const [user, setUser] = useState<User | null>(null);
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    // Check for stored user session
    const storedUser = localStorage.getItem('quiz-user');
    if (storedUser) {
      setUser(JSON.parse(storedUser));
    }
    setIsLoading(false);
  }, []);

  const login = async (username: string, password: string, role: 'teacher' | 'student'): Promise<boolean> => {
    setIsLoading(true);
    
    try {
      // Simulate API call delay
      await new Promise(resolve => setTimeout(resolve, 1000));
      
      let isValid = false;
      
      if (role === 'teacher') {
        isValid = username === TEACHER_CREDENTIALS.username && password === TEACHER_CREDENTIALS.password;
      } else {
        isValid = STUDENT_CREDENTIALS.some(
          cred => cred.username === username && cred.password === password
        );
      }
      
      if (isValid) {
        const newUser: User = {
          id: `${role}_${username}`,
          username,
          role,
          created_at: new Date().toISOString()
        };
        
        setUser(newUser);
        localStorage.setItem('quiz-user', JSON.stringify(newUser));
        return true;
      }
      
      return false;
    } finally {
      setIsLoading(false);
    }
  };

  const logout = () => {
    setUser(null);
    localStorage.removeItem('quiz-user');
    localStorage.removeItem('quiz-tests');
    localStorage.removeItem('quiz-results');
  };

  return (
    <AuthContext.Provider value={{ user, login, logout, isLoading }}>
      {children}
    </AuthContext.Provider>
  );
};

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (context === undefined) {
    throw new Error('useAuth must be used within an AuthProvider');
  }
  return context;
};