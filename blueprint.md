# Shangrila Engineers - Project Management System

## Overview

This document outlines the development plan for the Shangrila Engineers project management system. This is a comprehensive Flutter application with a Firebase backend, designed to manage employees, projects, timesheets, and customers with role-based access control.

## Implemented Features

*This section will be updated as features are implemented.*

### Style and Design
- **Branding:** "SHANGRILA ENGINEERS - THE STRUCTURAL ENGINEERS"
- **Color Scheme:** Blue gradient (#1565C0 to #0D47A1)
- **UI:** Material Design 3

## Current Plan: Initial Setup and Authentication

### 1. Project Setup
- Add necessary dependencies to `pubspec.yaml`:
    - `firebase_core`: For Firebase initialization.
    - `firebase_auth`: For user authentication.
    - `cloud_firestore`: For database.
    - `provider`: For state management.
    - `fl_chart`: For dashboard charts.
    - `google_fonts`: For custom fonts.
    - `pdf`: For PDF reporting.
    - `excel`: For Excel reporting.
- Configure Firebase in the Flutter project.
- Set up the main application structure.

### 2. UI and Theme
- Implement the base theme using Material Design 3.
- Use a blue gradient color scheme as specified.
- Use `google_fonts` for custom typography.
- Create a `ThemeProvider` to manage light/dark modes.

### 3. Authentication
- Create a basic login screen with email and password fields.
- Set up a basic home screen.
- Implement navigation between the login and home screens.
- Create a basic authentication service using `provider`.
