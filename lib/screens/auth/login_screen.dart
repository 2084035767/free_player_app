import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:free_play_app/di/service_locator.dart';
import 'package:free_play_app/viewmodels/auth_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:signals_hooks/signals_hooks.dart';

class LoginScreen extends HookWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = getIt<AuthViewModel>();
    final email = useSignal('');
    final password = useSignal('');

    // final canSubmit = useComputed(
    //   () => email.value.isNotEmpty && password.value.length >= 6,
    // );
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Free Play',
              style: TextStyle(fontSize: 40, color: Colors.blue),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TextField(
                    autofocus: true,
                    onChanged: (v) {
                      email.value = v;
                    },
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    onChanged: (v) {
                      password.value = v;
                    },
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Password'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            Watch.builder(
              builder: (context) => vm.user.value.map(
                data: (user) => ElevatedButton(
                  onPressed: () async {
                    await vm.login(email.value, password.value);
                    if (context.mounted) {
                      context.go('/home');
                    }
                  },
                  child: const Text('Login'),
                ),
                error: (error) => Text('Error: ${error.toString()}'),
                loading: () => const CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
