import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shangrila/models/project_model.dart';
import 'package:shangrila/screens/add_project_screen.dart';
import 'package:shangrila/screens/project_detail_screen.dart';
import 'package:shangrila/services/firestore_service.dart';

class ProjectListScreen extends StatelessWidget {
  const ProjectListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final firestoreService = Provider.of<FirestoreService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Projects'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddProjectScreen()),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Project>>(
        stream: firestoreService.getProjects(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No projects found.'));
          }

          final projects = snapshot.data!;

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
                      builder: (context) => ProjectDetailScreen(project: project),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
