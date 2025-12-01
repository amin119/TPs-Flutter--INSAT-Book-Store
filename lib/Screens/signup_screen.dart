import 'package:flutter/material.dart';
import '../widgets/custom_input_decoration.dart';
import 'tab_bar_screen.dart';
import '../theme_controller.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = "/"; // Set as initial route

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> currentKey = GlobalKey<FormState>();

  String? username;
  String? email;
  String? password;
  String? birthDate;
  String? address;

  final TextEditingController _birthController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Sign Up", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color.fromARGB(255, 33, 107, 235),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6_outlined),
            onPressed: toggleTheme, // Theme change button
          ),
        ],
      ),
      body: Form(
        key: currentKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Image
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Image.asset("assets/Logo_INSAT.png", width: 250, height: 200),
            ),

            // Username
            Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
              child: TextFormField(
                decoration: CustomInputDecoration(
                  "UserName",
                  "Enter Your UserName",
                  const Icon(Icons.person_3_outlined),
                ),
                onSaved: (newValue) => username = newValue!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "UserName should not be empty";
                  }
                  return null;
                },
              ),
            ),

            // Email
            Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
              child: TextFormField(
                decoration: CustomInputDecoration(
                  "Email",
                  "Enter Your Email",
                  const Icon(Icons.email_outlined),
                ),
                onSaved: (newValue) => email = newValue!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Email should not be empty";
                  } else if (!value.contains('@')) {
                    return "Enter a valid email";
                  }
                  return null;
                },
              ),
            ),

            // Password
            Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
              child: TextFormField(
                obscureText: true,
                decoration: CustomInputDecoration(
                  "Password",
                  "Enter Your Password",
                  const Icon(Icons.lock_outline),
                ),
                onSaved: (newValue) => password = newValue!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Password should not be empty";
                  } else if (value.length < 8) {
                    return "Password must have at least 8 characters";
                  }
                  return null;
                },
              ),
            ),

            // Birth Date
            Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
              child: TextFormField(
                controller: _birthController,
                readOnly: true,
                decoration: CustomInputDecoration(
                  "Birth Date",
                  "Select Your Birth Date",
                  const Icon(Icons.calendar_today),
                ),
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime(2000),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    _birthController.text =
                    "${picked.day}/${picked.month}/${picked.year}";
                    birthDate = _birthController.text;
                  }
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Birth Date is required";
                  }
                  return null;
                },
              ),
            ),

            // Address
            Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
              child: TextFormField(
                decoration: CustomInputDecoration(
                  "Address",
                  "Enter Your Address",
                  const Icon(Icons.home_outlined),
                ),
                onSaved: (newValue) => address = newValue!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Address should not be empty";
                  }
                  return null;
                },
              ),
            ),

            const SizedBox(height: 25),

            // Submit Button
            ElevatedButton(
              onPressed: () {
                if (currentKey.currentState!.validate()) {
                  currentKey.currentState!.save();

                  // Show success dialog
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("SignUp"),
                        content: const Text(
                            "User added successfully! Check your inbox."),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // close dialog
                              // Navigate to the tabbed top-bar (functional TabBar)
                              Navigator.pushReplacementNamed(
                                  context, MyTabBar.routeName);
                            },
                            child: const Text("OK"),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 33, 107, 235),
              ),
              child: const Text(
                "Submit",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
