import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:shangrila/models/timesheet_model.dart';
import 'package:shangrila/screens/add_edit_timesheet_screen.dart';
import 'package:shangrila/services/timesheet_service.dart';

class TimesheetScreen extends StatelessWidget {
  const TimesheetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Timesheets'),
      ),
      body: StreamProvider<List<Timesheet>>.value(
        value: Provider.of<TimesheetService>(context).getTimesheets(),
        initialData: const [],
        child: Consumer<List<Timesheet>>(
          builder: (context, timesheets, child) {
            if (timesheets.isEmpty) {
              return const Center(
                child: Text('No timesheets yet. Add one!'),
              );
            }
            return ListView.builder(
              itemCount: timesheets.length,
              itemBuilder: (context, index) {
                final timesheet = timesheets[index];
                return ListTile(
                  title: Text('Project: ${timesheet.projectId}'),
                  subtitle: Text(
                      '${DateFormat.yMd().format(timesheet.date)} - ${timesheet.hours} hours'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      Provider.of<TimesheetService>(context, listen: false)
                          .deleteTimesheet(timesheet.id);
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddEditTimesheetScreen(
                          timesheet: timesheet,
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
              builder: (context) => const AddEditTimesheetScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
