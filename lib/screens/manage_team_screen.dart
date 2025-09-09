import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shangrila/models/project_model.dart';
import 'package:shangrila/models/user_model.dart';
import 'package:shangrila/services/firestore_service.dart';

class ManageTeamScreen extends StatefulWidget {
  final Project project;

  const ManageTeamScreen({super.key, required this.project});

  @override
  State<ManageTeamScreen> createState() => _ManageTeamScreenState();
}

class _ManageTeamScreenState extends State<ManageTeamScreen> {
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final firestoreService = Provider.of<FirestoreService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Team'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Team Member Email',
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final email = _emailController.text.trim();
                if (email.isNotEmpty) {
                  final user = await firestoreService.getUserByEmail(email);
                  if (user != null) {
                    final updatedProject = widget.project;
                    if (!updatedProject.teamMembers.contains(user.uid)) {
                      updatedProject.teamMembers.add(user.uid);
                      await firestoreService.updateProject(
                          updatedProject.id, updatedProject);
                    }
                    _emailController.clear();
                  } else {
                    // Show error message
                  }
                }
              },
              child: const Text('Add Team Member'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Team Members',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: StreamBuilder<List<AppUser>>(
                stream: firestoreService.getUsers(widget.project.teamMembers),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No team members found.'));
                  }

                  final teamMembers = snapshot.data!;

                  return ListView.builder(
                    itemCount: teamMembers.length,
                    itemBuilder: (context, index) {
                      final member = teamMembers[index];
                      return ListTile(
                        title: Text(member.displayName),
                        subtitle: Text(member.email),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () async {
                            final updatedProject = widget.project;
                            updatedProject.teamMembers.remove(member.uid);
                            await firestoreService.updateProject(
                                updatedProject.id, updatedProject);
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
    );
  }
}
