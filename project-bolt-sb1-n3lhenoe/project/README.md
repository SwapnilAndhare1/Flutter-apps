# QUIZZY - Quiz Desktop Application

A comprehensive quiz application built with Python Tkinter featuring separate interfaces for teachers and students with Google-inspired UI design.

## Features

### Teacher Module
- **Secure Login**: Hard-coded credentials (ID: abc, Password: 123)
- **Excel Upload**: Upload quiz questions in specific format
- **File Validation**: Ensures proper column structure
- **Preview**: View uploaded content before deployment
- **Database Storage**: Questions stored in SQLite database

### Student Module
- **User Authentication**: Username/password login system
- **Dashboard**: View all available tests
- **Interactive Quiz**: Take tests with real-time feedback
- **Score Calculation**: Automatic scoring with percentage
- **Results Display**: Trophy for pass (≥35%), flower for fail (<35%)
- **Navigation**: Return to dashboard after completion

### Required Excel Format
The Excel file must contain exactly these columns:
- `questions`: The question text
- `option1`: First option
- `option2`: Second option  
- `option3`: Third option
- `option4`: Fourth option
- `correct_option`: Number (1, 2, 3, or 4) indicating correct answer

## Installation

1. Install required dependencies:
```bash
pip install -r requirements.txt
```

2. Run the application:
```bash
python main.py
```

## Default Credentials

### Teacher Login
- User ID: `abc`
- Password: `123`

### Student Login
- Username: `student1`, Password: `pass123`
- Username: `student2`, Password: `pass456`

## File Structure

- `main.py`: Main application entry point
- `teacher_module.py`: Teacher login and dashboard functionality
- `student_module.py`: Student login, dashboard, and quiz interface
- `database.py`: Database operations and management
- `ui_components.py`: Reusable UI components with Google color scheme
- `sample_quiz.xlsx`: Sample quiz file for testing
- `requirements.txt`: Python dependencies

## Usage

1. **Teacher Workflow**:
   - Login with teacher credentials
   - Select and upload Excel file with questions
   - Preview the content
   - Deploy test to make it available for students

2. **Student Workflow**:
   - Login with student credentials
   - View available tests on dashboard
   - Select and start a test
   - Answer questions (cannot go back)
   - View results with score and percentage
   - Return to dashboard for more tests

## Design Features

- **Google Color Scheme**: Blue, Red, Yellow, Green color palette
- **Responsive UI**: Clean, modern interface design
- **Interactive Elements**: Hover effects and visual feedback
- **Progress Tracking**: Question counter and progress display
- **Security**: No back navigation during tests
- **Data Validation**: Comprehensive input validation

## Database Schema

The application uses SQLite with the following tables:
- `tests`: Stores quiz questions and answers
- `students`: Stores student login credentials

## Notes

- Tests cannot be paused or resumed once started
- Students cannot navigate back during a test
- Minimum passing score is 35%
- Each uploaded Excel file creates a separate test
- All data is stored locally in SQLite database