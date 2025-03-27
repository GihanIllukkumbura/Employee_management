import 'package:employee_management_app/models/employee.dart';
import 'package:flutter/material.dart';

class EmployeeForm extends StatefulWidget {
  final Employee? employee;
  final Function(Employee) onSubmit;

  const EmployeeForm({this.employee, required this.onSubmit});

  @override
  _EmployeeFormState createState() => _EmployeeFormState();
}

class _EmployeeFormState extends State<EmployeeForm> {
  final _formKey = GlobalKey<FormState>();
  late String _firstName;
  late String _lastName;
  late DateTime _dob;
  late String _maritalStatus;
  late String _contactNumber;
  late String _address;
  String? _email;

  final List<String> _maritalStatusOptions = ['Single', 'Married'];

  @override
  void initState() {
    super.initState();
    if (widget.employee != null) {
      _firstName = widget.employee!.firstName;
      _lastName = widget.employee!.lastName;
      _dob = widget.employee!.dob;
      _maritalStatus = widget.employee!.maritalStatus;
      _contactNumber = widget.employee!.contactNumber;
      _address = widget.employee!.address;
      _email = widget.employee!.email;
    } else {
      _firstName = '';
      _lastName = '';
      _dob = DateTime.now();
      _maritalStatus = _maritalStatusOptions[0];
      _contactNumber = '';
      _address = '';
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dob,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _dob) {
      setState(() {
        _dob = picked;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final employee = Employee(
        firstName: _firstName,
        lastName: _lastName,
        dob: _dob,
        maritalStatus: _maritalStatus,
        contactNumber: _contactNumber,
        address: _address,
        email: _email,
      );

      widget.onSubmit(employee);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          widget.employee == null ? 'Add Employee' : 'Edit Employee',
          style: TextStyle(fontSize: 20),
        ),
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              TextFormField(
                initialValue: _firstName,
                decoration: InputDecoration(labelText: 'First Name*'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter first name';
                  }
                  return null;
                },
                onSaved: (value) => _firstName = value!,
              ),
              TextFormField(
                initialValue: _lastName,
                decoration: InputDecoration(labelText: 'Last Name*'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter last name';
                  }
                  return null;
                },
                onSaved: (value) => _lastName = value!,
              ),
              SizedBox(height: 16),
              InkWell(
                onTap: () => _selectDate(context),
                child: InputDecorator(
                  decoration: InputDecoration(labelText: 'Date of Birth*'),
                  child: Text('${_dob.day}/${_dob.month}/${_dob.year}'),
                ),
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _maritalStatus,
                items:
                    _maritalStatusOptions.map((status) {
                      return DropdownMenuItem(
                        value: status,
                        child: Text(status),
                      );
                    }).toList(),
                decoration: InputDecoration(labelText: 'Marital Status*'),
                onChanged: (value) {
                  setState(() {
                    _maritalStatus = value!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select marital status';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _contactNumber,
                decoration: InputDecoration(labelText: 'Contact Number*'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter contact number';
                  }
                  if (value.length != 10 ||
                      !RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return 'Please enter a valid 10-digit number';
                  }
                  return null;
                },
                onSaved: (value) => _contactNumber = value!,
              ),
              TextFormField(
                initialValue: _address,
                decoration: InputDecoration(labelText: 'Address*'),
                maxLines: 2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter address';
                  }
                  return null;
                },
                onSaved: (value) => _address = value!,
              ),
              TextFormField(
                initialValue: _email,
                decoration: InputDecoration(labelText: 'Email (Optional)'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    if (!RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    ).hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                  }
                  return null;
                },
                onSaved: (value) => _email = value,
              ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        ElevatedButton(onPressed: _submitForm, child: Text('Save')),
      ],
    );
  }
}
