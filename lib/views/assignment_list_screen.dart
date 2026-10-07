import 'package:flutter/material.dart';
import '../presenters/assignment_presenter.dart';
import '../presenters/course_presenter.dart';
import '../widgets/add_fab.dart';

class AssignmentListScreen extends StatefulWidget{
  const AssignmentListScreen({super.key});

  @override
  State<AssignmentListScreen> createState() => _AssignmentListScreenState();
}

class _AssignmentListScreenState extends State<AssignmentListScreen> {
  final AssignmentPresenter _presenter = AssignmentPresenter();
  final CoursePresenter _coursePresenter = CoursePresenter();

  bool _isLoading = true;
  String? _selectedCourseFilter;
  String? _newAssignmentCourse;
  List<String> _courseNames = [];

  @override
  void initState() {
    super.initState();
    //_loadAssignments and Courses();
    _loadData();
  }

  Future<void> _loadData() async {
    await _presenter.loadAssignments();
    await _coursePresenter.loadCourses();
    setState(() {
      _isLoading = false;
      _courseNames = _coursePresenter.courses.map((c) => c.name).toList();
    });
  }

  void _showAddAssignmentDialog() {
    String newAssignmentTitle = '';
    _newAssignmentCourse = _courseNames.isNotEmpty ? _courseNames.first : null;

    showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setDialogState){
          return AlertDialog(
            title: const Text('Add Assignment'),

            content: Column(mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Enter assignment title'
                ),

                onChanged: (value){
                  newAssignmentTitle = value;
                },
              ),
              const SizedBox(height: 10),
              DropdownButton<String>(
                value: _newAssignmentCourse,
                isExpanded: true,

                items: _courseNames.map((courseName) {
                  return DropdownMenuItem<String>(
                    value: courseName,
                    child: Text(courseName),
                  );
                }).toList(),

                onChanged: (value) {
                  setDialogState(() {
                    _newAssignmentCourse = value;
                  });
                },
              ),
            ],
          ),


          //content: TextField(
            //autofocus: true,
            //decoration: const InputDecoration(hintText: 'Enter assignment title'),
            //onChanged: (value){
              //newAssignmentTitle = value;
            //},
          //),

            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),

              TextButton(
                onPressed: () async {
                  if (newAssignmentTitle.trim().isNotEmpty && _newAssignmentCourse != null) {
                    await _presenter.addAssignment(newAssignmentTitle.trim(), _newAssignmentCourse!,
                    );
                    setState(() {});
                    Navigator.pop(context); // Close dialog
                  }
                },
                child: const Text('Add'),
              ),
            ],
          );
        },
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    final assignments = _presenter.assignments;

    final displayedAssignments = _selectedCourseFilter == null
        ? assignments
        : assignments
          .where(
            (assignment) =>
              assignment.courseName ==_selectedCourseFilter,
          )
          .toList();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 162, 199, 229),

      appBar: AppBar(
        title: const Text('Assignments'),
        actions: [
          if (_courseNames.isNotEmpty)
          DropdownButton<String>(
            hint: const Text('Filter by Course',
              style: TextStyle(color: Colors.white)
            ),
            dropdownColor: Colors.blue,
            value: _selectedCourseFilter,
            onChanged: (value) {
              setState(() {
                _selectedCourseFilter = value;
              });
            },
            items: [
              const DropdownMenuItem<String>(
                value: null,
                child: Text('All Courses'),
              ),
              ..._courseNames.map((courseName)=>
                DropdownMenuItem(value:courseName, child: Text(courseName)),
              ),
            ],
          )
        ]
      ),

      body: _isLoading?
      const Center(child: CircularProgressIndicator(),):
      ListView.builder(
        itemCount: displayedAssignments.length,
        itemBuilder:(context, index) {
          final assignment = displayedAssignments[index];
          final originalIndex = _presenter.assignments.indexOf(assignment);

          return CheckboxListTile(
            title: Text(
              assignment.title,
              style: TextStyle(
                decoration: assignment.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
              ),
            ),

            subtitle: Text('Course: ${assignment.courseName}'),
            value: assignment.isCompleted,
            onChanged: (value) async {
              await _presenter.toggleCompleted(originalIndex);
              setState(() {
              });
            },

            secondary: IconButton(
              icon: const Icon(Icons.delete),

              onPressed: () async {
                await _presenter.deleteAssignment(originalIndex);
                setState(() {});
              },
            ),
          );
        },
      ),

      floatingActionButton: AddFAB(
        onPressed: _showAddAssignmentDialog, // use the dialog function
      ),
    );
  }
}