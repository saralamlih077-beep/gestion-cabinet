"""
Login System
Professional login interface for Medical Cabinet System
"""

import customtkinter as ctk
from tkinter import messagebox
import sys
sys.path.append('/home/ubuntu/medical_cabinet')

from config.theme import COLORS, THEME
from config.db_config import DatabaseConfig
from dashboard.secretaire_dashboard import SecretaireDashboard
from dashboard.doctor_dashboard import DoctorDashboard


class LoginWindow(ctk.CTk):
    """
    Login window class
    """
    
    def __init__(self):
        super().__init__()
        
        # Configure window
        self.title("Login - Cabinet Médical")
        self.geometry("1000x600")
        self.resizable(False, False)
        
        # Set appearance mode
        ctk.set_appearance_mode(THEME["appearance_mode"])
        ctk.set_default_color_theme("blue")
        
        # Initialize database connection
        self.db_config = DatabaseConfig()
        self.connection = None
        
        # Current user
        self.current_user = None
        
        # Create UI
        self.create_widgets()
        
    def create_widgets(self):
        """
        Create login interface widgets
        """
        # Main frame with gradient background
        self.main_frame = ctk.CTkFrame(
            self,
            fg_color=COLORS['gray_light'],
            corner_radius=0
        )
        self.main_frame.pack(fill="both", expand=True)
        
        # Left side - Branding
        self.left_frame = ctk.CTkFrame(
            self.main_frame,
            fg_color=COLORS['primary'],
            corner_radius=0
        )
        self.left_frame.pack(side="left", fill="both", expand=False, padx=0, pady=0)
        self.left_frame.configure(width=400)
        
        # Branding content
        self.branding_frame = ctk.CTkFrame(
            self.left_frame,
            fg_color="transparent"
        )
        self.branding_frame.pack(expand=True, fill="both", padx=60, pady=80)
        
        # Logo
        self.logo_label = ctk.CTkLabel(
            self.branding_frame,
            text="🏥",
            font=("Segoe UI", 80),
            text_color=COLORS['white']
        )
        self.logo_label.pack(pady=(0, 20))
        
        # Brand name
        self.brand_label = ctk.CTkLabel(
            self.branding_frame,
            text="Cabinet Médical",
            font=("Segoe UI", 32, "bold"),
            text_color=COLORS['white']
        )
        self.brand_label.pack(pady=(0, 10))
        
        # Tagline
        self.tagline_label = ctk.CTkLabel(
            self.branding_frame,
            text="Système de gestion professionnelle",
            font=("Segoe UI", 16),
            text_color=COLORS['white'],
            wraplength=250
        )
        self.tagline_label.pack(pady=(0, 30))
        
        # Right side - Login form
        self.right_frame = ctk.CTkFrame(
            self.main_frame,
            fg_color=COLORS['white'],
            corner_radius=0
        )
        self.right_frame.pack(side="right", fill="both", expand=True, padx=0, pady=0)
        
        # Login form
        self.login_frame = ctk.CTkFrame(
            self.right_frame,
            fg_color="transparent"
        )
        self.login_frame.pack(expand=True, fill="both", padx=80, pady=80)
        
        # Title
        self.title_label = ctk.CTkLabel(
            self.login_frame,
            text="Connexion",
            font=("Segoe UI", 28, "bold"),
            text_color=COLORS['text_primary']
        )
        self.title_label.pack(pady=(0, 40))
        
        # Username field
        self.username_label = ctk.CTkLabel(
            self.login_frame,
            text="Nom d'utilisateur",
            font=("Segoe UI", 12, "bold"),
            text_color=COLORS['text_secondary'],
            anchor="w"
        )
        self.username_label.pack(fill="x", pady=(0, 5))
        
        self.username_entry = ctk.CTkEntry(
            self.login_frame,
            placeholder_text="Entrez votre nom d'utilisateur",
            font=("Segoe UI", 14),
            height=40,
            corner_radius=6,
            fg_color=COLORS['gray_light'],
            border_color=COLORS['gray'],
            border_width=1
        )
        self.username_entry.pack(fill="x", pady=(0, 20))
        
        # Password field
        self.password_label = ctk.CTkLabel(
            self.login_frame,
            text="Mot de passe",
            font=("Segoe UI", 12, "bold"),
            text_color=COLORS['text_secondary'],
            anchor="w"
        )
        self.password_label.pack(fill="x", pady=(0, 5))
        
        self.password_entry = ctk.CTkEntry(
            self.login_frame,
            placeholder_text="Entrez votre mot de passe",
            font=("Segoe UI", 14),
            show="*",
            height=40,
            corner_radius=6,
            fg_color=COLORS['gray_light'],
            border_color=COLORS['gray'],
            border_width=1
        )
        self.password_entry.pack(fill="x", pady=(0, 20))
        
        # Role selection
        self.role_label = ctk.CTkLabel(
            self.login_frame,
            text="Rôle",
            font=("Segoe UI", 12, "bold"),
            text_color=COLORS['text_secondary'],
            anchor="w"
        )
        self.role_label.pack(fill="x", pady=(0, 5))
        
        self.role_var = ctk.StringVar(value="secretaire")
        
        self.role_frame = ctk.CTkFrame(
            self.login_frame,
            fg_color="transparent"
        )
        self.role_frame.pack(fill="x", pady=(0, 20))
        
        self.secretaire_radio = ctk.CTkRadioButton(
            self.role_frame,
            text="Secrétaire",
            variable=self.role_var,
            value="secretaire",
            font=("Segoe UI", 12),
            fg_color=COLORS['primary'],
            hover_color=COLORS['primary_dark']
        )
        self.secretaire_radio.pack(side="left", padx=(0, 20))
        
        self.doctor_radio = ctk.CTkRadioButton(
            self.role_frame,
            text="Docteur",
            variable=self.role_var,
            value="doctor",
            font=("Segoe UI", 12),
            fg_color=COLORS['secondary'],
            hover_color=COLORS['secondary_dark']
        )
        self.doctor_radio.pack(side="left")
        
        # Login button
        self.login_button = ctk.CTkButton(
            self.login_frame,
            text="Se Connecter",
            font=("Segoe UI", 14, "bold"),
            height=45,
            corner_radius=6,
            fg_color=COLORS['primary'],
            hover_color=COLORS['primary_dark'],
            command=self.login
        )
        self.login_button.pack(fill="x", pady=(20, 0))
        
        # Forgot password link
        self.forgot_link = ctk.CTkLabel(
            self.login_frame,
            text="Mot de passe oublié ?",
            font=("Segoe UI", 10, "underline"),
            text_color=COLORS['primary'],
            cursor="hand2"
        )
        self.forgot_link.pack(pady=(10, 0))
        self.forgot_link.bind("<Button-1>", lambda e: self.show_forgot_password())
        
    def login(self):
        """
        Handle user login
        """
        username = self.username_entry.get().strip()
        password = self.password_entry.get().strip()
        role = self.role_var.get()
        
        # Validation
        if not username or not password:
            messagebox.showerror("Erreur", "Veuillez remplir tous les champs")
            return
        
        # Connect to database
        self.connection = self.db_config.connect()
        
        if not self.connection:
            messagebox.showerror("Erreur", "Impossible de se connecter à la base de données")
            return
        
        try:
            cursor = self.connection.cursor(dictionary=True)
            
            # Query user
            query = "SELECT * FROM users WHERE username = %s AND password = %s AND role = %s"
            cursor.execute(query, (username, password, role))
            user = cursor.fetchone()
            
            if user:
                self.current_user = user
                self.destroy_login()
                self.open_dashboard(role)
            else:
                messagebox.showerror("Erreur", "Nom d'utilisateur, mot de passe ou rôle incorrect")
                
        except Exception as e:
            messagebox.showerror("Erreur", f"Erreur lors de la connexion: {e}")
        
        finally:
            if cursor:
                cursor.close()
            if self.connection:
                self.db_config.close_connection(self.connection)
                self.connection = None
    
    def destroy_login(self):
        """
        Close login window
        """
        self.destroy()
    
    def open_dashboard(self, role):
        """
        Open appropriate dashboard based on role
        
        Args:
            role: User role ('secretaire' or 'doctor')
        """
        if role == 'secretaire':
            dashboard = SecretaireDashboard(self.current_user)
        else:
            dashboard = DoctorDashboard(self.current_user)
        
        dashboard.mainloop()
    
    def show_forgot_password(self):
        """
        Show forgot password dialog
        """
        messagebox.showinfo(
            "Mot de passe oublié",
            "Veuillez contacter l'administrateur du système pour réinitialiser votre mot de passe."
        )


if __name__ == "__main__":
    app = LoginWindow()
    app.mainloop()
