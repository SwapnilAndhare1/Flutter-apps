import React, { useState } from 'react';
import { Eye, EyeOff, LogIn, ArrowLeft } from 'lucide-react';
import { useAuth } from '../contexts/AuthContext';

interface LoginFormProps {
  role: 'teacher' | 'student';
  onBack: () => void;
}

const LoginForm: React.FC<LoginFormProps> = ({ role, onBack }) => {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [showPassword, setShowPassword] = useState(false);
  const [error, setError] = useState('');
  const { login, isLoading } = useAuth();

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError('');
    
    if (!username.trim() || !password.trim()) {
      setError('Please fill in all fields');
      return;
    }

    const success = await login(username, password, role);
    if (!success) {
      setError('Invalid credentials. Please try again.');
    }
  };

  const getColorClasses = () => {
    if (role === 'teacher') {
      return {
        primary: 'bg-blue-500 hover:bg-blue-600 focus:ring-blue-500',
        secondary: 'text-blue-600 border-blue-200',
        accent: 'bg-blue-50',
        icon: 'text-blue-600'
      };
    }
    return {
      primary: 'bg-green-500 hover:bg-green-600 focus:ring-green-500',
      secondary: 'text-green-600 border-green-200',
      accent: 'bg-green-50',
      icon: 'text-green-600'
    };
  };

  const colors = getColorClasses();

  // Demo credentials display
  const demoCredentials = role === 'teacher' 
    ? { username: 'abc', password: '123' }
    : { username: 'demo', password: 'demo' };

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 to-green-50 flex items-center justify-center p-4">
      <div className="max-w-md w-full">
        {/* Back Button */}
        <button
          onClick={onBack}
          className="mb-6 flex items-center space-x-2 text-gray-600 hover:text-gray-800 transition-colors"
        >
          <ArrowLeft className="w-4 h-4" />
          <span>Back to selection</span>
        </button>

        {/* Login Card */}
        <div className="bg-white rounded-2xl p-8 shadow-xl">
          {/* Logo and Header */}
          <div className="text-center mb-8">
            <div className="inline-flex items-center space-x-1 mb-4">
              <div className="w-6 h-6 bg-blue-500 rounded-full"></div>
              <div className="w-6 h-6 bg-red-500 rounded-full"></div>
              <div className="w-6 h-6 bg-yellow-400 rounded-full"></div>
              <div className="w-6 h-6 bg-green-500 rounded-full"></div>
            </div>
            <h2 className="text-2xl font-bold text-gray-800 mb-2">
              {role === 'teacher' ? 'Teacher' : 'Student'} Login
            </h2>
            <p className="text-gray-600">Enter your credentials to continue</p>
          </div>

          {/* Demo Credentials Info */}
          <div className={`${colors.accent} rounded-lg p-4 mb-6`}>
            <h3 className="font-semibold text-gray-800 mb-2">Demo Credentials:</h3>
            <div className="space-y-1 text-sm">
              <p><strong>Username:</strong> {demoCredentials.username}</p>
              <p><strong>Password:</strong> {demoCredentials.password}</p>
            </div>
            {role === 'student' && (
              <p className="text-xs text-gray-600 mt-2">
                Also try: student1/pass1, student2/pass2
              </p>
            )}
          </div>

          {/* Login Form */}
          <form onSubmit={handleSubmit} className="space-y-6">
            {/* Username Field */}
            <div>
              <label htmlFor="username" className="block text-sm font-medium text-gray-700 mb-2">
                User ID
              </label>
              <input
                type="text"
                id="username"
                value={username}
                onChange={(e) => setUsername(e.target.value)}
                className="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all"
                placeholder="Enter your user ID"
                disabled={isLoading}
              />
            </div>

            {/* Password Field */}
            <div>
              <label htmlFor="password" className="block text-sm font-medium text-gray-700 mb-2">
                Password
              </label>
              <div className="relative">
                <input
                  type={showPassword ? 'text' : 'password'}
                  id="password"
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  className="w-full px-4 py-3 pr-12 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all"
                  placeholder="Enter your password"
                  disabled={isLoading}
                />
                <button
                  type="button"
                  onClick={() => setShowPassword(!showPassword)}
                  className="absolute right-3 top-1/2 transform -translate-y-1/2 text-gray-500 hover:text-gray-700 transition-colors"
                  disabled={isLoading}
                >
                  {showPassword ? <EyeOff className="w-5 h-5" /> : <Eye className="w-5 h-5" />}
                </button>
              </div>
            </div>

            {/* Error Message */}
            {error && (
              <div className="bg-red-50 border border-red-200 rounded-lg p-3">
                <p className="text-red-700 text-sm">{error}</p>
              </div>
            )}

            {/* Submit Button */}
            <button
              type="submit"
              disabled={isLoading}
              className={`w-full ${colors.primary} text-white py-3 px-4 rounded-lg font-medium transition-all duration-200 flex items-center justify-center space-x-2 disabled:opacity-50 disabled:cursor-not-allowed transform hover:scale-105`}
            >
              {isLoading ? (
                <>
                  <div className="animate-spin rounded-full h-5 w-5 border-b-2 border-white"></div>
                  <span>Signing in...</span>
                </>
              ) : (
                <>
                  <LogIn className="w-5 h-5" />
                  <span>Sign In</span>
                </>
              )}
            </button>
          </form>
        </div>
      </div>
    </div>
  );
};

export default LoginForm;