import 'dart:convert';

import 'package:yangpt/models/Message.dart';

class ChatCompletion {
  String id;
  String object;
  int created;
  String model;
  Map<String, int> usage;
  List<Choice> choices;

  ChatCompletion({
    required this.id,
    required this.object,
    required this.created,
    required this.model,
    required this.usage,
    required this.choices,
  });

  factory ChatCompletion.fromJson(Map<String, dynamic> json) {
    var choicesJson = json['choices'] as List;
    List<Choice> choices = choicesJson.map((choiceJson) => Choice.fromJson(choiceJson)).toList();

    return ChatCompletion(
      id: json['id'],
      object: json['object'],
      created: json['created'],
      model: json['model'],
      usage: Map<String, int>.from(json['usage']),
      choices: choices,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'object': object,
    'created': created,
    'model': model,
    'usage': usage,
    'choices': choices.map((choice) => choice.toJson()).toList(),
  };
}

class Choice {
  Message message;
  String finishReason;
  int index;

  Choice({
    required this.message,
    required this.finishReason,
    required this.index,
  });

  factory Choice.fromJson(Map<String, dynamic> json) {
    return Choice(
      message: Message.fromJson(json['message']),
      finishReason: json['finish_reason'],
      index: json['index'],
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message.toJson(),
    'finish_reason': finishReason,
    'index': index,
  };
}