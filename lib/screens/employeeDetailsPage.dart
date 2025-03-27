import 'package:employee_management_app/models/employee.dart';
import 'package:employee_management_app/screens/employeeForm.dart';
import 'package:flutter/material.dart';

class EmployeeDetailsPage extends StatelessWidget {
  final Employee employee;
  final Function(Employee) onUpdate;

  EmployeeDetailsPage({required this.employee, required this.onUpdate});

  void _showEditEmployeeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return EmployeeForm(
          employee: employee,
          onSubmit: (updatedEmployee) {
            onUpdate(updatedEmployee);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => _showEditEmployeeDialog(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${employee.firstName} ${employee.lastName}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              _buildDetailRow(
                'Date of Birth',
                '${employee.dob.day}/${employee.dob.month}/${employee.dob.year}',
              ),
              _buildDetailRow('Marital Status', employee.maritalStatus),
              _buildDetailRow('Contact Number', employee.contactNumber),
              _buildDetailRow('Address', employee.address),
              _buildDetailRow('Email', employee.email ?? 'Not provided'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
          Divider(),
        ],
      ),
    );
  }
}
