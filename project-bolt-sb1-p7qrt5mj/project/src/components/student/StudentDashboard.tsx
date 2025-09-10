import React, { useState, useEffect } from 'react';
import { BookOpen, Clock, Trophy, LogOut, MessageSquare, RefreshCw } from 'lucide-react';
import { useAuth } from '../../contexts/AuthContext';
import { Test } from '../../types';
import { getTestsFromDatabase } from '../../utils/database';
import { fetchStudentUpdates, mockStudentUpdates } from '../../utils/api';

interface StudentDashboardProps {
  onStartTest: (test: Test) => void;
}

const StudentDashboard: React.FC<StudentDashboardProps> = ({ onStartTest }) => {
  const { user, logout } = useAuth();
  const [tests, setTests] = useState<Test[]>([]);
  const [updates, setUpdates] = useState<any[]>([]);
  const [isLoadingUpdates, setIsLoadingUpdates] = useState(false);
  const [showUpdates, setShowUpdates] = useState(false);

  useEffect(() => {
    // Load available tests
    const availableTests = getTestsFromDatabase();
    setTests(availableTests);
  }, []);

  /**
   * Fetch updates from API
   */
  const handleFetchUpdates = async () => {
    setIsLoadingUpdates(true);
    try {
      // TODO: Replace mockStudentUpdates with fetchStudentUpdates when you have real API
      // const response = await fetchStudentUpdates();
      const response = await mockStudentUpdates();
      
      if (response.success) {
        setUpdates(response.data || []);
        setShowUpdates(true);
      }
    } catch (error) {
      alert('Failed to fetch updates. Please try again.');
    } finally {
      setIsLoadingUpdates(false);
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 to-green-50">
      {/* Header */}
      <header className="bg-white shadow-lg">
        <div className="max-w-7xl mx-auto px-4 py-4 flex items-center justify-between">
          <div className="flex items-center space-x-4">
            <div className="flex items-center space-x-1">
              <div className="w-6 h-6 bg-blue-500 rounded-full"></div>
              <div className="w-6 h-6 bg-red-500 rounded-full"></div>
              <div className="w-6 h-6 bg-yellow-400 rounded-full"></div>
              <div className="w-6 h-6 bg-green-500 rounded-full"></div>
            </div>
            <div>
              <h1 className="text-2xl font-bold text-gray-800">Student Dashboard</h1>
              <p className="text-gray-600">Welcome, {user?.username}</p>
            </div>
          </div>
          
          <div className="flex items-center space-x-4">
            {/* Update Button */}
            <button
              onClick={handleFetchUpdates}
              disabled={isLoadingUpdates}
              className="bg-green-500 hover:bg-green-600 text-white px-4 py-2 rounded-lg font-medium transition-all duration-200 flex items-center space-x-2 disabled:opacity-50"
            >
              {isLoadingUpdates ? (
                <>
                  <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-white"></div>
                  <span>Loading...</span>
                </>
              ) : (
                <>
                  <RefreshCw className="w-5 h-5" />
                  <span>Get Updates</span>
                </>
              )}
            </button>
            
            {/* Logout Button */}
            <button
              onClick={logout}
              className="bg-red-500 hover:bg-red-600 text-white px-4 py-2 rounded-lg font-medium transition-all duration-200 flex items-center space-x-2"
            >
              <LogOut className="w-5 h-5" />
              <span>Logout</span>
            </button>
          </div>
        </div>
      </header>

      <div className="max-w-7xl mx-auto px-4 py-8">
        {/* Stats Overview */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
          <div className="bg-white rounded-xl p-6 shadow-lg">
            <div className="flex items-center space-x-4">
              <div className="bg-blue-100 p-3 rounded-full">
                <BookOpen className="w-6 h-6 text-blue-600" />
              </div>
              <div>
                <h3 className="text-lg font-semibold text-gray-800">Available Tests</h3>
                <p className="text-2xl font-bold text-blue-600">{tests.length}</p>
              </div>
            </div>
          </div>

          <div className="bg-white rounded-xl p-6 shadow-lg">
            <div className="flex items-center space-x-4">
              <div className="bg-green-100 p-3 rounded-full">
                <Clock className="w-6 h-6 text-green-600" />
              </div>
              <div>
                <h3 className="text-lg font-semibold text-gray-800">Total Questions</h3>
                <p className="text-2xl font-bold text-green-600">
                  {tests.reduce((total, test) => total + test.total_questions, 0)}
                </p>
              </div>
            </div>
          </div>

          <div className="bg-white rounded-xl p-6 shadow-lg">
            <div className="flex items-center space-x-4">
              <div className="bg-yellow-100 p-3 rounded-full">
                <Trophy className="w-6 h-6 text-yellow-600" />
              </div>
              <div>
                <h3 className="text-lg font-semibold text-gray-800">Ready to Start</h3>
                <p className="text-2xl font-bold text-yellow-600">{tests.length}</p>
              </div>
            </div>
          </div>
        </div>

        {/* Available Tests */}
        <div className="bg-white rounded-xl p-6 shadow-lg mb-8">
          <h2 className="text-xl font-bold text-gray-800 mb-6">Available Tests</h2>
          
          {tests.length === 0 ? (
            <div className="text-center py-12">
              <BookOpen className="w-16 h-16 text-gray-400 mx-auto mb-4" />
              <h3 className="text-lg font-semibold text-gray-600 mb-2">No Tests Available</h3>
              <p className="text-gray-500">Please wait for your teacher to upload some tests.</p>
            </div>
          ) : (
            <div className="grid gap-4">
              {tests.map((test) => (
                <div 
                  key={test.id} 
                  className="border border-gray-200 rounded-lg p-6 hover:shadow-md transition-all duration-200 hover:border-blue-200"
                >
                  <div className="flex items-center justify-between">
                    <div className="flex-1">
                      <h3 className="text-lg font-semibold text-gray-800 mb-2">{test.title}</h3>
                      <p className="text-gray-600 mb-3">{test.description}</p>
                      
                      <div className="flex items-center space-x-6 text-sm text-gray-500">
                        <div className="flex items-center space-x-1">
                          <BookOpen className="w-4 h-4" />
                          <span>{test.total_questions} Questions</span>
                        </div>
                        <div className="flex items-center space-x-1">
                          <Clock className="w-4 h-4" />
                          <span>~{Math.ceil(test.total_questions * 1.5)} mins</span>
                        </div>
                        <div className="text-xs text-gray-400">
                          Created: {new Date(test.created_at).toLocaleDateString()}
                        </div>
                      </div>
                    </div>
                    
                    <button
                      onClick={() => onStartTest(test)}
                      className="bg-blue-500 hover:bg-blue-600 text-white px-6 py-3 rounded-lg font-medium transition-all duration-200 transform hover:scale-105 shadow-md"
                    >
                      Start Test
                    </button>
                  </div>
                </div>
              ))}
            </div>
          )}
        </div>

        {/* Instructions */}
        <div className="bg-gradient-to-r from-blue-500 to-green-500 rounded-xl p-6 text-white">
          <h2 className="text-xl font-bold mb-4">Instructions</h2>
          <div className="grid md:grid-cols-2 gap-6">
            <div>
              <h3 className="font-semibold mb-2">Before Starting:</h3>
              <ul className="space-y-1 text-sm opacity-90">
                <li>• Ensure stable internet connection</li>
                <li>• Find a quiet place to concentrate</li>
                <li>• Read all questions carefully</li>
              </ul>
            </div>
            <div>
              <h3 className="font-semibold mb-2">During the Test:</h3>
              <ul className="space-y-1 text-sm opacity-90">
                <li>• You cannot go back once started</li>
                <li>• Click on options to select answers</li>
                <li>• Submit when you're finished</li>
              </ul>
            </div>
          </div>
        </div>
      </div>

      {/* Updates Modal */}
      {showUpdates && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center p-4 z-50">
          <div className="bg-white rounded-xl p-6 max-w-2xl w-full max-h-96 overflow-y-auto">
            <div className="flex items-center justify-between mb-4">
              <h2 className="text-xl font-bold text-gray-800">Latest Updates</h2>
              <button
                onClick={() => setShowUpdates(false)}
                className="text-gray-500 hover:text-gray-700"
              >
                ✕
              </button>
            </div>
            
            {updates.length === 0 ? (
              <p className="text-gray-500 text-center py-8">No updates available</p>
            ) : (
              <div className="space-y-4">
                {updates.map((update, index) => (
                  <div key={update.id || index} className="border border-gray-200 rounded-lg p-4">
                    <p className="text-gray-800 mb-2">{update.message}</p>
                    <p className="text-xs text-gray-500">
                      {new Date(update.timestamp).toLocaleString()}
                    </p>
                  </div>
                ))}
              </div>
            )}
          </div>
        </div>
      )}
    </div>
  );
};

export default StudentDashboard;