import '../chat_models/user_model.dart';

class Message {
  final User sender;
  final String time;
  final String text;
  final bool unread;

  Message({
    this.sender,
    this.time,
    this.text,
    this.unread,
  });
}

List<Message> chats = [
  Message(
    sender: Jerry,
    time: '5:30 PM',
    text: 'Hello! Just checking in to confirm our appointment in 20 minutes',
    unread: true,
  ),
  Message(
    sender: Shawn,
    time: '4:30 PM',
    text: 'Looking forward to speaking to you',
    unread: true,
  ),
  Message(
    sender: Catherine,
    time: '3:30 PM',
    text: 'Could you send me your latest draft of the third essay?',
    unread: false,
  ),
  Message(
    sender: Dana,
    time: '2:30 PM',
    text: 'Just emailed you the final version of your Common App essay',
    unread: true,
  ),
  Message(
    sender: Emma,
    time: '1:30 PM',
    text: 'I am doing my masters currently at Harvard!',
    unread: false,
  ),
  Message(
    sender: Hemang,
    time: '12:30 PM',
    text: 'I am looking for essay reviewers too',
    unread: false,
  ),
  Message(
    sender: Pranav,
    time: '12:30 PM',
    text:
        'Check out the worldwide database, you could find someone in India if you wanted',
    unread: false,
  ),
];

List<Message> messages = [
  Message(
    sender: Jerry,
    time: '9:30 PM',
    text: 'Hello! Just checking in to confirm our appointment in 20 minutes',
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: '4:30 PM',
    text: '100%. Super excited to speak to you.',
    unread: true,
  ),
  Message(
    sender: Jerry,
    time: '3:45 PM',
    text: 'We will discuss further when we speak',
    unread: true,
  ),
  Message(
    sender: Jerry,
    time: '3:15 PM',
    text: 'Hmmm. Lots of great colleges out there.',
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: '2:30 PM',
    text: 'Looking to target most top tier US colleges',
    unread: true,
  ),
  Message(
    sender: Jerry,
    time: '2:30 PM',
    text: 'Great. What are your target colleges?',
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: '2:02 PM',
    text: 'Hey there. Great to receive a prompt reply',
    unread: true,
  ),
  Message(
    sender: Jerry,
    time: '2:00 PM',
    text: 'Hello! Just saw your appointment booking',
    unread: true,
  ),
];
