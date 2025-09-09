import 'dart:io';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:shangrila/models/project_model.dart';
import 'package:shangrila/models/task_model.dart';
import 'package:shangrila/screens/add_task_screen.dart';
import 'package:shangrila/services/firestore_service.dart';

class ProjectDetailsScreen extends StatefulWidget {
  final Project project;

  const ProjectDetailsScreen({super.key, required this.project});

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  List<Task> _tasks = [];

  @override
  Widget build(BuildContext context) {
    final firestoreService = Provider.of<FirestoreService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.project.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: () => _generateReport(context),
            tooltip: 'Generate PDF Report',
          ),
          IconButton(
            icon: const Icon(Icons.description),
            onPressed: () => _generateExcelReport(),
            tooltip: 'Generate Excel Report',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.project.name,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              widget.project.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16.0),
            const Divider(),
            const SizedBox(height: 16.0),
            Text(
              'Tasks',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16.0),
            StreamProvider<List<Task>>.value(
              value: firestoreService.getTasks(widget.project.id),
              initialData: const [],
              child: Consumer<List<Task>>(
                builder: (context, tasks, child) {
                  _tasks = tasks;
                  if (tasks.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Column(
                          children: [
                            Icon(Icons.check_circle_outline, size: 64, color: Colors.grey),
                            SizedBox(height: 16.0),
                            Text(
                              'No tasks yet. Add one!',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ListTile(
                          title: Text(task.name, style: TextStyle(decoration: task.isCompleted ? TextDecoration.lineThrough : TextDecoration.none)),
                          subtitle: Text(task.description),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Checkbox(
                                value: task.isCompleted,
                                onChanged: (value) {
                                  firestoreService.updateTask(
                                    widget.project.id,
                                    Task(
                                      id: task.id,
                                      name: task.name,
                                      description: task.description,
                                      isCompleted: value!,
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  firestoreService.deleteTask(widget.project.id, task.id);
                                },
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddTaskScreen(projectId: widget.project.id),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _generateReport(BuildContext context) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) => [
          pw.Header(
            level: 0,
            child: pw.Text(widget.project.name, style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
          ),
          pw.Paragraph(
            text: widget.project.description,
            style: const pw.TextStyle(fontSize: 14),
          ),
          pw.SizedBox(height: 20),
          pw.Text('Tasks', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 10),
          pw.TableHelper.fromTextArray(
            headers: ['Task', 'Description', 'Status'],
            data: _tasks
                .map((task) => [task.name, task.description, task.isCompleted ? 'Completed' : 'Incomplete'])
                .toList(),
            border: pw.TableBorder.all(),
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            cellAlignment: pw.Alignment.centerLeft,
            cellStyle: const pw.TextStyle(fontSize: 10),
          ),
        ],
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  Future<void> _generateExcelReport() async {
    final excel = Excel.createExcel();
    final sheet = excel['Sheet1'];

    sheet.cell(CellIndex.indexByString('A1')).value = TextCellValue(widget.project.name);
    sheet.cell(CellIndex.indexByString('A2')).value = TextCellValue(widget.project.description);

    sheet.cell(CellIndex.indexByString('A4')).value = TextCellValue('Task');
    sheet.cell(CellIndex.indexByString('B4')).value = TextCellValue('Description');
    sheet.cell(CellIndex.indexByString('C4')).value = TextCellValue('Status');

    for (var i = 0; i < _tasks.length; i++) {
      final task = _tasks[i];
      sheet.cell(CellIndex.indexByString('A${i + 5}')).value = TextCellValue(task.name);
      sheet.cell(CellIndex.indexByString('B${i + 5}')).value = TextCellValue(task.description);
      sheet.cell(CellIndex.indexByString('C${i + 5}')).value = TextCellValue(task.isCompleted ? 'Completed' : 'Incomplete');
    }

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/${widget.project.name}_report.xlsx');
    await file.writeAsBytes(excel.encode()!);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Excel report saved to ${file.path}'),
      ),
    );
  }
}
