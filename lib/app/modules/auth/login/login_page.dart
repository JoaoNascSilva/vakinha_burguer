import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vakinha_burguer_mobile/app/core/ui/vakinha_state.dart';
import 'package:vakinha_burguer_mobile/app/core/ui/vakinha_ui.dart';
import 'package:vakinha_burguer_mobile/app/core/ui/widgets/vakinha_button.dart';
import 'package:vakinha_burguer_mobile/app/core/ui/widgets/vakinha_textformfield.dart';
import 'package:vakinha_burguer_mobile/app/modules/auth/login/login_controller.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends VakinhaState<LoginPage, LoginController> {
  final formKey = GlobalKey<FormState>();

  final _emailEditingController = TextEditingController();
  final _passwordEditingController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (_, contraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(minHeight: contraints.maxHeight),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      SizedBox(
                        width: context.width,
                        child: Image.asset(
                          'assets/images/logo.png',
                          height: 80,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      Text(
                        'Login',
                        style: context.textTheme.headline6?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.theme.primaryColorDark,
                        ),
                      ),
                      const SizedBox(height: 30),
                      VakinhaTextformfield(
                        label: 'E-Mail',
                        controller: _emailEditingController,
                        validator: Validatorless.multiple([
                          Validatorless.required('Email obrigatório.'),
                          Validatorless.email('Email inválido.')
                        ]),
                        onChange: (value) {},
                      ),
                      const SizedBox(height: 30),
                      VakinhaTextformfield(
                        label: 'Senha',
                        obscureText: true,
                        controller: _passwordEditingController,
                        validator: Validatorless.multiple([
                          Validatorless.required('Senha obrigatória.'),
                          Validatorless.min(
                              6, 'Senha deve conter pelo menos 6 caracteres.'),
                        ]),
                        onChange: (value) {},
                      ),
                      const SizedBox(height: 50),
                      Center(
                        child: VakinhaButton(
                          width: context.width,
                          label: 'Entrar',
                          onPressed: () {
                            final isValid =
                                formKey.currentState?.validate() ?? false;

                            if (isValid) {
                              controller.login(
                                email: _emailEditingController.text,
                                password: _passwordEditingController.text,
                              );
                            }
                          },
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Não possui uma conta ?'),
                          TextButton(
                            onPressed: () {
                              Get.toNamed('/auth/register');
                            },
                            child: const Text(
                              'Cadastre-se',
                              style: VakinhaUi.textBold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
