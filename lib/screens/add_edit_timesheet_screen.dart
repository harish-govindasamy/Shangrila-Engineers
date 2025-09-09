import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:shangrila/models/timesheet_model.dart';
import 'package:shangrila/services/timesheet_service.dart';

class AddEditTimesheetScreen extends StatefulWidget {
  final Timesheet? timesheet;

  const AddEditTimesheetScreen({super.key, this.timesheet});

  @override
  State<AddEditTimesheetScreen> createState() => _AddEditTimesheetScreenState();
}

class _AddEditTimesheetScreenState extends State<AddEditTimesheetScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _projectId;
  late DateTime _date;
  late double _hours;
  late String _notes;

  @override
  void initState() {
    super.initState();
    _projectId = widget.timesheet?.projectId ?? '';
    _date = widget.timesheet?.date ?? DateTime.now();
    _hours = widget.timesheet?.hours ?? 0.0;
    _notes = widget.timesheet?.notes ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.timesheet == null ? 'Add Timesheet' : 'Edit Timesheet'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _projectId,
                decoration: const InputDecoration(
                  labelText: 'Project ID',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a project ID';
                  }
                  return null;
                },
                onSaved: (value) => _projectId = value!,
              ),
              const SizedBox(height: 16.0),
              ListTile(
                title: Text('Date: ${DateFormat.yMd().format(_date)}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _date,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _date = pickedDate;
                    });
                  }
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                initialValue: _hours.toString(),
                decoration: const InputDecoration(
                  labelText: 'Hours',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) => _hours = double.parse(value!),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                initialValue: _notes,
                decoration: const InputDecoration(
                  labelText: 'Notes',
                ),
                onSaved: (value) => _notes = value!,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final timesheetService =
                        Provider.of<TimesheetService>(context, listen: false);
                    if (widget.timesheet == null) {
                      timesheetService.addTimesheet(
                        Timesheet(
                          id: '', // Firestore will generate the ID
                          projectId: _projectId,
                          date: _date,
                          hours: _hours,
                          notes: _notes,
                        ),
                      );
                    } else {
                      timesheetService.updateTimesheet(
                        Timesheet(
                          id: widget.timesheet!.id,
                          projectId: _projectId,
                          date: _date,
                          hours: _hours,
                          notes: _notes,
                        ),
                      );
                    }
                    Navigator.pop(context);
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
