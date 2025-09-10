import tkinter as tk
from tkinter import ttk, messagebox, filedialog
import os

class UIComponents:
    """Reusable UI components with Google color scheme"""
    
    # Google Colors
    COLORS = {
        'blue': '#4285F4',
        'red': '#EA4335', 
        'yellow': '#FBBC05',
        'green': '#34A853',
        'white': '#FFFFFF',
        'light_gray': '#F8F9FA',
        'dark_gray': '#5F6368',
        'light_blue': '#E8F0FE',
        "orange": "#FFA500"
    }
    
    @staticmethod
    def create_styled_button(parent, text, command, bg_color='blue', width=15, height=2):
        """Create a styled button with Google colors"""
        button = tk.Button(
            parent,
            text=text,
            command=command,
            bg=UIComponents.COLORS[bg_color],
            fg=UIComponents.COLORS['white'],
            font=('Arial', 12, 'bold'),
            width=width,
            height=height,
            relief='flat',
            cursor='hand2'
        )
        
        # Hover effects
        def on_enter(e):
            button.config(bg=UIComponents.darken_color(UIComponents.COLORS[bg_color]))
        
        def on_leave(e):
            button.config(bg=UIComponents.COLORS[bg_color])
        
        button.bind("<Enter>", on_enter)
        button.bind("<Leave>", on_leave)
        
        return button
    
    @staticmethod
    def create_styled_entry(parent, placeholder="", show=None):
        """Create a styled entry widget"""
        entry = tk.Entry(
            parent,
            font=('Arial', 12),
            bg=UIComponents.COLORS['white'],
            fg=UIComponents.COLORS['dark_gray'],
            relief='solid',
            bd=1,
            show=show
        )
        return entry
    
    @staticmethod
    def create_title_label(parent, text, size=24):
        """Create a styled title label"""
        label = tk.Label(
            parent,
            text=text,
            font=('Arial', size, 'bold'),
            fg=UIComponents.COLORS['blue'],
            bg=UIComponents.COLORS['white']
        )
        return label
    
    @staticmethod
    def create_logo_frame(parent):
        """Create a logo frame with Google colors"""
        logo_frame = tk.Frame(parent, bg=UIComponents.COLORS['white'])
        
        # Create Google-style logo
        colors = ['blue', 'red', 'yellow', 'blue', 'green', 'red']
        letters = ['Q', 'U', 'I', 'Z', 'Z', 'Y']
        
        for i, (letter, color) in enumerate(zip(letters, colors)):
            label = tk.Label(
                logo_frame,
                text=letter,
                font=('Arial', 32, 'bold'),
                fg=UIComponents.COLORS[color],
                bg=UIComponents.COLORS['white']
            )
            label.pack(side='left')
        
        return logo_frame
    
    @staticmethod
    def darken_color(color):
        """Darken a hex color for hover effects"""
        color = color.lstrip('#')
        rgb = tuple(int(color[i:i+2], 16) for i in (0, 2, 4))
        darkened = tuple(max(0, c - 30) for c in rgb)
        return f"#{darkened[0]:02x}{darkened[1]:02x}{darkened[2]:02x}"