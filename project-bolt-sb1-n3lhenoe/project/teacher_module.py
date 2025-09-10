import tkinter as tk
from tkinter import ttk, messagebox, filedialog
import pandas as pd
from ui_components import UIComponents
from database import DatabaseManager
import requests

class TeacherLogin:
    def __init__(self, root, main_app):
        """Initialize teacher login interface"""
        self.root = root
        self.main_app = main_app
        self.db = DatabaseManager()
        
        # Hard-coded credentials
        self.TEACHER_ID = "abc"
        self.TEACHER_PASSWORD = "123"
        
        self.setup_login_ui()
    
    def setup_login_ui(self):
        """Setup teacher login user interface"""
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
        title = UIComponents.create_title_label(main_frame, "Teacher Login", 28)
        title.pack(pady=(0, 40))
        
        # Login form
        form_frame = tk.Frame(main_frame, bg=UIComponents.COLORS['white'])
        form_frame.pack()
        
        # User ID
        tk.Label(form_frame, text="User ID:", font=('Arial', 14), 
                bg=UIComponents.COLORS['white'], fg=UIComponents.COLORS['dark_gray']).pack(pady=(0, 5))
        self.userid_entry = UIComponents.create_styled_entry(form_frame)
        self.userid_entry.pack(pady=(0, 20), ipady=8, ipadx=10)
        
        # Password
        tk.Label(form_frame, text="Password:", font=('Arial', 14),
                bg=UIComponents.COLORS['white'], fg=UIComponents.COLORS['dark_gray']).pack(pady=(0, 5))
        self.password_entry = UIComponents.create_styled_entry(form_frame, show="*")
        self.password_entry.pack(pady=(0, 30), ipady=8, ipadx=10)
        
        # Submit button
        submit_btn = UIComponents.create_styled_button(
            form_frame, "Login", self.validate_login, 'blue', 20, 2
        )
        submit_btn.pack(pady=(0, 20))
        
        # Back button
        back_btn = UIComponents.create_styled_button(
            form_frame, "Back", self.main_app.show_main_menu, 'red', 20, 2
        )
        back_btn.pack()
    
    def validate_login(self):
        """Validate teacher login credentials"""
        userid = self.userid_entry.get().strip()
        password = self.password_entry.get().strip()
        
        if userid == self.TEACHER_ID and password == self.TEACHER_PASSWORD:
            self.show_teacher_dashboard()
        else:
            messagebox.showerror("Login Failed", "Invalid credentials!")
            self.userid_entry.delete(0, tk.END)
            self.password_entry.delete(0, tk.END)
    
    def show_teacher_dashboard(self):
        """Show teacher dashboard for file upload"""
        # Clear the window
        for widget in self.root.winfo_children():
            widget.destroy()
        
        self.root.configure(bg=UIComponents.COLORS['light_gray'])
        
        # Main container
        main_frame = tk.Frame(self.root, bg=UIComponents.COLORS['white'], relief='raised', bd=2)
        main_frame.pack(expand=True, fill='both', padx=30, pady=30)
        
        # Header
        header_frame = tk.Frame(main_frame, bg=UIComponents.COLORS['blue'], height=80)
        header_frame.pack(fill='x', padx=20, pady=(20, 0))
        header_frame.pack_propagate(False)
        
        title = tk.Label(header_frame, text="Teacher Dashboard", 
                        font=('Arial', 24, 'bold'), fg=UIComponents.COLORS['white'], 
                        bg=UIComponents.COLORS['blue'])
        title.pack(expand=True)
        
        # Content area
        content_frame = tk.Frame(main_frame, bg=UIComponents.COLORS['white'])
        content_frame.pack(expand=True, fill='both', padx=20, pady=20)
        
        # Instructions
        instructions = tk.Label(content_frame, 
                               text="Upload Excel file with columns: questions, option1, option2, option3, option4, correct_option",
                               font=('Arial', 12), fg=UIComponents.COLORS['dark_gray'],
                               bg=UIComponents.COLORS['white'], wraplength=600)
        instructions.pack(pady=(0, 30))
        
        # File selection area
        file_frame = tk.Frame(content_frame, bg=UIComponents.COLORS['light_gray'], relief='solid', bd=1)
        file_frame.pack(fill='x', pady=(0, 20), ipady=20)
        
        self.file_label = tk.Label(file_frame, text="No file selected", 
                                  font=('Arial', 12), fg=UIComponents.COLORS['dark_gray'],
                                  bg=UIComponents.COLORS['light_gray'])
        self.file_label.pack(pady=10)
        
        # Buttons
        button_frame = tk.Frame(content_frame, bg=UIComponents.COLORS['white'])
        button_frame.pack()
        
        select_btn = UIComponents.create_styled_button(
            button_frame, "Select File", self.select_file, 'green', 15, 2
        )
        select_btn.pack(side='left', padx=(0, 10))
        
        self.deploy_btn = UIComponents.create_styled_button(
            button_frame, "Deploy Test", self.deploy_test, 'blue', 15, 2
        )
        self.deploy_btn.pack(side='left', padx=(0, 10))
        self.deploy_btn.config(state='disabled')
        
        logout_btn = UIComponents.create_styled_button(
            button_frame, "Logout", self.main_app.show_main_menu, 'red', 15, 2
        )
        logout_btn.pack(side='left')
        
 # New Fetch button
        fetch_btn = UIComponents.create_styled_button(
            button_frame, "Fetch Data", self.fetch_dummy_data, 'orange', 15, 2
        )
        fetch_btn.pack(side='left', padx=(10, 0))

        # Preview area
        self.preview_frame = tk.Frame(content_frame, bg=UIComponents.COLORS['white'])
        self.preview_frame.pack(expand=True, fill='both', pady=(20, 0))
        
        self.selected_file = None
    
    def select_file(self):
        """Select and preview Excel file"""
        file_path = filedialog.askopenfilename(
            title="Select Excel File",
            filetypes=[("Excel files", "*.xlsx *.xls")]
        )
        
        if file_path:
            self.selected_file = file_path
            filename = file_path.split('/')[-1]
            self.file_label.config(text=f"Selected: {filename}")
            self.deploy_btn.config(state='normal')
            self.preview_excel(file_path)
    
    def fetch_dummy_data(self):
        """Fetch data from dummy GET API with Basic Authentication"""
          # keep at top if not already imported

        try:
            username = "sb-39ba86cb-3a4c-4ce2-9f93-bda40cc6d455!b79388|it-rt-d5c58c13trial!b196"
            password = "479686a7-96f3-41b0-b50e-01a9147a283e$jEB3O1YmhkCYrwgWs4ga5pVnfs2TISgecmj-8CBRyus="

            response = requests.get(
                "https://d5c58c13trial.it-cpitrial03-rt.cfapps.ap21.hana.ondemand.com/http/quiz_iflow2",
                auth=(username, password),
                headers={"Accept": "application/json"},
            )   

            if response.status_code == 200:
                data = response.json()
                messagebox.showinfo(
                    "Fetched Data",
                    f"✅ Request Successful!\n\nTitle: {data['title']}\n\nBody: {data['body']}"
                )
                print ("Fetched Data:", data)  # Log to console
            elif response.status_code == 401:
                messagebox.showerror("Authentication Failed", "Invalid credentials provided!")
            else:
                messagebox.showerror("Error", f"Failed! Status: {response.status_code}")

        except Exception as e:
            messagebox.showerror("Error", f"Request failed: {str(e)}")


    def preview_excel(self, file_path):
        """Preview Excel file content"""
        try:
            # Clear previous preview
            for widget in self.preview_frame.winfo_children():
                widget.destroy()
            
            # Read Excel file
            df = pd.read_excel(file_path)
            
            # Create preview label
            preview_label = tk.Label(self.preview_frame, text="File Preview:", 
                                   font=('Arial', 14, 'bold'), fg=UIComponents.COLORS['blue'],
                                   bg=UIComponents.COLORS['white'])
            preview_label.pack(anchor='w', pady=(0, 10))
            
            # Create treeview for data display
            tree_frame = tk.Frame(self.preview_frame)
            tree_frame.pack(expand=True, fill='both')
            
            tree = ttk.Treeview(tree_frame)
            tree.pack(side='left', expand=True, fill='both')
            
            # Scrollbars
            v_scrollbar = ttk.Scrollbar(tree_frame, orient='vertical', command=tree.yview)
            v_scrollbar.pack(side='right', fill='y')
            tree.configure(yscrollcommand=v_scrollbar.set)
            
            h_scrollbar = ttk.Scrollbar(self.preview_frame, orient='horizontal', command=tree.xview)
            h_scrollbar.pack(fill='x')
            tree.configure(xscrollcommand=h_scrollbar.set)
            
            # Configure columns
            tree['columns'] = list(df.columns)
            tree['show'] = 'headings'
            
            for col in df.columns:
                tree.heading(col, text=col)
                tree.column(col, width=150)
            
            # Insert data
            for _, row in df.iterrows():
                tree.insert('', 'end', values=list(row))
                
        except Exception as e:
            messagebox.showerror("Preview Error", f"Error previewing file: {str(e)}")
    
    def deploy_test(self):
        """Deploy the selected test to database"""
        if not self.selected_file:
            messagebox.showerror("Error", "Please select a file first!")
            return
        
        # Get test name from user
        test_name = tk.simpledialog.askstring("Test Name", "Enter a name for this test:")
        if not test_name:
            return
        
        # Upload to database
        success, message = self.db.upload_excel_data(self.selected_file, test_name)
        
        if success:
            messagebox.showinfo("Success", message)
            self.selected_file = None
            self.file_label.config(text="No file selected")
            self.deploy_btn.config(state='disabled')
            # Clear preview
            for widget in self.preview_frame.winfo_children():
                widget.destroy()
        else:
            messagebox.showerror("Error", message)