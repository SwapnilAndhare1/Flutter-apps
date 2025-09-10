import tkinter as tk
from tkinter import ttk
import tkinter.simpledialog
from ui_components import UIComponents
from teacher_module import TeacherLogin
from student_module import StudentLogin
from database import DatabaseManager

class QuizApplication:
    def __init__(self):
        """Initialize the main quiz application"""
        self.root = tk.Tk()
        self.root.title("QUIZZY - Quiz Application")
        self.root.geometry("1000x700")
        self.root.configure(bg=UIComponents.COLORS['white'])
        
        # Initialize database
        self.db = DatabaseManager()
        
        # Center the window
        self.center_window()
        
        # Show main menu
        self.show_main_menu()
    
    def center_window(self):
        """Center the application window on screen"""
        self.root.update_idletasks()
        width = self.root.winfo_width()
        height = self.root.winfo_height()
        x = (self.root.winfo_screenwidth() // 2) - (width // 2)
        y = (self.root.winfo_screenheight() // 2) - (height // 2)
        self.root.geometry(f'{width}x{height}+{x}+{y}')
    
    def show_main_menu(self):
        """Display the main menu with login options"""
        # Clear the window
        for widget in self.root.winfo_children():
            widget.destroy()
        
        self.root.configure(bg=UIComponents.COLORS['white'])
        
        # Main container
        main_frame = tk.Frame(self.root, bg=UIComponents.COLORS['white'])
        main_frame.pack(expand=True, fill='both')
        
        # Logo section
        logo_frame = UIComponents.create_logo_frame(main_frame)
        logo_frame.pack(pady=(80, 40))
        
        # Welcome message
        welcome_label = tk.Label(main_frame, text="Welcome to Quiz Application", 
                               font=('Arial', 28, 'bold'), fg=UIComponents.COLORS['dark_gray'],
                               bg=UIComponents.COLORS['white'])
        welcome_label.pack(pady=(0, 60))
        
        # Login options
        login_frame = tk.Frame(main_frame, bg=UIComponents.COLORS['white'])
        login_frame.pack()
        
        # Teacher login button
        teacher_btn = UIComponents.create_styled_button(
            login_frame, "Teacher Login", self.show_teacher_login, 'blue', 20, 3
        )
        teacher_btn.pack(pady=15)
        
        # Student login button
        student_btn = UIComponents.create_styled_button(
            login_frame, "Student Login", self.show_student_login, 'green', 20, 3
        )
        student_btn.pack(pady=15)
        
        # Exit button
        exit_btn = UIComponents.create_styled_button(
            login_frame, "Exit", self.root.quit, 'red', 20, 3
        )
        exit_btn.pack(pady=15)
    
    def show_teacher_login(self):
        """Show teacher login interface"""
        TeacherLogin(self.root, self)
    
    def show_student_login(self):
        """Show student login interface"""
        StudentLogin(self.root, self)
    
    def run(self):
        """Start the application"""
        self.root.mainloop()

if __name__ == "__main__":
    # Create and run the application
    app = QuizApplication()
    app.run()