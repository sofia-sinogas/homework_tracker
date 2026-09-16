import 'package:flutter/material.dart';
import '../presenters/assignment_presenter.dart';

class AssignmentListScreen extends StatefulWidget{
  const AssignmentListScreen({super.key});

  @override
  State<AssignmentListScreen> createState() => _AssignmentListScreenState();
}

class _AssignmentListScreenState extends State<AssignmentListScreen> {
  final AssignmentPresenter _presenter = AssignmentPresenter();

  void _showAddAssignmentDialog() {
    String newAssignmentTitle = '';

    showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Add Assignment'),

        content: TextField(
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Enter assignment title'),
          onChanged: (value){
            newAssignmentTitle = value;
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: (){
              if (newAssignmentTitle.trim().isNotEmpty) {
                _presenter.addAssignment(newAssignmentTitle.trim());
                Navigator.pop(context); // Close dialog
              }
            },
            child: const Text('Add'),
          ),
        ],
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    final assignments = _presenter.assignments;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 162, 199, 229),
      appBar: AppBar(title: const Text('Assignments')),
      body: ListView.builder(
        itemCount: assignments.length,
        itemBuilder:(context, index) {
          final assignment = assignments[index];
          return CheckboxListTile(
            title: Text(assignment.title),
            value: assignment.isCompleted,
            onChanged: (value) {
              setState(() {
                _presenter.toggleCompleted(index);
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddAssignmentDialog, // use the dialog function
        child: const Icon(Icons.add),
      ),
    );
  }
}



