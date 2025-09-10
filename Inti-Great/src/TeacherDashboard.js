
import React, { useContext, useState } from 'react';
import { QuizContext } from './QuizContext';
import { Button, Typography, Paper, Box, TextField } from '@mui/material';
import * as XLSX from 'xlsx';

function TeacherDashboard({ onLogout }) {
  const [date, setDate] = useState('');
  const { setQuestions } = useContext(QuizContext);

  const handleFileUpload = (e) => {
    const file = e.target.files[0];
    if (!file) return;
    const reader = new FileReader();
    reader.onload = (evt) => {
      const data = new Uint8Array(evt.target.result);
      const workbook = XLSX.read(data, { type: 'array' });
      const sheet = workbook.Sheets[workbook.SheetNames[0]];
      const json = XLSX.utils.sheet_to_json(sheet);
      setQuestions(json);
      alert('Quiz uploaded successfully!');
    };
    reader.readAsArrayBuffer(file);
  };

  const handleInputChange = (e) => {
    setDate(e.target.value);
  };

  return (
    <Box display="flex" flexDirection="column" alignItems="center" justifyContent="center" minHeight="100vh">
      <Paper elevation={3} sx={{ p: 4, minWidth: 350, textAlign: 'center' }}>
        <Typography variant="h5" gutterBottom>Teacher </Typography>

        {/* Input Box */}
        <TextField
          label="Enter Date"
          variant="outlined"
          value={date}
          onChange={handleInputChange}
          sx={{ m: 2, width: '100%' }}
        />

        <Button variant="contained" component="label" sx={{ m: 2 }}>
          Upload Quiz Excel
          <input type="file" accept=".xlsx,.xls" hidden onChange={handleFileUpload} />
        </Button>

        <Typography variant="body2" color="textSecondary">
          Excel columns: question, optionA, optionB, optionC, optionD, answer 
        </Typography>

        <Button variant="outlined" color="secondary" sx={{ mt: 3 }} onClick={onLogout}>
          Logout done
        </Button>
      </Paper>
    </Box>
  );
}

export default TeacherDashboard;
