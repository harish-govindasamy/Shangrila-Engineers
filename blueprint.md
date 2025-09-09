# Shangri-La Project Management App

## Overview

Shangri-La is a project management application built with Flutter and Firebase. It provides a simple and intuitive interface for managing projects, tasks, and team members. The app supports different user roles, including admin, principal, and employee, each with their own set of permissions and views.

## Features

*   **Authentication:** Users can sign in with their email and password. New users are automatically created if they don't exist.
*   **Dashboard:** A central hub for admins and principals to get an overview of the projects, including total projects and other metrics.
*   **Project Management:** Create, view, update, and delete projects. Each project has a name, description, and a team of users.
*   **Task Management:** Within each project, users can create and manage tasks.
*   **User Management:** Admins can manage user roles, assigning them as admin, principal, or employee.
*   **Timesheets:** Employees can log their time spent on different tasks.

## Style and Design

*   **Theme:** The app uses a modern and clean theme with a primary color of deep purple and a secondary color of teal. It supports both light and dark modes.
*   **Typography:** The app uses the Google Fonts library to provide a clean and readable typography.
*   **Layout:** The app uses a combination of lists, grids, and cards to display information in a clear and organized way.
*   **Interactivity:** The app uses a variety of interactive elements, including buttons, text fields, and dropdowns, to provide a user-friendly experience.

## Technical Details

*   **Framework:** Flutter
*   **Backend:** Firebase (Authentication, Firestore, Cloud Storage)
*   **State Management:** Provider
*   **Routing:** `go_router`

