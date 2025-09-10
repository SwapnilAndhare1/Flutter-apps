// API utility functions for external integrations

/**
 * Teacher Update API Configuration
 * TODO: Replace with your actual API endpoint and credentials
 */
const TEACHER_API_CONFIG = {
  // Replace with your actual POST API endpoint
  endpoint: 'https://your-api-endpoint.com/teacher/update',
  // Replace with your actual basic auth credentials
  username: 'your-username',
  password: 'your-password'
};

/**
 * Student Update API Configuration
 * TODO: Replace with your actual API endpoint
 */
const STUDENT_API_CONFIG = {
  // Replace with your actual GET API endpoint
  endpoint: 'https://your-api-endpoint.com/student/updates'
};

/**
 * Send teacher update to POST API
 * @param message - The update message from teacher
 * @returns Promise with API response
 */
export const sendTeacherUpdate = async (message: string): Promise<any> => {
  try {
    // Create basic auth header
    const credentials = btoa(`${TEACHER_API_CONFIG.username}:${TEACHER_API_CONFIG.password}`);
    
    const response = await fetch(TEACHER_API_CONFIG.endpoint, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Basic ${credentials}`
      },
      body: JSON.stringify({
        message,
        timestamp: new Date().toISOString(),
        sender: 'teacher'
      })
    });

    if (!response.ok) {
      throw new Error(`API Error: ${response.status} ${response.statusText}`);
    }

    return await response.json();
  } catch (error) {
    console.error('Error sending teacher update:', error);
    throw error;
  }
};

/**
 * Fetch student updates from GET API
 * @returns Promise with API response data
 */
export const fetchStudentUpdates = async (): Promise<any> => {
  try {
    const response = await fetch(STUDENT_API_CONFIG.endpoint, {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json'
      }
    });

    if (!response.ok) {
      throw new Error(`API Error: ${response.status} ${response.statusText}`);
    }

    return await response.json();
  } catch (error) {
    console.error('Error fetching student updates:', error);
    throw error;
  }
};

/**
 * Mock API calls for development/testing
 * Remove these when you have real APIs
 */
export const mockTeacherUpdate = async (message: string): Promise<any> => {
  // Simulate API delay
  await new Promise(resolve => setTimeout(resolve, 1000));
  
  return {
    success: true,
    message: 'Update sent successfully',
    data: {
      id: Date.now(),
      message,
      timestamp: new Date().toISOString()
    }
  };
};

export const mockStudentUpdates = async (): Promise<any> => {
  // Simulate API delay
  await new Promise(resolve => setTimeout(resolve, 800));
  
  return {
    success: true,
    data: [
      {
        id: 1,
        message: 'Welcome to the Quiz Application!',
        timestamp: new Date().toISOString()
      },
      {
        id: 2,
        message: 'New test available: Mathematics Quiz',
        timestamp: new Date(Date.now() - 3600000).toISOString()
      }
    ]
  };
};