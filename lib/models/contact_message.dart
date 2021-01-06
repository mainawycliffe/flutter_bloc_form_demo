class ContactMessage {
  final String name;
  final String email;
  final String phone;
  final String subject;
  final String message;

  ContactMessage({
    this.name,
    this.email,
    this.phone,
    this.subject,
    this.message,
  });

  static fromJson(Map<String, String> json) {
    return ContactMessage(
      name: json["name"],
      email: json["email"],
      phone: json["phone"],
      subject: json["subject"],
      message: json["message"],
    );
  }

  Map<String, String> toJson() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
      "subject": subject,
      "message": message,
    };
  }
}
