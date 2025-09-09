
# Shangri-La Project Management

**A powerful, intuitive project management application built with Flutter and Firebase to streamline your workflow and enhance team collaboration.**

<p align="center">
  <img src="https://placehold.co/800x400?text=Shangri-La+App" alt="Shangri-La App Banner">
</p>

<p align="center">
  <img alt="GitHub stars" src="https://img.shields.io/github/stars/your-username/shangrila?style=for-the-badge">
  <img alt="GitHub forks" src="https://img.shields.io/github/forks/your-username/shangrila?style=for-the-badge">
  <img alt="License" src="https://img.shields.io/github/license/your-username/shangrila?style=for-the-badge">
  <img alt="Flutter" src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white">
  <img alt="Firebase" src="https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black">
</p>

---

## 🌟 Overview

Shangri-La is a feature-rich project management tool designed to bring clarity and efficiency to your team's projects. With a clean, modern interface and a robust backend powered by Firebase, it provides a seamless experience for managing everything from high-level project planning to granular task details. The application supports distinct user roles—Admin, Principal, and Employee—each with a tailored interface and specific permissions to ensure a focused and secure workflow.

## ✨ Key Features

*   **🔐 Authentication:** Secure email and password sign-in. New users are seamlessly onboarded.
*   **📊 Dynamic Dashboard:** A centralized hub for Admins and Principals to gain at-a-glance insights into project status, team allocation, and key metrics.
*   **🗂️ Comprehensive Project Management:** Effortlessly create, view, update, and delete projects. Assign teams, set descriptions, and track progress from a single location.
*   **📝 Detailed Task Management:** Within each project, create and manage tasks with clear ownership and status tracking.
*   **👥 User Role Management:** Admins have full control over user roles, with the ability to assign permissions for Admins, Principals, and Employees.
*   **⏰ Timesheet Logging:** Employees can easily log hours against specific tasks, providing valuable data for project costing and resource planning.
*   **📱 Responsive Design:** A consistent and intuitive experience across both mobile and web platforms.
*   **🎨 Customizable Themes:** Supports both light and dark modes to suit user preferences.

## 📸 Screenshots

<p align="center">
  <img src="https://placehold.co/300x600?text=Login+Screen" alt="Login Screen" width="200"/>
  <img src="https://placehold.co/300x600?text=Dashboard" alt="Dashboard" width="200"/>
  <img src="https://placehold.co/300x600?text=Project+Details" alt="Project Details" width="200"/>
</p>

## 🛠️ Tech Stack

*   **Frontend:** [Flutter](https://flutter.dev/)
*   **Backend & Authentication:** [Firebase](https://firebase.google.com/) (Authentication, Firestore, Cloud Storage)
*   **State Management:** [Provider](https://pub.dev/packages/provider)
*   **Routing:** [go_router](https://pub.dev/packages/go_router)
*   **Typography:** [Google Fonts](https://pub.dev/packages/google_fonts)

## 🚀 Getting Started

Follow these instructions to get a copy of the project up and running on your local machine for development and testing purposes.

### **Prerequisites**

*   [Flutter SDK](https://flutter.dev/docs/get-started/install) (Version 3.x.x or higher)
*   [Firebase CLI](https://firebase.google.com/docs/cli)
*   An IDE such as [VS Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio).

### **Installation**

1.  **Clone the repository:**
    ```sh
    git clone https://github.com/your-username/shangrila.git
    cd shangrila
    ```

2.  **Set up Firebase:**
    *   Go to the [Firebase Console](https://console.firebase.google.com/) and create a new project.
    *   Register your Flutter app for Android, iOS, and Web.
    *   Run the `flutterfire configure` command from your project root and follow the CLI prompts:
        ```sh
        flutterfire configure
        ```
    *   This will automatically generate the `lib/firebase_options.dart` file with your project's Firebase configuration.

3.  **Install dependencies:**
    ```sh
    flutter pub get
    ```

4.  **Run the application:**
    ```sh
    flutter run
    ```

## 📂 Project Structure

The project follows a feature-first directory structure to promote scalability and separation of concerns.

```
shangrila/
├── lib/
│   ├── api/
│   ├── models/         # Data models (e.g., User, Project, Task)
│   ├── providers/      # State management (ChangeNotifiers)
│   ├── screens/        # UI for each screen (e.g., Login, Dashboard, ProjectDetails)
│   ├── services/       # Business logic and communication with Firebase
│   ├── utils/          # Utility functions and constants
│   ├── widgets/        # Reusable UI components (e.g., CustomButton, TaskCard)
│   ├── main.dart       # App entry point
│   └── routes.dart     # Navigation routes configuration
├── test/               # Unit and widget tests
└── pubspec.yaml        # Project dependencies and assets
```

## 🤝 Contributing

Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".

1.  Fork the Project
2.  Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3.  Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4.  Push to the Branch (`git push origin feature/AmazingFeature`)
5.  Open a Pull Request

## 📜 License

Distributed under the MIT License. See `LICENSE` for more information.

## 📧 Contact

Your Name - [@your_twitter](https://twitter.com/your_twitter) - your-email@example.com

Project Link: [https://github.com/your-username/shangrila](https://github.com/your-username/shangrila)

