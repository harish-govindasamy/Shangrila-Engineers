import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shangrila/models/project_model.dart';
import 'package:shangrila/screens/add_project_screen.dart';
import 'package:shangrila/screens/project_details_screen.dart';
import 'package:shangrila/services/firestore_service.dart';

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final firestoreService = Provider.of<FirestoreService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Projects'),
      ),
      body: StreamProvider<List<Project>>.value(
        value: firestoreService.getProjects(),
        initialData: const [],
        child: Consumer<List<Project>>(
          builder: (context, projects, child) {
            if (projects.isEmpty) {
              return const Center(
                child: Text('No projects yet. Add one!'),
              );
            }
            return ListView.builder(
              itemCount: projects.length,
              itemBuilder: (context, index) {
                final project = projects[index];
                return ListTile(
                  title: Text(project.name),
                  subtitle: Text(project.description),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProjectDetailsScreen(
                          project: project,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
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
}
