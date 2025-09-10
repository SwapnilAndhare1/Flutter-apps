import sqlite3
import pandas as pd
import os

class DatabaseManager:
    def __init__(self, db_name="quiz_app.db"):
        """Initialize database connection and create tables if they don't exist"""
        self.db_name = db_name
        self.init_database()
    
    def init_database(self):
        """Create necessary tables for the quiz application"""
        conn = sqlite3.connect(self.db_name)
        cursor = conn.cursor()
        
        # Create tests table to store uploaded excel data
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS tests (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                test_name TEXT NOT NULL,
                question TEXT NOT NULL,
                option1 TEXT NOT NULL,
                option2 TEXT NOT NULL,
                option3 TEXT NOT NULL,
                option4 TEXT NOT NULL,
                correct_option INTEGER NOT NULL,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
        ''')
        
        # Create students table for login credentials
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS students (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                username TEXT UNIQUE NOT NULL,
                password TEXT NOT NULL
            )
        ''')
        
        # Insert default student credentials
        cursor.execute('''
            INSERT OR IGNORE INTO students (username, password) 
            VALUES ('student1', 'pass123'), ('student2', 'pass456')
        ''')
        
        conn.commit()
        conn.close()
    
    def upload_excel_data(self, file_path, test_name):
        """Upload excel data to database after validation"""
        try:
            # Read excel file
            df = pd.read_excel(file_path)
            
            # Validate columns
            required_columns = ['questions', 'option1', 'option2', 'option3', 'option4', 'correct_option']
            if not all(col in df.columns for col in required_columns):
                return False, "Excel file must contain exactly these columns: questions, option1, option2, option3, option4, correct_option"
            
            # Validate correct_option values (should be 1, 2, 3, or 4)
            if not df['correct_option'].isin([1, 2, 3, 4]).all():
                return False, "Correct option must be 1, 2, 3, or 4"
            
            conn = sqlite3.connect(self.db_name)
            cursor = conn.cursor()
            
            # Insert data into tests table
            for _, row in df.iterrows():
                cursor.execute('''
                    INSERT INTO tests (test_name, question, option1, option2, option3, option4, correct_option)
                    VALUES (?, ?, ?, ?, ?, ?, ?)
                ''', (test_name, row['questions'], row['option1'], row['option2'], 
                     row['option3'], row['option4'], row['correct_option']))
            
            conn.commit()
            conn.close()
            return True, "Test uploaded successfully!"
            
        except Exception as e:
            return False, f"Error uploading file: {str(e)}"
    
    def get_all_tests(self):
        """Get all unique test names"""
        conn = sqlite3.connect(self.db_name)
        cursor = conn.cursor()
        cursor.execute('SELECT DISTINCT test_name FROM tests')
        tests = [row[0] for row in cursor.fetchall()]
        conn.close()
        return tests
    
    def get_test_questions(self, test_name):
        """Get all questions for a specific test"""
        conn = sqlite3.connect(self.db_name)
        cursor = conn.cursor()
        cursor.execute('''
            SELECT question, option1, option2, option3, option4, correct_option 
            FROM tests WHERE test_name = ?
        ''', (test_name,))
        questions = cursor.fetchall()
        conn.close()
        return questions
    
    def validate_student_login(self, username, password):
        """Validate student login credentials"""
        conn = sqlite3.connect(self.db_name)
        cursor = conn.cursor()
        cursor.execute('SELECT * FROM students WHERE username = ? AND password = ?', (username, password))
        result = cursor.fetchone()
        conn.close()
        return result is not None