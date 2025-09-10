import React, { useState } from 'react';
import Login from './Login';
import TeacherDashboard from './TeacherDashboard';
import StudentDashboard from './StudentDashboard';
import { QuizProvider } from './QuizContext';

function App() {
  const [role, setRole] = useState(null);

  return (
    <QuizProvider>
      <div style={{ minHeight: '100vh', background: '#f5f6fa' }}>
        {!role && <Login setRole={setRole} />}
        {role === 'teacher' && <TeacherDashboard onLogout={() => setRole(null)} />}
        {role === 'student' && <StudentDashboard onLogout={() => setRole(null)} />}
      </div>
    </QuizProvider>
  );
}

export default App;
