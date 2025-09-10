import tkinter as tk
from tkinter import ttk, messagebox
from ui_components import UIComponents
from database import DatabaseManager

class StudentLogin:
    def __init__(self, root, main_app):
        """Initialize student login interface"""
        self.root = root
        self.main_app = main_app
        self.db = DatabaseManager()
        self.current_student = None
        
        self.setup_login_ui()
    
    def setup_login_ui(self):
        """Setup student login user interface"""
        # Clear the window
        for widget in self.root.winfo_children():
            widget.destroy()
        
        self.root.configure(bg=UIComponents.COLORS['white'])
        
        # Main container
        main_frame = tk.Frame(self.root, bg=UIComponents.COLORS['white'])
        main_frame.pack(expand=True, fill='both', padx=50, pady=50)
        
        # Logo
        logo_frame = UIComponents.create_logo_frame(main_frame)
        logo_frame.pack(pady=(0, 30))
        
        # Title
        title = UIComponents.create_title_label(main_frame, "Student Login", 28)
        title.pack(pady=(0, 40))
        
        # Login form
        form_frame = tk.Frame(main_frame, bg=UIComponents.COLORS['white'])
        form_frame.pack()
        
        # Username
        tk.Label(form_frame, text="Username:", font=('Arial', 14), 
                bg=UIComponents.COLORS['white'], fg=UIComponents.COLORS['dark_gray']).pack(pady=(0, 5))
        self.username_entry = UIComponents.create_styled_entry(form_frame)
        self.username_entry.pack(pady=(0, 20), ipady=8, ipadx=10)
        
        # Password
        tk.Label(form_frame, text="Password:", font=('Arial', 14),
                bg=UIComponents.COLORS['white'], fg=UIComponents.COLORS['dark_gray']).pack(pady=(0, 5))
        self.password_entry = UIComponents.create_styled_entry(form_frame, show="*")
        self.password_entry.pack(pady=(0, 30), ipady=8, ipadx=10)
        
        # Submit button
        submit_btn = UIComponents.create_styled_button(
            form_frame, "Login", self.validate_login, 'green', 20, 2
        )
        submit_btn.pack(pady=(0, 20))
        
        # Back button
        back_btn = UIComponents.create_styled_button(
            form_frame, "Back", self.main_app.show_main_menu, 'red', 20, 2
        )
        back_btn.pack()
    
    def validate_login(self):
        """Validate student login credentials"""
        username = self.username_entry.get().strip()
        password = self.password_entry.get().strip()
        
        if self.db.validate_student_login(username, password):
            self.current_student = username
            self.show_student_dashboard()
        else:
            messagebox.showerror("Login Failed", "Invalid credentials!")
            self.username_entry.delete(0, tk.END)
            self.password_entry.delete(0, tk.END)
    
    def show_student_dashboard(self):
        """Show student dashboard with available tests"""
        # Clear the window
        for widget in self.root.winfo_children():
            widget.destroy()
        
        self.root.configure(bg=UIComponents.COLORS['light_gray'])
        
        # Main container
        main_frame = tk.Frame(self.root, bg=UIComponents.COLORS['white'], relief='raised', bd=2)
        main_frame.pack(expand=True, fill='both', padx=30, pady=30)
        
        # Header
        header_frame = tk.Frame(main_frame, bg=UIComponents.COLORS['green'], height=80)
        header_frame.pack(fill='x', padx=20, pady=(20, 0))
        header_frame.pack_propagate(False)
        
        title = tk.Label(header_frame, text=f"Welcome, {self.current_student}!", 
                        font=('Arial', 24, 'bold'), fg=UIComponents.COLORS['white'], 
                        bg=UIComponents.COLORS['green'])
        title.pack(expand=True)
        
        # Content area
        content_frame = tk.Frame(main_frame, bg=UIComponents.COLORS['white'])
        content_frame.pack(expand=True, fill='both', padx=20, pady=20)
        
        # Dashboard title
        dashboard_title = tk.Label(content_frame, text="Available Tests", 
                                 font=('Arial', 18, 'bold'), fg=UIComponents.COLORS['blue'],
                                 bg=UIComponents.COLORS['white'])
        dashboard_title.pack(pady=(0, 20))
        
        # Tests container
        tests_frame = tk.Frame(content_frame, bg=UIComponents.COLORS['white'])
        tests_frame.pack(expand=True, fill='both')
        
        # Get available tests
        tests = self.db.get_all_tests()
        
        if not tests:
            no_tests_label = tk.Label(tests_frame, text="No tests available yet!", 
                                    font=('Arial', 16), fg=UIComponents.COLORS['dark_gray'],
                                    bg=UIComponents.COLORS['white'])
            no_tests_label.pack(expand=True)
        else:
            # Create test cards
            for i, test_name in enumerate(tests):
                self.create_test_card(tests_frame, test_name, i)
        
        # Logout button
        logout_btn = UIComponents.create_styled_button(
            content_frame, "Logout", self.main_app.show_main_menu, 'red', 15, 2
        )
        logout_btn.pack(pady=(20, 0))
    
    def create_test_card(self, parent, test_name, index):
        """Create a test card widget"""
        colors = ['blue', 'green', 'yellow', 'red']
        color = colors[index % len(colors)]
        
        card_frame = tk.Frame(parent, bg=UIComponents.COLORS[color], relief='raised', bd=2)
        card_frame.pack(fill='x', pady=10, padx=20)
        
        # Test info
        info_frame = tk.Frame(card_frame, bg=UIComponents.COLORS[color])
        info_frame.pack(side='left', expand=True, fill='both', padx=20, pady=15)
        
        test_label = tk.Label(info_frame, text=test_name, 
                            font=('Arial', 16, 'bold'), fg=UIComponents.COLORS['white'],
                            bg=UIComponents.COLORS[color])
        test_label.pack(anchor='w')
        
        # Get question count
        questions = self.db.get_test_questions(test_name)
        count_label = tk.Label(info_frame, text=f"{len(questions)} Questions", 
                             font=('Arial', 12), fg=UIComponents.COLORS['white'],
                             bg=UIComponents.COLORS[color])
        count_label.pack(anchor='w')
        
        # Start button
        start_btn = tk.Button(card_frame, text="Start Test", 
                            command=lambda: self.start_test(test_name),
                            bg=UIComponents.COLORS['white'], fg=UIComponents.COLORS[color],
                            font=('Arial', 12, 'bold'), relief='flat', cursor='hand2')
        start_btn.pack(side='right', padx=20, pady=15)
    
    def start_test(self, test_name):
        """Start the selected test"""
        questions = self.db.get_test_questions(test_name)
        if questions:
            QuizInterface(self.root, test_name, questions, self)
        else:
            messagebox.showerror("Error", "No questions found for this test!")

