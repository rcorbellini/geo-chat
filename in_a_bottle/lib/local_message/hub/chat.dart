import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:in_a_bottle/_shared/archtecture/base_model.dart';

import 'package:in_a_bottle/home/home_feed.dart';
import 'package:in_a_bottle/local_message/hub/chat_message.dart';
import 'package:in_a_bottle/local_message/local/local_dto.dart';
import 'package:in_a_bottle/user/user_dto.dart';

class Chat extends Equatable implements BaseModel, HomeFeed {
  final String selector;
  final Local local;
  final List<User> admin;
  final String title;
  final User createdBy;
  final List<ChatMessage> messageChat;

  Chat({
    this.selector,
    this.local,
    this.admin,
    this.title,
    this.createdBy,
    this.messageChat,
  });

  Chat copyWith({
    String selector,
    Local local,
    List<User> admin,
    String title,
    User createdBy,
    List<ChatMessage> messageChat,
  }) {
    return Chat(
      selector: selector ?? this.selector,
      local: local ?? this.local,
      admin: admin ?? this.admin,
      title: title ?? this.title,
      createdBy: createdBy ?? this.createdBy,
      messageChat: messageChat ?? this.messageChat,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'selector': selector,
      'local': local?.toMap(),
      'admin': admin?.map((x) => x?.toMap())?.toList(),
      'title': title,
      'createdBy': createdBy?.toMap(),
      'messageChat': messageChat?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Chat(
      selector: map['selector'] as String,
      local: Local.fromMap(map['local'] as Map<String, dynamic>),
      admin: List<User>.from((map['admin'] as Iterable<Map<String, dynamic>>)
          ?.map<User>((x) => User.fromMap(x))),
      title: map['title'] as String,
      createdBy: User.fromMap(map['createdBy'] as Map<String, dynamic>),
      messageChat: List<ChatMessage>.from(
          (map['messageChat'] as Iterable<Map<String, dynamic>>)
              ?.map<ChatMessage>((x) => ChatMessage.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Chat.fromJson(String source) =>
      Chat.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      selector,
      local,
      admin,
      title,
      createdBy,
      messageChat,
    ];
  }
}
