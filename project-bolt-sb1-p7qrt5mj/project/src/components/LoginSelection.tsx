import React from 'react';
import { GraduationCap, Users } from 'lucide-react';

interface LoginSelectionProps {
  onSelectRole: (role: 'teacher' | 'student') => void;
}

const LoginSelection: React.FC<LoginSelectionProps> = ({ onSelectRole }) => {
  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 to-green-50 flex items-center justify-center p-4">
      <div className="max-w-4xl w-full">
        {/* Header with Google-inspired logo */}
        <div className="text-center mb-12">
          <div className="inline-flex items-center space-x-2 mb-4">
            <div className="w-8 h-8 bg-blue-500 rounded-full"></div>
            <div className="w-8 h-8 bg-red-500 rounded-full"></div>
            <div className="w-8 h-8 bg-yellow-400 rounded-full"></div>
            <div className="w-8 h-8 bg-green-500 rounded-full"></div>
          </div>
          <h1 className="text-4xl font-bold text-gray-800 mb-2">Quiz Master</h1>
          <p className="text-lg text-gray-600">Choose your login type to get started</p>
        </div>

        {/* Login Type Selection Cards */}
        <div className="grid md:grid-cols-2 gap-8 max-w-2xl mx-auto">
          {/* Teacher Login Card */}
          <div 
            onClick={() => onSelectRole('teacher')}
            className="bg-white rounded-2xl p-8 shadow-lg hover:shadow-xl transform hover:-translate-y-1 transition-all duration-300 cursor-pointer group border-2 border-transparent hover:border-blue-200"
          >
            <div className="text-center">
              <div className="inline-flex items-center justify-center w-20 h-20 bg-blue-100 rounded-full mb-6 group-hover:bg-blue-200 transition-colors">
                <GraduationCap className="w-10 h-10 text-blue-600" />
              </div>
              <h2 className="text-2xl font-bold text-gray-800 mb-3">Teacher Login</h2>
              <p className="text-gray-600 mb-6">Create and manage quizzes for your students</p>
              <div className="bg-blue-50 rounded-lg p-4 text-left">
                <h3 className="font-semibold text-blue-800 mb-2">Features:</h3>
                <ul className="text-sm text-blue-700 space-y-1">
                  <li>• Upload Excel question sheets</li>
                  <li>• Deploy tests to students</li>
                  <li>• View student results</li>
                  <li>• Manage test content</li>
                </ul>
              </div>
            </div>
          </div>

          {/* Student Login Card */}
          <div 
            onClick={() => onSelectRole('student')}
            className="bg-white rounded-2xl p-8 shadow-lg hover:shadow-xl transform hover:-translate-y-1 transition-all duration-300 cursor-pointer group border-2 border-transparent hover:border-green-200"
          >
            <div className="text-center">
              <div className="inline-flex items-center justify-center w-20 h-20 bg-green-100 rounded-full mb-6 group-hover:bg-green-200 transition-colors">
                <Users className="w-10 h-10 text-green-600" />
              </div>
              <h2 className="text-2xl font-bold text-gray-800 mb-3">Student Login</h2>
              <p className="text-gray-600 mb-6">Take quizzes and view your results</p>
              <div className="bg-green-50 rounded-lg p-4 text-left">
                <h3 className="font-semibold text-green-800 mb-2">Features:</h3>
                <ul className="text-sm text-green-700 space-y-1">
                  <li>• Access available tests</li>
                  <li>• Take interactive quizzes</li>
                  <li>• View instant results</li>
                  <li>• Track your progress</li>
                </ul>
              </div>
            </div>
          </div>
        </div>

        {/* Footer */}
        <div className="text-center mt-12">
          <p className="text-gray-500">Secure, reliable, and user-friendly quiz platform</p>
        </div>
      </div>
    </div>
  );
};

export default LoginSelection;