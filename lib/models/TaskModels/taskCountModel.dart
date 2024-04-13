import 'dart:convert';

import 'package:flutter/material.dart';

class TaskCountListModel {
  String? status;
  List<TaskCount>? taskCountList;

  TaskCountListModel({this.status, this.taskCountList});
  TaskCountListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskCountList = <TaskCount>[];
      json['data'].forEach((v) {
        taskCountList!.add(TaskCount.fromJson(v));
      });
    }
  }
}

class TaskCount {
  String? id;
  int? sum;

  TaskCount({this.id, this.sum});

  TaskCount.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    sum = json['sum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['sum'] = sum;
    return data;
  }
}

class TaskListModel {
  String? status;
  List<Task>? taskList;

  TaskListModel({this.status, this.taskList});
}

class Task {
  String? id; // Add task_id field
  var username;
  String? title;
  String? description;
  String? status;
  String? date;
  String? userImage;
  int? color;
  String? startTime;
  String? dueTime;

  Task({
    this.id, // Include task_id in the constructor
    this.username,
    this.title,
    this.description,
    this.status,
    this.date,
    this.userImage,
    this.color,
    this.startTime,
    this.dueTime,

  });

  // Define a factory constructor to create a Task object from JSON
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'].toString(), // Assign task_id from JSON
      username: json['username'] ?? '',
      title: json['title'],
      description: json['description'],
      status: json['status'],
      date: json['date'],
      userImage: json['photo'],
      color: json['color'],
      startTime: json['startTime'],
      dueTime: json['dueTime'],
    );
  }

  // Convert Task object to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['title'] = title;
    data['description'] = description;
    data['status'] = status;
    data['date'] = date;
    data['photo'] = userImage;
    data['color'] = color;
    data['startTime'] = startTime;
    data['dueTime'] = dueTime;
    return data;
  }
}

