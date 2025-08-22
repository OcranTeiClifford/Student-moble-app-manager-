// main.dart
import 'package:flutter/material.dart';

void main() => runApp(const StudentInfoApp());

class StudentInfoApp extends StatelessWidget {
  const StudentInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Information Manager',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _studentCount = 0;

  final _emailCtrl = TextEditingController();
  final _passCtrl  = TextEditingController();
  final _formKey   = GlobalKey<FormState>();

  String? _validateEmail(String? value) =>
      (value == null || !value.contains('@')) ? 'Enter a valid email' : null;

  String? _validatePass(String? value) =>
      (value == null || value.length < 6) ? 'At least 6 characters' : null;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Info Manager')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // a. Welcome Dashboard
            _welcomeCard(),
            const SizedBox(height: 20),

            // b. Interactive notification
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Hello, John Doe! Welcome to the Student Info Manager'),
                  ),
                );
              },
              child: const Text('Show Alert'),
            ),
            const SizedBox(height: 20),

            // c. Student Counter
            _counterSection(),
            const SizedBox(height: 20),

            // d. Login form
            _loginForm(),
            const SizedBox(height: 20),

            // e. Profile picture
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://via.placeholder.com/150',
                height: 120,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _welcomeCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            Text(
              'John Doe',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text('INFT 356 – Mobile Application Development'),
            Text('University of Technology'),
          ],
        ),
      ),
    );
  }

  Widget _counterSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () => setState(() => _studentCount--),
        ),
        Text('Students: $_studentCount',
            style: const TextStyle(fontSize: 18)),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => setState(() => _studentCount++),
        ),
      ],
    );
  }

  Widget _loginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailCtrl,
            decoration: const InputDecoration(labelText: 'Email'),
            validator: _validateEmail,
          ),
          TextFormField(
            controller: _passCtrl,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
            validator: _validatePass,
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Login successful')),
                );
              }
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}