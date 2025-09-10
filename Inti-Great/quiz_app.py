from tkinter import filedialog, messagebox
import pandas as pd
import threading
import time

import tkinter as tk
from tkinter import filedialog, messagebox
import pandas as pd
import threading
import time
import sqlite3
import os

# --- Modern Color Palette ---
PRIMARY = "#5B21B6"      # Deep Purple
ACCENT = "#14B8A6"       # Teal
DANGER = "#EF4444"       # Red
BG = "#F1F5F9"           # Soft Gray
CARD = "#FFFFFF"         # White
TEXT = "#0F172A"         # Very Dark Blue
DISABLED = "#CBD5E1"     # Light Blue-Gray
SECONDARY = "#6366F1"    # Indigo
HIGHLIGHT = "#F472B6"    # Pink

class AnimatedButton(tk.Canvas):
    def __init__(self, master, text, command=None, width=180, height=44, bg=PRIMARY, fg="white", font=("Segoe UI", 13, "bold"), radius=18, shadow=True, **kwargs):
        super().__init__(master, width=width, height=height, highlightthickness=0, bg=BG, bd=0)
        self.command = command
        self.bg = bg
        self.fg = fg
        self.font = font
        self.radius = radius
        self.shadow = shadow
        self.text = text
        self.state = "normal"
        self.rect = None
        self.text_id = None
        self.draw_button()
        self.bind("<Button-1>", self.on_click)
        self.bind("<Enter>", self.on_enter)
        self.bind("<Leave>", self.on_leave)
        self.bind("<ButtonRelease-1>", self.on_release)

    def draw_button(self, y_offset=0):
        self.delete("all")
        w = int(self["width"])
        h = int(self["height"])
        r = self.radius
        # Shadow
        if self.shadow:
            self.create_rounded_rect(4, 4+y_offset, w-2, h-2+y_offset, r, fill=DISABLED, outline="")
        # Button
        self.rect = self.create_rounded_rect(0, 0+y_offset, w-6, h-6+y_offset, r, fill=self.bg, outline=SECONDARY)
        # Text
        self.text_id = self.create_text(w//2-3, h//2-3+y_offset, text=self.text, fill=self.fg, font=self.font)

    def create_rounded_rect(self, x1, y1, x2, y2, r, **kwargs):
        points = [
            x1+r, y1,
            x2-r, y1,
            x2, y1,
            x2, y1+r,
            x2, y2-r,
            x2, y2,
            x2-r, y2,
            x1+r, y2,
            x1, y2,
            x1, y2-r,
            x1, y1+r,
            x1, y1
        ]
        return self.create_polygon(points, smooth=True, **kwargs)

    def on_click(self, event):
        if self.state == "disabled":
            return
        self.animate_press()
        if self.command:
            self.after(120, self.command)

    def on_enter(self, event):
        if self.state == "disabled":
            return
        self.bg = HIGHLIGHT
        self.draw_button()

    def on_leave(self, event):
        if self.state == "disabled":
            return
        self.bg = PRIMARY if self.fg == "white" else DANGER
        self.draw_button()

    def on_release(self, event):
        if self.state == "disabled":
            return
        self.bg = HIGHLIGHT
        self.draw_button()

    def animate_press(self):
        # Simple bounce animation
        for y in (2, 4, 2, 0):
            self.draw_button(y_offset=y)
            self.update()
            time.sleep(0.03)

    def config(self, **kwargs):
        if "state" in kwargs:
            self.state = kwargs["state"]
            if self.state == "disabled":
                self.bg = DISABLED
                self.fg = "#888"
            else:
                self.bg = PRIMARY if self.fg == "white" else DANGER
                self.fg = "white"
            self.draw_button()
        if "text" in kwargs:
            self.text = kwargs["text"]
            self.draw_button()
        super().config(**kwargs)


class QuizApp:
    def __init__(self, root):
        self.root = root
        self.root.title('Quiz App')
        self.role = None
        self.current_test_idx = 0
        self.questions = []
        self.answers = []
        self.current_q = 0
        self.user_answers = []
        self.db_path = os.path.join(os.path.dirname(__file__), 'quiz_app.db')
        self.conn = sqlite3.connect(self.db_path)
        self.init_db()
        self.login_screen()

    def init_db(self):
        c = self.conn.cursor()
        # Check if quizzes table exists and has test_id column
        c.execute("SELECT name FROM sqlite_master WHERE type='table' AND name='quizzes'")
        quizzes_exists = c.fetchone()
        needs_migration = False
        if quizzes_exists:
            c.execute("PRAGMA table_info(quizzes)")
            columns = [row[1] for row in c.fetchall()]
            if 'test_id' not in columns:
                needs_migration = True
        if needs_migration:
            # Drop all tables and recreate schema
            c.execute('DROP TABLE IF EXISTS user_answers')
            c.execute('DROP TABLE IF EXISTS quizzes')
            c.execute('DROP TABLE IF EXISTS tests')
        # Create tables with correct schema
        c.execute('''CREATE TABLE IF NOT EXISTS tests (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL
        )''')
        c.execute('''CREATE TABLE IF NOT EXISTS quizzes (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            test_id INTEGER NOT NULL,
            question TEXT NOT NULL,
            optionA TEXT NOT NULL,
            optionB TEXT NOT NULL,
            optionC TEXT NOT NULL,
            optionD TEXT NOT NULL,
            answer TEXT NOT NULL,
            FOREIGN KEY(test_id) REFERENCES tests(id) ON DELETE CASCADE
        )''')
        c.execute('''CREATE TABLE IF NOT EXISTS user_answers (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT NOT NULL,
            question_id INTEGER NOT NULL,
            selected_option TEXT NOT NULL,
            is_correct INTEGER NOT NULL,
            FOREIGN KEY(question_id) REFERENCES quizzes(id)
        )''')
        self.conn.commit()

    def clear_quizzes(self, test_id=None):
        c = self.conn.cursor()
        if test_id:
            c.execute('DELETE FROM quizzes WHERE test_id=?', (test_id,))
            c.execute('DELETE FROM tests WHERE id=?', (test_id,))
        else:
            c.execute('DELETE FROM quizzes')
            c.execute('DELETE FROM tests')
        self.conn.commit()

    def insert_test_with_quizzes(self, test_name, questions):
        c = self.conn.cursor()
        c.execute('INSERT INTO tests (name) VALUES (?)', (test_name,))
        test_id = c.lastrowid
        for q in questions:
            c.execute('''INSERT INTO quizzes (test_id, question, optionA, optionB, optionC, optionD, answer) VALUES (?, ?, ?, ?, ?, ?, ?)''',
                      (test_id, q['question'], q['optionA'], q['optionB'], q['optionC'], q['optionD'], str(q['answer'])))
        self.conn.commit()
        return test_id

    def get_all_tests(self):
        c = self.conn.cursor()
        c.execute('SELECT id, name FROM tests')
        return c.fetchall()

    def get_quizzes_by_test(self, test_id):
        c = self.conn.cursor()
        c.execute('SELECT id, question, optionA, optionB, optionC, optionD, answer FROM quizzes WHERE test_id=?', (test_id,))
        rows = c.fetchall()
        questions = []
        for row in rows:
            questions.append({
                'id': row[0],
                'question': row[1],
                'optionA': row[2],
                'optionB': row[3],
                'optionC': row[4],
                'optionD': row[5],
                'answer': row[6]
            })
        return questions

    def save_user_answers(self, username, user_answers):
        c = self.conn.cursor()
        for ans in user_answers:
            c.execute('''INSERT INTO user_answers (username, question_id, selected_option, is_correct) VALUES (?, ?, ?, ?)''',
                      (username, ans['question_id'], ans['selected_option'], ans['is_correct']))
        self.conn.commit()

    def clear(self):
        for widget in self.root.winfo_children():
            widget.destroy()
        self.root.configure(bg=BG)

    def login_screen(self):
        self.clear()
        frame = tk.Frame(self.root, bg=CARD, bd=0, relief='flat', highlightbackground=SECONDARY, highlightthickness=3)
        frame.place(relx=0.5, rely=0.5, anchor='center', width=400, height=340)
        tk.Label(frame, text='Quiz App', font=('Segoe UI', 30, 'bold'), fg=PRIMARY, bg=CARD).pack(pady=(30, 10))
        tk.Label(frame, text='Welcome! Please select your role:', font=('Segoe UI', 14), fg=TEXT, bg=CARD).pack(pady=(0, 25))
        btn1 = AnimatedButton(frame, text='Login as Teacher', width=220, command=self.teacher_login_form)
        btn1.pack(pady=8)
        btn2 = AnimatedButton(frame, text='Login as Student', width=220, bg="#fbbf24", fg=PRIMARY, command=self.student_login_form)
        btn2.pack(pady=8)
        tk.Label(frame, text='© Inti-Great', font=('Segoe UI', 10), fg=DISABLED, bg=CARD).pack(side='bottom', pady=8)

    def teacher_login_form(self):
        self.clear()
        frame = tk.Frame(self.root, bg=CARD, bd=0, relief='flat', highlightbackground=PRIMARY, highlightthickness=2)
        frame.place(relx=0.5, rely=0.5, anchor='center', width=400, height=340)
        tk.Label(frame, text='Teacher Login', font=('Segoe UI', 22, 'bold'), fg=PRIMARY, bg=CARD).pack(pady=(30, 10))
        tk.Label(frame, text='Username:', font=('Segoe UI', 13), fg=TEXT, bg=CARD).pack(pady=(10, 2))
        username_entry = tk.Entry(frame, font=('Segoe UI', 13), bg=BG, fg=TEXT, bd=1, relief='solid')
        username_entry.pack(pady=2)
        tk.Label(frame, text='Password:', font=('Segoe UI', 13), fg=TEXT, bg=CARD).pack(pady=(10, 2))
        password_entry = tk.Entry(frame, font=('Segoe UI', 13), bg=BG, fg=TEXT, bd=1, relief='solid', show='*')
        password_entry.pack(pady=2)
        feedback_label = tk.Label(frame, text='', font=('Segoe UI', 11), fg=DANGER, bg=CARD)
        feedback_label.pack(pady=4)
        def try_login():
            username = username_entry.get()
            password = password_entry.get()
            if username == "admin" and password == "admin123":
                self.teacher_dashboard()
            else:
                feedback_label.config(text="Invalid credentials. Try admin/admin123.")
        btn_login = AnimatedButton(frame, text='Login', width=180, command=try_login)
        btn_login.pack(pady=12)
        btn_back = AnimatedButton(frame, text='Back', width=120, bg=DANGER, command=self.login_screen)
        btn_back.pack(pady=2)

    def student_login_form(self):
        self.clear()
        frame = tk.Frame(self.root, bg=CARD, bd=0, relief='flat', highlightbackground=PRIMARY, highlightthickness=2)
        frame.place(relx=0.5, rely=0.5, anchor='center', width=400, height=340)
        tk.Label(frame, text='Student Login', font=('Segoe UI', 22, 'bold'), fg=PRIMARY, bg=CARD).pack(pady=(30, 10))
        tk.Label(frame, text='Username:', font=('Segoe UI', 13), fg=TEXT, bg=CARD).pack(pady=(10, 2))
        username_entry = tk.Entry(frame, font=('Segoe UI', 13), bg=BG, fg=TEXT, bd=1, relief='solid')
        username_entry.pack(pady=2)
        tk.Label(frame, text='Password:', font=('Segoe UI', 13), fg=TEXT, bg=CARD).pack(pady=(10, 2))
        password_entry = tk.Entry(frame, font=('Segoe UI', 13), bg=BG, fg=TEXT, bd=1, relief='solid', show='*')
        password_entry.pack(pady=2)
        feedback_label = tk.Label(frame, text='', font=('Segoe UI', 11), fg=DANGER, bg=CARD)
        feedback_label.pack(pady=4)
        def try_login():
            username = username_entry.get()
            password = password_entry.get()
            if username == "student" and password == "student123":
                self.student_dashboard()
            else:
                feedback_label.config(text="Invalid credentials. Try student/student123.")
        btn_login = AnimatedButton(frame, text='Login', width=180, command=try_login)
        btn_login.pack(pady=12)
        btn_back = AnimatedButton(frame, text='Back', width=120, bg=DANGER, command=self.login_screen)
        btn_back.pack(pady=2)

    def teacher_dashboard(self):
        self.role = 'teacher'
        self.clear()
        frame = tk.Frame(self.root, bg=CARD, bd=0, relief='flat', highlightbackground=PRIMARY, highlightthickness=2)
        frame.place(relx=0.5, rely=0.5, anchor='center', width=600, height=420)
        tk.Label(frame, text='Teacher Dashboard', font=('Segoe UI', 22, 'bold'), fg=PRIMARY, bg=CARD).pack(pady=(20, 10))
        btn = AnimatedButton(frame, text='Upload Quiz Excel(s)', width=240, command=self.upload_excel)
        btn.pack(pady=8)
        tk.Label(frame, text='Excel columns: question, optionA, optionB, optionC, optionD, answer', fg=DISABLED, bg=CARD, font=('Segoe UI', 11)).pack(pady=2)

        # List all tests
        tests = self.get_all_tests()
        tests_frame = tk.Frame(frame, bg=CARD)
        tests_frame.pack(pady=10)
        tk.Label(tests_frame, text='Uploaded Tests:', font=('Segoe UI', 13, 'bold'), fg=PRIMARY, bg=CARD).pack(anchor='w')
        if not tests:
            tk.Label(tests_frame, text='No tests uploaded yet.', font=('Segoe UI', 12), fg=DISABLED, bg=CARD).pack(anchor='w', padx=10)
        else:
            for test_id, test_name in tests:
                row = tk.Frame(tests_frame, bg=CARD)
                row.pack(fill='x', pady=2, padx=10)
                tk.Label(row, text=f'{test_name}', font=('Segoe UI', 12), fg=TEXT, bg=CARD, width=30, anchor='w').pack(side='left')
                del_btn = AnimatedButton(row, text='Delete', width=80, bg=DANGER, command=lambda tid=test_id: self.delete_test_confirm(tid))
                del_btn.pack(side='right', padx=4)

        btn2 = AnimatedButton(frame, text='Logout', width=180, bg=DANGER, command=self.login_screen)
        btn2.pack(pady=18)

    def delete_test_confirm(self, test_id):
        if messagebox.askyesno('Delete Test', 'Are you sure you want to delete this test?'):
            self.clear_quizzes(test_id)
            messagebox.showinfo('Deleted', 'Test deleted successfully!')
            self.teacher_dashboard()

    def upload_excel(self):
        file_paths = filedialog.askopenfilenames(filetypes=[('Excel Files', '*.xlsx *.xls')])
        if not file_paths:
            return
        total_uploaded = 0
        required_cols = ['question', 'optionA', 'optionB', 'optionC', 'optionD', 'answer']
        for file_path in file_paths:
            try:
                df = pd.read_excel(file_path)
                # Normalize column names: strip and lower
                df.columns = [str(col).strip().lower() for col in df.columns]
                col_map = {col: None for col in required_cols}
                for col in df.columns:
                    for req in required_cols:
                        if col.replace(' ', '') == req.lower():
                            col_map[req] = col
                missing = [req for req, found in col_map.items() if found is None]
                if missing:
                    messagebox.showerror('Error', f'Excel {os.path.basename(file_path)} is missing columns: {', '.join(missing)}')
                    continue
                # Rebuild DataFrame with correct column names and order
                df = df[[col_map[req] for req in required_cols]]
                df.columns = required_cols
                if df.empty:
                    messagebox.showerror('Error', f'Excel {os.path.basename(file_path)} is empty.')
                    continue
                # Check for missing values in required fields
                for idx, row in df.iterrows():
                    for col in required_cols:
                        if pd.isnull(row[col]) or str(row[col]).strip() == '':
                            messagebox.showerror('Error', f'Row {idx+2} in {os.path.basename(file_path)} is missing value for "{col}".')
                            break
                    else:
                        continue
                    break
                else:
                    questions = df.to_dict('records')
                    test_name = os.path.basename(file_path)
                    self.insert_test_with_quizzes(test_name, questions)
                    total_uploaded += 1
            except Exception as e:
                messagebox.showerror('Error', f'Failed to read Excel {os.path.basename(file_path)}: {e}')
        if total_uploaded:
            messagebox.showinfo('Success', f'{total_uploaded} Quiz file(s) uploaded!')
            self.teacher_dashboard()

    def student_dashboard(self):
        self.role = 'student'
        self.clear()
        frame = tk.Frame(self.root, bg=CARD, bd=0, relief='flat', highlightbackground=PRIMARY, highlightthickness=2)
        frame.place(relx=0.5, rely=0.5, anchor='center', width=600, height=420)
        tests = self.get_all_tests()
        tk.Label(frame, text='Student Dashboard', font=('Segoe UI', 22, 'bold'), fg=PRIMARY, bg=CARD).pack(pady=(20, 10))
        if not tests:
            tk.Label(frame, text='No tests available.', font=('Segoe UI', 18, 'bold'), fg=DANGER, bg=CARD).pack(pady=(40, 10))
            tk.Label(frame, text='Please ask your teacher to upload a quiz.', font=('Segoe UI', 13), fg=TEXT, bg=CARD).pack(pady=(0, 30))
            btn = AnimatedButton(frame, text='Logout', width=180, bg=DANGER, command=self.login_screen)
            btn.pack(pady=10)
            return

        tk.Label(frame, text=f'{len(tests)} test(s) available. Select a test to start:', font=('Segoe UI', 13), fg=TEXT, bg=CARD).pack(pady=(10, 10))
        tests_frame = tk.Frame(frame, bg=CARD)
        tests_frame.pack(pady=10)
        for test_id, test_name in tests:
            btn = AnimatedButton(tests_frame, text=f'Start: {test_name}', width=320, command=lambda tid=test_id: self.start_test(tid))
            btn.pack(pady=6)

        btn2 = AnimatedButton(frame, text='Logout', width=180, bg=DANGER, command=self.login_screen)
        btn2.pack(pady=10)

    def start_test(self, test_id):
        self.current_test_id = test_id
        self.questions = self.get_quizzes_by_test(test_id)
        self.current_q = 0
        self.user_answers = [None] * len(self.questions)
        self.show_question()

    def show_question(self):
        self.clear()
        frame = tk.Frame(self.root, bg=CARD, bd=0, relief='flat', highlightbackground=PRIMARY, highlightthickness=2)
        frame.place(relx=0.5, rely=0.5, anchor='center', width=600, height=480)
        question = self.questions[self.current_q]

        # Progress bar
        progress = tk.DoubleVar(value=(self.current_q+1)/len(self.questions)*100)
        progress_frame = tk.Frame(frame, bg=CARD)
        progress_frame.pack(pady=(10, 0))
        tk.Label(progress_frame, text=f"Question {self.current_q+1} of {len(self.questions)}", font=('Segoe UI', 13, 'bold'), fg=PRIMARY, bg=CARD).pack(side='left', padx=(0, 10))
        progress_bar = tk.Canvas(progress_frame, width=200, height=12, bg=DISABLED, highlightthickness=0)
        progress_bar.pack(side='left')
        progress_bar.create_rectangle(0, 0, 2*progress.get(), 12, fill=PRIMARY, width=0)

        tk.Label(frame, text=question['question'], font=('Segoe UI', 17, 'bold'), fg=TEXT, bg=CARD, wraplength=540, justify='left').pack(pady=(10, 18))
        options = [question['optionA'], question['optionB'], question['optionC'], question['optionD']]

        # Ensure user_answers has a slot for every question
        while len(self.user_answers) < len(self.questions):
            self.user_answers.append(None)
        self.selected_option = self.user_answers[self.current_q]
        self.option_buttons = []
        self.feedback_label = None

        def select_option(idx):
            # Save answer immediately
            self.selected_option = idx + 1
            self.user_answers[self.current_q] = self.selected_option

            for i, btn in enumerate(self.option_buttons):
                if i == idx:
                    btn.config(bg=PRIMARY, fg="white")
                else:
                    btn.config(bg="white", fg=PRIMARY)

            # Show feedback
            correct_option = int(str(question['answer']).strip())
            option_keys = ['optionA', 'optionB', 'optionC', 'optionD']
            correct_option_idx = correct_option - 1
            if self.selected_option == correct_option:
                feedback = "Correct!"
                color = ACCENT
            else:
                if 0 <= correct_option_idx < 4:
                    correct_option_text = question[option_keys[correct_option_idx]]
                else:
                    correct_option_text = ""
                feedback = f"Incorrect! Correct answer: {correct_option}. {correct_option_text}"
                color = DANGER
            self.feedback_label.config(text=feedback, fg=color)

            # Disable all buttons
            for btn in self.option_buttons:
                btn.config(state='disabled')

            # Automatically go to next question or submit after 1 second
            def go_next():
                if self.current_q < len(self.questions) - 1:
                    self.current_q += 1
                    self.show_question()
                else:
                    self.submit_answers()
            self.root.after(1000, go_next)

        for idx, option in enumerate(options):
            btn = tk.Button(frame, text=f"{idx+1}. {option}", width=48, anchor='w', font=('Segoe UI', 13, 'bold'), bg='white', fg=PRIMARY, bd=1, relief='ridge', cursor="hand2", highlightthickness=0, command=lambda i=idx: select_option(i))
            btn.pack(pady=7, padx=30)
            btn.bind("<Enter>", lambda e, b=btn: b.config(bg="#e0e7ef") if b['state'] == 'normal' else None)
            btn.bind("<Leave>", lambda e, b=btn: b.config(bg="white" if self.selected_option != self.option_buttons.index(b)+1 else PRIMARY, fg=PRIMARY if self.selected_option != self.option_buttons.index(b)+1 else "white") if b['state'] == 'normal' else None)
            self.option_buttons.append(btn)

        # Feedback label
        self.feedback_label = tk.Label(frame, text="", font=('Segoe UI', 13, 'bold'), bg=CARD)
        self.feedback_label.pack(pady=(10, 0))

        # Restore previous answer if navigating back
        if self.user_answers[self.current_q] is not None:
            idx = self.user_answers[self.current_q] - 1
            for i, btn in enumerate(self.option_buttons):
                if i == idx:
                    btn.config(bg=PRIMARY, fg="white", state='disabled')
                else:
                    btn.config(bg="white", fg=PRIMARY, state='disabled')
            correct_option = int(str(question['answer']).strip())
            if self.user_answers[self.current_q] == correct_option:
                feedback = "Correct!"
                color = ACCENT
            else:
                feedback = f"Incorrect! Correct answer: {correct_option}. {question[f'option{correct_option}']}"

                color = DANGER
            self.feedback_label.config(text=feedback, fg=color)

        # Navigation buttons
        nav_frame = tk.Frame(frame, bg=CARD)
        nav_frame.pack(side='bottom', fill='x', pady=(10, 0))

        def prev_question():
            if self.current_q > 0:
                self.current_q -= 1
                self.show_question()

        def next_question():
            if self.user_answers[self.current_q] is None:
                messagebox.showwarning("Select an answer", "Please select an answer before proceeding.")
                return
            if self.current_q < len(self.questions) - 1:
                self.current_q += 1
                self.show_question()
            elif self.current_q == len(self.questions) - 1:
                self.submit_answers()

        btn_prev = AnimatedButton(nav_frame, text='Previous', width=100, command=prev_question)
        btn_prev.pack(side='left', padx=(20, 10), pady=10)

        # Change button text to "Submit" on last question
        next_text = 'Submit' if self.current_q == len(self.questions) - 1 else 'Next'
        btn_next = AnimatedButton(nav_frame, text=next_text, width=120, command=next_question)
        btn_next.pack(side='right', padx=(10, 20), pady=10)

    def submit_answers(self):
        self.clear()
        frame = tk.Frame(self.root, bg=CARD, bd=0, relief='flat', highlightbackground=PRIMARY, highlightthickness=2)
        frame.place(relx=0.5, rely=0.5, anchor='center', width=500, height=340)

        # Calculate score and prepare DB save, robust answer comparison for current test only
        username = "student"  # You can enhance this to use actual student username
        user_answers_db = []
        score = 0
        for i, answer in enumerate(self.user_answers):
            q = self.questions[i]
            correct_option = str(q['answer']).strip()
            selected_option = answer
            is_correct = 0
            try:
                idx = int(answer)
                if correct_option == str(idx):
                    is_correct = 1
            except Exception:
                pass
            if not is_correct:
                try:
                    idx = int(answer) - 1
                    options = [q['optionA'], q['optionB'], q['optionC'], q['optionD']]
                    if 0 <= idx < 4 and str(options[idx]).strip().lower() == str(q[f'option{correct_option}']).strip().lower():
                        is_correct = 1
                except Exception:
                    pass
            user_answers_db.append({
                'question_id': q['id'],
                'selected_option': answer,
                'is_correct': is_correct
            })
            if is_correct:
                score += 1
        self.save_user_answers(username, user_answers_db)
        total = len(self.questions)
        percent = (score / total) * 100 if total else 0
        status = "PASS" if percent >= 40 else "FAIL"
        status_color = ACCENT if status == "PASS" else DANGER

        # Show result for this test only
        tk.Label(frame, text='Quiz Results', font=('Segoe UI', 28, 'bold'), fg=PRIMARY, bg=CARD).pack(pady=(25, 5))
        tk.Label(frame, text=f'Score: {score} / {total}', font=('Segoe UI', 18, 'bold'), fg=PRIMARY, bg=CARD).pack(pady=(10, 5))
        tk.Label(frame, text=f'Percentage: {percent:.0f}%', font=('Segoe UI', 16), fg=PRIMARY, bg=CARD).pack(pady=(0, 5))
        tk.Label(frame, text=f'Status: {status}', font=('Segoe UI', 18, 'bold'), fg=status_color, bg=CARD).pack(pady=(0, 15))

        def back_to_dashboard():
            # Reset state for next test attempt
            self.questions = []
            self.user_answers = []
            self.current_q = 0
            self.current_test_id = None
            self.student_dashboard()

        btn_dash = AnimatedButton(frame, text='Back to Dashboard', width=180, command=back_to_dashboard)
        btn_dash.pack(pady=10)

if __name__ == '__main__':
    root = tk.Tk()
    root.geometry('750x650')
    root.configure(bg=BG)
    app = QuizApp(root)
    root.mainloop()