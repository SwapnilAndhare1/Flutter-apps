import React, { useState, useRef, useEffect } from 'react';
import { Upload, FileSpreadsheet, Download, Trash2, Users, BarChart3, LogOut, MessageSquare, Send } from 'lucide-react';
import { useAuth } from '../../contexts/AuthContext';
import { Test, ExcelData } from '../../types';
import { 
  saveTestsToDatabase, 
  getTestsFromDatabase, 
  validateExcelData, 
  createTestFromExcelData 
} from '../../utils/database';
import { sendTeacherUpdate, mockTeacherUpdate } from '../../utils/api';
import * as XLSX from 'xlsx';

const TeacherDashboard: React.FC = () => {
  const { user, logout } = useAuth();
  const [tests, setTests] = useState<Test[]>([]);
  const [selectedFile, setSelectedFile] = useState<File | null>(null);
  const [previewData, setPreviewData] = useState<ExcelData[]>([]);
  const [isUploading, setIsUploading] = useState(false);
  const [error, setError] = useState('');
  const [success, setSuccess] = useState('');
  const [showUpdateModal, setShowUpdateModal] = useState(false);
  const [updateMessage, setUpdateMessage] = useState('');
  const [isUpdating, setIsUpdating] = useState(false);
  const fileInputRef = useRef<HTMLInputElement>(null);

  useEffect(() => {
    // Load existing tests on component mount
    const existingTests = getTestsFromDatabase();
    setTests(existingTests);
  }, []);

  /**
   * Handle file selection and preview
   */
  const handleFileSelect = (event: React.ChangeEvent<HTMLInputElement>) => {
    const file = event.target.files?.[0];
    if (!file) return;

    // Check file type
    const validTypes = ['application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 'application/vnd.ms-excel'];
    if (!validTypes.includes(file.type)) {
      setError('Please select a valid Excel file (.xlsx or .xls)');
      return;
    }

    setSelectedFile(file);
    setError('');
    setSuccess('');

    // Read and preview the file
    const reader = new FileReader();
    reader.onload = (e) => {
      try {
        const data = new Uint8Array(e.target?.result as ArrayBuffer);
        const workbook = XLSX.read(data, { type: 'array' });
        const sheetName = workbook.SheetNames[0];
        const worksheet = workbook.Sheets[sheetName];
        const jsonData = XLSX.utils.sheet_to_json(worksheet);

        // Validate the data structure
        const validation = validateExcelData(jsonData);
        
        if (!validation.isValid) {
          setError(`Invalid Excel format: ${validation.errors.join(', ')}`);
          setPreviewData([]);
          return;
        }

        setPreviewData(jsonData as ExcelData[]);
        setSuccess(`File loaded successfully! ${jsonData.length} questions found.`);
      } catch (err) {
        setError('Error reading Excel file. Please check the file format.');
        setPreviewData([]);
      }
    };

    reader.readAsArrayBuffer(file);
  };

  /**
   * Deploy test to database
   */
  const handleDeployTest = async () => {
    if (!selectedFile || previewData.length === 0) {
      setError('Please select and preview a valid Excel file first');
      return;
    }

    setIsUploading(true);
    setError('');

    try {
      // Create test object from Excel data
      const newTest = createTestFromExcelData(selectedFile.name, previewData, user!.id);
      
      // Add to tests array
      const updatedTests = [...tests, newTest];
      setTests(updatedTests);
      
      // Save to local database
      saveTestsToDatabase(updatedTests);
      
      setSuccess(`Test "${newTest.title}" deployed successfully!`);
      
      // Reset form
      setSelectedFile(null);
      setPreviewData([]);
      if (fileInputRef.current) {
        fileInputRef.current.value = '';
      }
    } catch (err) {
      setError('Error deploying test. Please try again.');
    } finally {
      setIsUploading(false);
    }
  };

  /**
   * Delete test from database
   */
  const handleDeleteTest = (testId: string) => {
    if (window.confirm('Are you sure you want to delete this test?')) {
      const updatedTests = tests.filter(test => test.id !== testId);
      setTests(updatedTests);
      saveTestsToDatabase(updatedTests);
      setSuccess('Test deleted successfully!');
    }
  };

  /**
   * Handle teacher update submission
   */
  const handleSendUpdate = async () => {
    if (!updateMessage.trim()) {
      alert('Please enter an update message');
      return;
    }

    setIsUpdating(true);
    try {
      // TODO: Replace mockTeacherUpdate with sendTeacherUpdate when you have real API
      // await sendTeacherUpdate(updateMessage);
      await mockTeacherUpdate(updateMessage);
      
      setSuccess('Update sent successfully!');
      setUpdateMessage('');
      setShowUpdateModal(false);
    } catch (error) {
      setError('Failed to send update. Please try again.');
    } finally {
      setIsUpdating(false);
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
              <h1 className="text-2xl font-bold text-gray-800">Teacher Dashboard</h1>
              <p className="text-gray-600">Welcome, {user?.username}</p>
            </div>
          </div>
          
          <div className="flex items-center space-x-4">
            {/* Update Button */}
            <button
              onClick={() => setShowUpdateModal(true)}
              className="bg-yellow-500 hover:bg-yellow-600 text-white px-4 py-2 rounded-lg font-medium transition-all duration-200 flex items-center space-x-2"
            >
              <MessageSquare className="w-5 h-5" />
              <span>Send Update</span>
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
        {/* Stats Cards */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
          <div className="bg-white rounded-xl p-6 shadow-lg">
            <div className="flex items-center space-x-4">
              <div className="bg-blue-100 p-3 rounded-full">
                <FileSpreadsheet className="w-6 h-6 text-blue-600" />
              </div>
              <div>
                <h3 className="text-lg font-semibold text-gray-800">Total Tests</h3>
                <p className="text-2xl font-bold text-blue-600">{tests.length}</p>
              </div>
            </div>
          </div>

          <div className="bg-white rounded-xl p-6 shadow-lg">
            <div className="flex items-center space-x-4">
              <div className="bg-green-100 p-3 rounded-full">
                <Users className="w-6 h-6 text-green-600" />
              </div>
              <div>
                <h3 className="text-lg font-semibold text-gray-800">Questions</h3>
                <p className="text-2xl font-bold text-green-600">
                  {tests.reduce((total, test) => total + test.total_questions, 0)}
                </p>
              </div>
            </div>
          </div>

          <div className="bg-white rounded-xl p-6 shadow-lg">
            <div className="flex items-center space-x-4">
              <div className="bg-yellow-100 p-3 rounded-full">
                <BarChart3 className="w-6 h-6 text-yellow-600" />
              </div>
              <div>
                <h3 className="text-lg font-semibold text-gray-800">Active</h3>
                <p className="text-2xl font-bold text-yellow-600">{tests.length}</p>
              </div>
            </div>
          </div>
        </div>

        {/* Upload Section */}
        <div className="bg-white rounded-xl p-6 shadow-lg mb-8">
          <h2 className="text-xl font-bold text-gray-800 mb-6">Upload New Test</h2>
          
          {/* File Upload */}
          <div className="mb-6">
            <input
              ref={fileInputRef}
              type="file"
              accept=".xlsx,.xls"
              onChange={handleFileSelect}
              className="hidden"
            />
            <button
              onClick={() => fileInputRef.current?.click()}
              className="bg-blue-500 hover:bg-blue-600 text-white px-6 py-3 rounded-lg font-medium transition-all duration-200 flex items-center space-x-2"
            >
              <Upload className="w-5 h-5" />
              <span>Choose Excel File</span>
            </button>
            
            {selectedFile && (
              <p className="mt-2 text-gray-600">
                Selected: {selectedFile.name} ({(selectedFile.size / 1024).toFixed(1)} KB)
              </p>
            )}
          </div>

          {/* Required Format Info */}
          <div className="bg-blue-50 border border-blue-200 rounded-lg p-4 mb-6">
            <h3 className="font-semibold text-blue-800 mb-2">Required Excel Format:</h3>
            <p className="text-blue-700 text-sm mb-2">Your Excel sheet must have exactly 5 columns:</p>
            <div className="grid grid-cols-5 gap-2 text-xs">
              <div className="bg-blue-100 p-2 rounded text-center font-medium">question</div>
              <div className="bg-blue-100 p-2 rounded text-center font-medium">option1</div>
              <div className="bg-blue-100 p-2 rounded text-center font-medium">option2</div>
              <div className="bg-blue-100 p-2 rounded text-center font-medium">option3</div>
              <div className="bg-blue-100 p-2 rounded text-center font-medium">option4</div>
            </div>
            <p className="text-blue-700 text-xs mt-2">Plus a 'correct_option' column with numbers 1-4</p>
          </div>

          {/* Error/Success Messages */}
          {error && (
            <div className="bg-red-50 border border-red-200 rounded-lg p-4 mb-4">
              <p className="text-red-700">{error}</p>
            </div>
          )}

          {success && (
            <div className="bg-green-50 border border-green-200 rounded-lg p-4 mb-4">
              <p className="text-green-700">{success}</p>
            </div>
          )}

          {/* Preview Data */}
          {previewData.length > 0 && (
            <div className="mb-6">
              <h3 className="text-lg font-semibold text-gray-800 mb-4">Preview ({previewData.length} questions)</h3>
              <div className="max-h-64 overflow-y-auto border border-gray-200 rounded-lg">
                <table className="w-full text-sm">
                  <thead className="bg-gray-50 sticky top-0">
                    <tr>
                      <th className="px-4 py-2 text-left font-medium text-gray-700">Question</th>
                      <th className="px-4 py-2 text-left font-medium text-gray-700">Option 1</th>
                      <th className="px-4 py-2 text-left font-medium text-gray-700">Option 2</th>
                      <th className="px-4 py-2 text-left font-medium text-gray-700">Option 3</th>
                      <th className="px-4 py-2 text-left font-medium text-gray-700">Option 4</th>
                      <th className="px-4 py-2 text-center font-medium text-gray-700">Correct</th>
                    </tr>
                  </thead>
                  <tbody>
                    {previewData.slice(0, 10).map((row, index) => (
                      <tr key={index} className="border-t border-gray-200">
                        <td className="px-4 py-2">{row.question}</td>
                        <td className="px-4 py-2">{row.option1}</td>
                        <td className="px-4 py-2">{row.option2}</td>
                        <td className="px-4 py-2">{row.option3}</td>
                        <td className="px-4 py-2">{row.option4}</td>
                        <td className="px-4 py-2 text-center font-medium text-blue-600">
                          {row.correct_option}
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
                {previewData.length > 10 && (
                  <div className="p-4 bg-gray-50 text-center text-gray-600">
                    ... and {previewData.length - 10} more questions
                  </div>
                )}
              </div>

              {/* Deploy Button */}
              <div className="mt-4">
                <button
                  onClick={handleDeployTest}
                  disabled={isUploading}
                  className="bg-green-500 hover:bg-green-600 text-white px-6 py-3 rounded-lg font-medium transition-all duration-200 flex items-center space-x-2 disabled:opacity-50"
                >
                  {isUploading ? (
                    <>
                      <div className="animate-spin rounded-full h-5 w-5 border-b-2 border-white"></div>
                      <span>Deploying...</span>
                    </>
                  ) : (
                    <>
                      <Download className="w-5 h-5" />
                      <span>Deploy Test</span>
                    </>
                  )}
                </button>
              </div>
            </div>
          )}
        </div>

        {/* Deployed Tests */}
        <div className="bg-white rounded-xl p-6 shadow-lg">
          <h2 className="text-xl font-bold text-gray-800 mb-6">Deployed Tests</h2>
          
          {tests.length === 0 ? (
            <div className="text-center py-8">
              <FileSpreadsheet className="w-12 h-12 text-gray-400 mx-auto mb-4" />
              <p className="text-gray-500">No tests deployed yet. Upload your first Excel sheet!</p>
            </div>
          ) : (
            <div className="grid gap-4">
              {tests.map((test) => (
                <div key={test.id} className="border border-gray-200 rounded-lg p-4 hover:shadow-md transition-shadow">
                  <div className="flex items-center justify-between">
                    <div>
                      <h3 className="font-semibold text-gray-800">{test.title}</h3>
                      <p className="text-sm text-gray-600">{test.description}</p>
                      <div className="flex items-center space-x-4 mt-2 text-xs text-gray-500">
                        <span>{test.total_questions} questions</span>
                        <span>Created: {new Date(test.created_at).toLocaleDateString()}</span>
                      </div>
                    </div>
                    <button
                      onClick={() => handleDeleteTest(test.id)}
                      className="text-red-500 hover:text-red-700 p-2 hover:bg-red-50 rounded-lg transition-colors"
                    >
                      <Trash2 className="w-5 h-5" />
                    </button>
                  </div>
                </div>
              ))}
            </div>
          )}
        </div>
      </div>

      {/* Update Modal */}
      {showUpdateModal && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center p-4 z-50">
          <div className="bg-white rounded-xl p-6 max-w-md w-full">
            <h2 className="text-xl font-bold text-gray-800 mb-4">Send Update to Students</h2>
            
            <textarea
              value={updateMessage}
              onChange={(e) => setUpdateMessage(e.target.value)}
              placeholder="Enter your update message..."
              className="w-full h-32 p-3 border border-gray-300 rounded-lg resize-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
            />
            
            <div className="flex items-center space-x-3 mt-4">
              <button
                onClick={handleSendUpdate}
                disabled={isUpdating}
                className="bg-blue-500 hover:bg-blue-600 text-white px-4 py-2 rounded-lg font-medium transition-all duration-200 flex items-center space-x-2 disabled:opacity-50"
              >
                {isUpdating ? (
                  <>
                    <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-white"></div>
                    <span>Sending...</span>
                  </>
                ) : (
                  <>
                    <Send className="w-4 h-4" />
                    <span>Send Update</span>
                  </>
                )}
              </button>
              
              <button
                onClick={() => setShowUpdateModal(false)}
                className="bg-gray-300 hover:bg-gray-400 text-gray-700 px-4 py-2 rounded-lg font-medium transition-colors"
              >
                Cancel
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default TeacherDashboard;