class QuizInterface:
    def __init__(self, root, test_name, questions, student_module):
        """Initialize quiz interface"""
        self.root = root
        self.test_name = test_name
        self.questions = questions
        self.student_module = student_module
        self.current_question = 0
        self.score = 0
        self.selected_answers = {}
        
        self.setup_quiz_ui()
    
    def setup_quiz_ui(self):
        """Setup quiz user interface"""
        # Clear the window
        for widget in self.root.winfo_children():
            widget.destroy()
        
        self.root.configure(bg=UIComponents.COLORS['white'])
        
        # Disable window close button during test
        self.root.protocol("WM_DELETE_WINDOW", self.disable_close)
        
        # Main container
        main_frame = tk.Frame(self.root, bg=UIComponents.COLORS['white'])
        main_frame.pack(expand=True, fill='both', padx=30, pady=30)
        
        # Header
        header_frame = tk.Frame(main_frame, bg=UIComponents.COLORS['blue'], height=60)
        header_frame.pack(fill='x', pady=(0, 20))
        header_frame.pack_propagate(False)
        
        self.progress_label = tk.Label(header_frame, 
                                     text=f"Question {self.current_question + 1} of {len(self.questions)}", 
                                     font=('Arial', 16, 'bold'), fg=UIComponents.COLORS['white'], 
                                     bg=UIComponents.COLORS['blue'])
        self.progress_label.pack(expand=True)
        
        # Question area
        self.question_frame = tk.Frame(main_frame, bg=UIComponents.COLORS['white'])
        self.question_frame.pack(expand=True, fill='both')
        
        self.display_question()
    
    def disable_close(self):
        """Disable window closing during test"""
        messagebox.showwarning("Test in Progress", "You cannot close the window during the test!")
    
    def display_question(self):
        """Display current question and options"""
        # Clear question frame
        for widget in self.question_frame.winfo_children():
            widget.destroy()
        
        if self.current_question >= len(self.questions):
            self.show_results()
            return
        
        question_data = self.questions[self.current_question]
        question_text = question_data[0]
        options = question_data[1:5]
        
        # Question text
        question_label = tk.Label(self.question_frame, text=question_text, 
                                font=('Arial', 16, 'bold'), fg=UIComponents.COLORS['dark_gray'],
                                bg=UIComponents.COLORS['white'], wraplength=600)
        question_label.pack(pady=(0, 30))
        
        # Options
        self.selected_option = tk.StringVar()
        
        for i, option in enumerate(options, 1):
            option_btn = tk.Radiobutton(self.question_frame, text=f"{i}. {option}",
                                      variable=self.selected_option, value=str(i),
                                      font=('Arial', 14), fg=UIComponents.COLORS['dark_gray'],
                                      bg=UIComponents.COLORS['white'], selectcolor=UIComponents.COLORS['light_blue'],
                                      command=self.option_selected)
            option_btn.pack(anchor='w', pady=10, padx=50)
        
        # Next button
        self.next_btn = UIComponents.create_styled_button(
            self.question_frame, "Next Question", self.next_question, 'blue', 15, 2
        )
        self.next_btn.pack(pady=(30, 0))
        self.next_btn.config(state='disabled')
    
    def option_selected(self):
        """Handle option selection"""
        self.next_btn.config(state='normal')
        
        # Change color of selected option
        for widget in self.question_frame.winfo_children():
            if isinstance(widget, tk.Radiobutton):
                if widget['value'] == self.selected_option.get():
                    widget.config(bg=UIComponents.COLORS['light_blue'])
                else:
                    widget.config(bg=UIComponents.COLORS['white'])
    
    def next_question(self):
        """Move to next question"""
        # Store answer
        selected = int(self.selected_option.get())
        correct_answer = self.questions[self.current_question][5]
        
        self.selected_answers[self.current_question] = selected
        
        # Check if answer is correct
        if selected == correct_answer:
            self.score += 1
        
        self.current_question += 1
        
        # Update progress
        if self.current_question < len(self.questions):
            self.progress_label.config(text=f"Question {self.current_question + 1} of {len(self.questions)}")
            self.display_question()
        else:
            self.show_results()
    
    def show_results(self):
        """Show test results"""
        # Clear the window
        for widget in self.root.winfo_children():
            widget.destroy()
        
        # Re-enable window close button
        self.root.protocol("WM_DELETE_WINDOW", self.root.destroy)
        
        self.root.configure(bg=UIComponents.COLORS['white'])
        
        # Calculate percentage
        percentage = (self.score / len(self.questions)) * 100
        
        # Main container
        main_frame = tk.Frame(self.root, bg=UIComponents.COLORS['white'])
        main_frame.pack(expand=True, fill='both', padx=50, pady=50)
        
        # Result icon and message
        if percentage >= 35:
            # Trophy icon (using text)
            icon_label = tk.Label(main_frame, text="🏆", font=('Arial', 72),
                                bg=UIComponents.COLORS['white'])
            icon_label.pack(pady=(0, 20))
            
            result_text = "Congratulations!"
            result_color = UIComponents.COLORS['green']
        else:
            # Broken flower icon (using text)
            icon_label = tk.Label(main_frame, text="🥀", font=('Arial', 72),
                                bg=UIComponents.COLORS['white'])
            icon_label.pack(pady=(0, 20))
            
            result_text = "Better luck next time!"
            result_color = UIComponents.COLORS['red']
        
        # Result message
        result_label = tk.Label(main_frame, text=result_text, 
                              font=('Arial', 24, 'bold'), fg=result_color,
                              bg=UIComponents.COLORS['white'])
        result_label.pack(pady=(0, 20))
        
        # Score display
        score_label = tk.Label(main_frame, text=f"Your Score: {self.score}/{len(self.questions)}", 
                             font=('Arial', 18), fg=UIComponents.COLORS['dark_gray'],
                             bg=UIComponents.COLORS['white'])
        score_label.pack(pady=(0, 10))
        
        percentage_label = tk.Label(main_frame, text=f"Percentage: {percentage:.1f}%", 
                                  font=('Arial', 18), fg=UIComponents.COLORS['dark_gray'],
                                  bg=UIComponents.COLORS['white'])
        percentage_label.pack(pady=(0, 40))
        
        # Back to dashboard button
        back_btn = UIComponents.create_styled_button(
            main_frame, "Back to Dashboard", self.back_to_dashboard, 'blue', 20, 2
        )
        back_btn.pack()
    
    def back_to_dashboard(self):
        """Return to student dashboard"""
        self.student_module.show_student_dashboard()