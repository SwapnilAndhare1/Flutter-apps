import React, { useContext, useState } from 'react';
import { QuizContext } from './QuizContext';
import { Button, Typography, Paper, Box, Radio, RadioGroup, FormControlLabel } from '@mui/material';

function StudentDashboard({ onLogout }) {
  const { questions } = useContext(QuizContext);
  const [current, setCurrent] = useState(0);
  const [answers, setAnswers] = useState({});
  const [showResult, setShowResult] = useState(false);

  if (!questions.length) {
    return (
      <Box display="flex" flexDirection="column" alignItems="center" justifyContent="center" minHeight="100vh">
        <Paper elevation={3} sx={{ p: 4, minWidth: 350, textAlign: 'center' }}>
          <Typography variant="h6">No quiz available. Please ask your teacher to upload a quiz.</Typography>
          <Button variant="outlined" color="secondary" sx={{ mt: 3 }} onClick={onLogout}>Logout</Button>
        </Paper>
      </Box>
    );
  }

  // Only record the answer, do not show correctness or move to next question
  const handleAnswer = (e) => {
    setAnswers({ ...answers, [current]: e.target.value });
    // Do not show correctness or move to next question here
  };

  // Only move to next question when Next is clicked
  const handleNext = () => {
    if (current < questions.length - 1) {
      setCurrent(current + 1);
    } else {
      setShowResult(true);
    }
  };

  // Calculate score only for result page
  const score = Object.keys(answers).reduce((acc, idx) => {
    if (questions[idx].answer?.toString().trim().toLowerCase() === answers[idx]?.toString().trim().toLowerCase()) return acc + 1;
    return acc;
  }, 0);

  if (showResult) {
    return (
      <Box display="flex" flexDirection="column" alignItems="center" justifyContent="center" minHeight="100vh">
        <Paper elevation={3} sx={{ p: 4, minWidth: 350, textAlign: 'center' }}>
          <Typography variant="h5">Quiz Completed!</Typography>
          <Typography variant="h6" sx={{ mt: 2 }}>Your Score: {score} / {questions.length}</Typography>
          {/* Optionally, show correct/incorrect answers here if desired */}
          <Button variant="outlined" color="secondary" sx={{ mt: 3 }} onClick={onLogout}>Logout</Button>
        </Paper>
      </Box>
    );
  }

  const q = questions[current];

  return (
    <Box display="flex" flexDirection="column" alignItems="center" justifyContent="center" minHeight="100vh">
      <Paper elevation={3} sx={{ p: 4, minWidth: 350, textAlign: 'center' }}>
        <Typography variant="h6">Question {current + 1} of {questions.length}</Typography>
        <Typography variant="body1" sx={{ mt: 2 }}>{q.question}</Typography>
        <RadioGroup value={answers[current] || ''} onChange={handleAnswer} sx={{ mt: 2 }}>
          <FormControlLabel value={q.optionA} control={<Radio />} label={q.optionA} />
          <FormControlLabel value={q.optionB} control={<Radio />} label={q.optionB} />
          <FormControlLabel value={q.optionC} control={<Radio />} label={q.optionC} />
          <FormControlLabel value={q.optionD} control={<Radio />} label={q.optionD} />
        </RadioGroup>
        <Button variant="contained" sx={{ mt: 3 }} onClick={handleNext} disabled={answers[current] == null}>
          {current === questions.length - 1 ? 'Finish' : 'Next'}
        </Button>
        <Button variant="outlined" color="secondary" sx={{ mt: 2 }} onClick={onLogout}>Logout</Button>
      </Paper>
    </Box>
  );
}

export default StudentDashboard;
