import '../models/assignment_model.dart';

class AssignmentPresenter {
  final List<Assignment> _assignments = [];

  List<Assignment> get assignments => _assignments;

  Future<void> addAssignment(String title, String courseName) async {
    await Assignment.addAssignment(title, courseName);
    _assignments.add(Assignment(title: title, courseName: courseName));
    }

  Future<void> toggleCompleted(int index) async {
    await Assignment.updateCompletedStatus(index, _assignments);
      _assignments[index].isCompleted = !_assignments[index].isCompleted;
  }

  Future<void> loadAssignments() async {
    final fetchedAssignments = await Assignment.getAssignments();
    _assignments.clear();
    _assignments.addAll(fetchedAssignments);
  }

  Future<void> deleteAssignment(int index) async {
    await Assignment.deleteAssignment(index, _assignments);
    _assignments.removeAt(index);
  }
}