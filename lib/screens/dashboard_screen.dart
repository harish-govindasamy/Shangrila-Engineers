import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shangrila/models/project_model.dart';
import 'package:shangrila/models/user_model.dart';
import 'package:shangrila/screens/user_management_screen.dart';
import 'package:shangrila/services/auth_service.dart';
import 'package:shangrila/services/firestore_service.dart';
import 'package:shangrila/screens/add_project_screen.dart';
import 'package:shangrila/screens/project_detail_screen.dart';
import 'package:shangrila/services/user_service.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final userService = Provider.of<UserService>(context, listen: false);
    final firestoreService = Provider.of<FirestoreService>(context);
    final user = Provider.of<User?>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserManagementScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authService.signOut();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder<AppUser?>(
              stream: userService.getUser(user!.uid),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    'Welcome, ${snapshot.data!.displayName}!',
                    style: Theme.of(context).textTheme.headlineSmall,
                  );
                } else {
                  return const Text('Welcome!');
                }
              },
            ),
            const SizedBox(height: 16.0),
            StreamBuilder<List<Project>>(
              stream: firestoreService.getProjects(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 16.0,
                    crossAxisSpacing: 16.0,
                    children: [
                      _buildMetricCard(context, 'Total Projects', snapshot.data!.length.toString()),
                      // Add more metric cards as needed
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            const SizedBox(height: 24.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Search Projects',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            StreamProvider<List<Project>>.value(
              value: firestoreService.getProjects(),
              initialData: const [],
              child: Consumer<List<Project>>(
                builder: (context, projects, child) {
                  final filteredProjects = projects
                      .where((project) => project.name
                          .toLowerCase()
                          .contains(_searchQuery.toLowerCase()))
                      .toList();
                  if (filteredProjects.isEmpty) {
                    return const Center(
                      child: Text('No projects found.'),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredProjects.length,
                    itemBuilder: (context, index) {
                      final project = filteredProjects[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ListTile(
                          title: Text(project.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(project.description),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProjectDetailScreen(
                                  project: project,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddProjectScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildMetricCard(BuildContext context, String title, String value) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(title, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
