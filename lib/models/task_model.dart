import 'package:equatable/equatable.dart';

class TaskModel extends Equatable {
  String title;
  String description;
  String asignee;
  String dueDate;
  String priority;
  String status;
  String assigner;
  String id;

  TaskModel(this.title, this.description, this.asignee, this.dueDate,
      this.priority, this.status, this.assigner, this.id);

  TaskModel copyWith(
    String? title,
    String? description,
    String? asignee,
    String? dueDate,
    String? priority,
    String? status,
    String? assigner,
    String? id,
  ) {
    return TaskModel(
      title ?? this.title,
      description ?? this.description,
      asignee ?? this.asignee,
      dueDate ?? this.dueDate,
      priority ?? this.priority,
      status ?? this.status,
      assigner ?? this.assigner,
      id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'asignee': asignee,
      'dueDate': dueDate,
      'priority': priority,
      'status': status,
      'assigner': assigner,
      'id': id,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      map['title'] ?? '',
      map['description'] ?? '',
      map['asignee'] ?? '',
      map['dueDate'] ?? '',
      map['priority'] ?? '',
      map['status'] ?? '',
      map['assigner'] ?? '',
      map['id'] ?? '',
    );
  }

  @override
  List<Object?> get props =>
      [title, description, asignee, dueDate, priority, status, assigner, id];
}
