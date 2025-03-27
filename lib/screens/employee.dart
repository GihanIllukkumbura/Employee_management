import 'package:employee_management_app/models/employee.dart';
import 'package:flutter/material.dart';

class EmployeeListPage extends StatefulWidget {
  const EmployeeListPage({super.key});

  @override
  State<EmployeeListPage> createState() => _EmployeeListPageState();
}

class _EmployeeListPageState extends State<EmployeeListPage> {
  List<Employee> employees = [
    Employee(
      firstName: 'John',
      lastName: 'Doe',
      dob: DateTime(1990, 5, 15),
      maritalStatus: 'Single',
      contactNumber: '1234567890',
      address: '123 Main St, City',
      email: 'john.doe@example.com',
    ),
    Employee(
      firstName: 'Jane',
      lastName: 'Smith',
      dob: DateTime(1985, 8, 22),
      maritalStatus: 'Married',
      contactNumber: '9876543210',
      address: '456 Oak Ave, Town',
      email: 'jane.smith@example.com',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee List'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
      ),
      body:
          employees.isEmpty
              ? Center(
                child: Text('No employees yet', style: TextStyle(fontSize: 18)),
              )
              : ListView.builder(
                itemCount: employees.length,
                itemBuilder: (context, index) {
                  final employee = employees[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: ListTile(
                      title: Text('${employee.firstName} ${employee.lastName}'),
                      subtitle: Text(employee.contactNumber),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => {},
                      ),
                      onTap: () {},
                    ),
                  );
                },
              ),
    );
  }
}
