import 'package:flutter_test/flutter_test.dart';
import 'package:homework_tracker/models/assignment_model.dart';

void main(){
  test('New assignemtn should default to isCompleted = false',() {
    final assignment = Assignment(title: 'Test Assignment', courseName: 'Math');
    expect(assignment.isCompleted, false);
  });

  test('Assignmetn should store title and courseName correctly',(){
    final assignment = Assignment(title: 'Essay', courseName: 'Math');
    expect(assignment.title, 'Essay');
    expect(assignment.courseName, 'Math');
  });
}