import React, { useState } from 'react';
import { AuthProvider, useAuth } from './contexts/AuthContext';
import LoginSelection from './components/LoginSelection';
import LoginForm from './components/LoginForm';
import TeacherDashboard from './components/teacher/TeacherDashboard';
import StudentDashboard from './components/student/StudentDashboard';
import TestInterface from './components/student/TestInterface';
import { Test } from './types';

const AppContent: React.FC = () => {
  const { user, isLoading } = useAuth();
  const [selectedRole, setSelectedRole] = useState<'teacher' | 'student' | null>(null);
  const [currentTest, setCurrentTest] = useState<Test | null>(null);

  // Handle role selection
  const handleRoleSelect = (role: 'teacher' | 'student') => {
    setSelectedRole(role);
  };

  // Handle going back to role selection
  const handleBackToSelection = () => {
    setSelectedRole(null);
  };

  // Handle starting a test
  const handleStartTest = (test: Test) => {
    setCurrentTest(test);
  };

  // Handle finishing a test
  const handleFinishTest = () => {
    setCurrentTest(null);
  };

  // Show loading state
  if (isLoading) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-blue-50 to-green-50 flex items-center justify-center">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-500 mx-auto mb-4"></div>
          <p className="text-gray-600">Loading...</p>
        </div>
      </div>
    );
  }

  // Show test interface if a test is selected
  if (currentTest) {
    return <TestInterface test={currentTest} onFinish={handleFinishTest} />;
  }

  // Show appropriate dashboard if user is logged in
  if (user) {
    if (user.role === 'teacher') {
      return <TeacherDashboard />;
    } else {
      return <StudentDashboard onStartTest={handleStartTest} />;
    }
  }

  // Show login form if role is selected
  if (selectedRole) {
    return <LoginForm role={selectedRole} onBack={handleBackToSelection} />;
  }

  // Show role selection by default
  return <LoginSelection onSelectRole={handleRoleSelect} />;
};

const App: React.FC = () => {
  return (
    <AuthProvider>
      <AppContent />
    </AuthProvider>
  );
};

export default App;