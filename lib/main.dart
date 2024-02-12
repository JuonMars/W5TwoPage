import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignUpFormModel(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SignUpPage(),
      ),
    );
  }
}

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<SignUpFormModel>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: model.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Username'),
                onSaved: (value) => model.username = value!,
                validator: (value) => value!.isEmpty ? 'Please enter a username' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                onSaved: (value) => model.password = value!,
                validator: (value) => value!.isEmpty ? 'Please enter a password' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                onSaved: (value) => model.phoneNumber = value!,
                validator: (value) => value!.isEmpty ? 'Please enter a phone number' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                onSaved: (value) => model.email = value!,
                validator: (value) => value!.isEmpty ? 'Please enter an email' : null,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => model.navigateToHome(context),
                    child: Text('Log In'),
                  ),
                  ElevatedButton(
                    onPressed: () => model.signUp(context),
                    child: Text('Sign Up'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignUpFormModel with ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String username = '';
  String password = '';
  String phoneNumber = '';
  String email = '';

  void navigateToHome(BuildContext context) {
    // Here you would usually navigate to the home page if the user is already registered
  }

  void signUp(BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      // Process data and navigate to the second page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SecondPage(username: username)),
      );
    }
  }
}

// Placeholder for the second page
class SecondPage extends StatelessWidget {
  final String username;

  SecondPage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome, $username')),
      body: Center(
        child: Text('This is the second page'),
      ),
    );
  }
}
