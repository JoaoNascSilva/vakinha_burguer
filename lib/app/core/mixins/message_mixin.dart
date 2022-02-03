import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin MessagesMixin on GetxController {
  void messageListener(Rxn<MessageModel> message) {
    ever<MessageModel?>(
      message,
      (model) async {
        if (model != null) {
          Get.snackbar(
            model.title,
            model.message,
            backgroundColor: model.type.color(),
            colorText: model.type.textColor(),
            margin: const EdgeInsets.all(20),
            overlayBlur: 1,
            icon: Icon(
              model.type == MessageType.info ? Icons.check_circle : Icons.error,
              size: 24,
              color: Colors.white,
            ),
          );
        }
      },
    );
  }
}

class MessageModel {
  final String title;
  final String message;
  final MessageType type;

  MessageModel({
    required this.title,
    required this.message,
    required this.type,
  });
}

enum MessageType { error, info }

extension MessageTypeColorExt on MessageType {
  Color color() {
    switch (this) {
      case MessageType.error:
        return const Color(0xFFD22367);
      case MessageType.info:
        return const Color(0xFF6FCF97);
    }
  }

  Color textColor() {
    switch (this) {
      case MessageType.error:
        return Colors.white;
      case MessageType.info:
        return Colors.white;
    }
  }
}
