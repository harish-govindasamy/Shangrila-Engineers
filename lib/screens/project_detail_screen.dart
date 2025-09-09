import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shangrila/models/project_model.dart';
import 'package:shangrila/models/task_model.dart';
import 'package:shangrila/models/user_model.dart';
import 'package:shangrila/screens/add_task_screen.dart';
import 'package:shangrila/screens/manage_team_screen.dart';
import 'package:shangrila/services/firestore_service.dart';

class ProjectDetailScreen extends StatelessWidget {
  final Project project;

  const ProjectDetailScreen({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final firestoreService = Provider.of<FirestoreService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(project.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.group_add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ManageTeamScreen(project: project),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              project.description,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Start Date: ${DateFormat.yMd().format(project.startDate)}'),
            const SizedBox(height: 10),
            Text('End Date: ${DateFormat.yMd().format(project.endDate)}'),
            const SizedBox(height: 20),
            const Text(
              'Team Members',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 100,
              child: StreamBuilder<List<AppUser>>(
                stream: firestoreService.getUsers(project.teamMembers),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No team members yet.'));
                  }

                  final teamMembers = snapshot.data!;

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: teamMembers.length,
                    itemBuilder: (context, index) {
                      final member = teamMembers[index];
                      return Chip(
                        label: Text(member.displayName),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Tasks',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: StreamBuilder<List<Task>>(
                stream: firestoreService.getTasks(project.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No tasks found.'));
                  }

                  final tasks = snapshot.data!;

                  return ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return ListTile(
                        title: Text(task.name),
                        subtitle: Text(task.description),
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
              builder: (context) => AddTaskScreen(projectId: project.id),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
