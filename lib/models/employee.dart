class Employee {
  final String firstName;
  final String lastName;
  final DateTime dob;
  final String maritalStatus;
  final String contactNumber;
  final String address;
  final String? email;

  Employee({
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.maritalStatus,
    required this.contactNumber,
    required this.address,
    this.email,
  });
}
