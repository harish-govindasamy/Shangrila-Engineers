# Shangri-La Project Management App

## Overview

This document outlines the development of the Shangri-La project management system. This is a Flutter application with a Firebase backend, designed to manage projects, tasks, and users. The system now includes user authentication, role-based access control, timesheet management for employees, and a dashboard for admins and principals.

## Implemented Features

### Reporting

*   **PDF Generation:**
    *   Users can generate a PDF report of a project and its tasks from the `ProjectDetailsScreen`.
    *   The report includes the project's name, description, and a table of tasks with their status (completed or incomplete).
*   **Excel Generation:**
    *   Users can generate an Excel report of a project and its tasks from the `ProjectDetailsScreen`.
    *   The report includes the project's name, description, and a list of tasks with their status.

### Dashboard (Admin & Principal)

*   **Modern UI:** Redesigned with a clean, modern interface.
*   **Welcome Message:** Greets the logged-in user.
*   **Project Metrics:** Displays key metrics, such as the total number of projects, in visually appealing cards.
*   **Project Overview:**
    *   Displays a list of all projects from Firestore in individual cards.
    *   Includes a search bar to filter projects by name.
*   **User Management Access:**
    *   Provides a button to navigate to the User Management screen.

### User Management (Admin & Principal)

*   **Card-Based Layout:** Each user is displayed in a separate card for a cleaner and more organized look.
*   **Clear Information Hierarchy:** User's name, email, and role are presented in a clear and easy-to-read format.
*   **Role Management:**
    *   Allows Admins and Principals to change a user's role via a dropdown menu in the user list.

### User Management & Authentication

*   **Authentication:**
    *   Users can log in with their email and password.
    *   `AuthService` handles all Firebase Authentication interactions.
    *   `AuthWrapper` widget manages the authentication state, showing the login screen or the main application based on the user's login status.

*   **Password Reset:**
    *   Users can request a password reset email from the login screen.
    *   A dedicated screen allows users to enter their email to receive the reset link.

*   **Role-based Navigation:**
    *   Users are redirected to a specific screen based on their role after logging in.
    *   `Admin` and `Principal` roles are directed to the `DashboardScreen`.
    *   `Employee` role is directed to the `TimesheetScreen`.

*   **User Roles:**
    *   Three user roles are defined: `Admin`, `Principal`, and `Employee`.
    *   `UserRole` enum provides a clear and type-safe way to manage roles.

*   **User Data:**
    *   `UserModel` class represents the user data stored in Firestore.
    *   `UserService` manages the creation, retrieval, and streaming of user documents in the 'users' collection, and includes a method to update user roles.

### Timesheet Management (Employee)

*   **Timesheet Model:**
    *   `Timesheet` model represents a single timesheet entry with project ID, date, hours, and notes.
*   **Timesheet Service:**
    *   `TimesheetService` manages all Firestore interactions for timesheets.
    *   Timesheet data is stored in a subcollection within each user's document for security and organization.
*   **Timesheet Screen:**
    *   Displays a list of the current user's timesheet entries.
    *   Allows users to delete existing entries.
    *   Provides a floating action button to add new entries.
*   **Add/Edit Timesheet Screen:**
    *   A single screen for both creating and updating timesheet entries.
    *   Includes a form with fields for project, date, hours, and notes.

### Core Functionality

*   **Project Management (CRUD):**
    *   **Create:** Add new projects with a name, description, start date, and end date.
    *   **Read:** View a list of all projects.
    *   **Update:** Edit the details of an existing project.
    *   **Delete:** Remove projects from the database.

*   **Task Management (CRUD):**
    *   **Create:** Add new tasks with a name and description to a specific project.
    *   **Read:** View a list of all tasks within a project's detail screen.
    *   **Update:** Mark tasks as complete or incomplete.
    *   **Delete:** Remove tasks from a project.

### User Interface & Navigation

*   **Login Screen:** A visually engaging login screen with a gradient background and modern UI elements.
*   **Password Reset Screen:** A screen for users to request a password reset link.
*   **Dashboard Screen:** A central hub for `Admin` and `Principal` users with a redesigned, card-based layout for projects and key metrics.
*   **User Management Screen:** A screen for `Admin` and `Principal` users to view and manage user roles in a card-based layout.
*   **Project Screen:** Displays a list of all projects from Firestore.
*   **Add Project Screen:** A form to create a new project.
*   **Project Details Screen:** Shows the details of a selected project and a list of its tasks, with an improved layout and visual hierarchy. It also includes options to generate PDF and Excel reports.
*   **Edit Project Screen:** A form to update the information of an existing project.
*   **Add Task Screen:** A form to add a new task to a project.

### Backend & Data

*   **Firebase Firestore:** Used as the backend database to store and manage project, task, and user data.
*   **Services:** Dedicated service classes (`FirestoreService`, `AuthService`, `UserService`, `TimesheetService`) encapsulate all interactions with Firebase, providing a clean API for the UI.
*   **Data Models:** `Project`, `Task`, `UserModel`, and `Timesheet` models are used to structure the data.

### Style and Design

*   **UI:** Built using Material Design 3 components with a focus on a polished and modern aesthetic.
*   **Visual Enhancements:** The UI now features gradient backgrounds, card-based layouts, and improved visual hierarchy to create a more engaging and intuitive user experience.
*   **State Management:** `provider` is used to manage services and stream data from Firestore to the UI.

