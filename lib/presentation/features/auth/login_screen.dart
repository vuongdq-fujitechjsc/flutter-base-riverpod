import 'package:flutter/material.dart';
import 'package:flutter_base_riverpod/presentation/features/auth/auth_provider.dart';
import 'package:flutter_base_riverpod/presentation/features/auth/auth_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {

   late final AuthViewModel _viewModel = ref.watch(authViewModelStateNotifierProvider.notifier);

  final _formKey = GlobalKey<FormState>();

  final FocusNode _focusNodePassword = FocusNode();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  _LoginScreenState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              const SizedBox(height: 150),
              Text(
                "Welcome back",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 10),
              Text(
                "Login to your account",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 60),
              TextFormField(
                controller: _controllerUsername,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "Username",
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onEditingComplete: () => _focusNodePassword.requestFocus(),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _controllerPassword,
                focusNode: _focusNodePassword,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: const Icon(Icons.password_outlined),
                  // suffixIcon: IconButton(
                  //     onPressed: () {
                  //       setState(() {
                  //         // _obscurePassword = !_obscurePassword;
                  //       });
                  //     },
                      // icon: _obscurePassword
                      //     ? const Icon(Icons.visibility_outlined)
                      //     : const Icon(Icons.visibility_off_outlined)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                // validator: (String? value) {
                //   if (value == null || value.isEmpty) {
                //     return "Please enter password.";
                //   } else if (value !=
                //       _boxAccounts.get(_controllerUsername.text)) {
                //     return "Wrong password.";
                //   }

                //   return null;
                // },
              ),
              const SizedBox(height: 60),
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () async {
                      // if (_formKey.currentState?.validate() ?? false) {

                        print("Call me");
                        print(_controllerUsername.text);
                        print(_controllerPassword.text);

                      final data = {'email': _controllerUsername.text, 'password': _controllerPassword.text};

                    final currentState = _formKey.currentState;
          if (currentState != null && currentState.validate()) {
            if (_viewModel != null) {
              print('Init');
              await _viewModel.login(data, _cacheAuthToken);
            }
            print('Not init');
            // ref.read(appRouterProvider).pop();
          }

                        // _boxLogin.put("loginStatus", true);
                        // _boxLogin.put("userName", _controllerUsername.text);

                        // Navigator.pushReplacement(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) {
                        //       return Home();
                        //     },
                        //   ),
                        // );
                      // }
                    },
                    child: const Text("Login"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          _formKey.currentState?.reset();

                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) {
                          //       return const Signup();
                          //     },
                          //   ),
                          // );
                        },
                        child: const Text("Signup"),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _focusNodePassword.dispose();
    _controllerUsername.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

   void _cacheAuthToken(String value) {
    // _keyValueStorageService.setAuthToken(value);
    print("Call me - _cacheAuthToken: $value");
  }
}
