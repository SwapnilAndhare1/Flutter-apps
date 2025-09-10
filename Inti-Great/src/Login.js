import React from 'react';
import { Button, Typography, Paper, Box } from '@mui/material';

function Login({ setRole }) {
  return (
    <Box display="flex" flexDirection="column" alignItems="center" justifyContent="center" minHeight="100vh">
      <Paper elevation={3} sx={{ p: 4, minWidth: 300, textAlign: 'center' }}>
        <Typography variant="h4" gutterBottom>Quiz App Login</Typography>
        <Button variant="contained" color="primary" sx={{ m: 1 }} onClick={() => setRole('teacher')}>Login as Teacher</Button>
        <Button variant="outlined" color="secondary" sx={{ m: 1 }} onClick={() => setRole('student')}>Login as Student</Button>
      </Paper>
    </Box>
  );
}

export default Login;
