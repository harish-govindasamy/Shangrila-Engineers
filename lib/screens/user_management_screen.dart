import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shangrila/models/user_model.dart';
import 'package:shangrila/models/user_role.dart';
import 'package:shangrila/services/user_service.dart';

class UserManagementScreen extends StatelessWidget {
  const UserManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Management'),
      ),
      body: StreamProvider<List<UserModel>>.value(
        value: userService.getUsers(),
        initialData: const [],
        child: Consumer<List<UserModel>>(
          builder: (context, users, child) {
            if (users.isEmpty) {
              return const Center(
                child: Text('No users found.'),
              );
            }
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name.isNotEmpty ? user.name : 'No Name',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          user.email,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Role:', style: TextStyle(fontWeight: FontWeight.bold)),
                            DropdownButton<UserRole>(
                              value: user.role,
                              items: UserRole.values.map((UserRole role) {
                                return DropdownMenuItem<UserRole>(
                                  value: role,
                                  child: Text(role.toString().split('.').last),
                                );
                              }).toList(),
                              onChanged: (UserRole? newRole) {
                                if (newRole != null) {
                                  userService.updateUserRole(user.uid, newRole);
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
