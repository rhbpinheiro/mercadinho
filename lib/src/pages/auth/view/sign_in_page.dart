import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mercadinho/src/components/custom_text_field.dart';
import 'package:mercadinho/src/components/forgot_password_dialog.dart';
import 'package:mercadinho/src/pages/auth/controller/auth_controller.dart';
import 'package:mercadinho/src/pages/common_widgets/app_name_widget.dart';
import 'package:mercadinho/src/pages_routes/app_pages.dart';
import 'package:mercadinho/src/utils/utils_service.dart';
import 'package:validatorless/validatorless.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  bool isObscure = true;
  final formKey = GlobalKey<FormState>();
  final utilsService = UtilsService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AppNameWidget(
                  greenTitleColor: Colors.white,
                  textSize: 40,
                ),
                SizedBox(
                  height: 30,
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                    child: AnimatedTextKit(
                      pause: Duration.zero,
                      repeatForever: true,
                      animatedTexts: [
                        FadeAnimatedText('Frutas'),
                        FadeAnimatedText('Carnes'),
                        FadeAnimatedText('Bebidas'),
                        FadeAnimatedText('Bebidas'),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 40,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(45),
              ),
            ),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: emailController,
                    labelText: 'Email',
                    prefix: const Icon(Icons.mail),
                    validator: Validatorless.multiple([
                      Validatorless.required('Email é obrigatório.'),
                      Validatorless.email('Digite um email válido.'),
                    ]),
                  ),
                  CustomTextField(
                    controller: senhaController,
                    isSecret: true,
                    labelText: 'Senha',
                    prefix: const Icon(
                      Icons.lock,
                    ),
                    validator: Validatorless.multiple([
                      Validatorless.required(
                        'Senha é obrigatória.',
                      ),
                      Validatorless.min(
                        6,
                        'A senha deve conter no mínimo 7 caracteres',
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: GetX<AuthController>(
                      builder: (authController) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                18,
                              ),
                            ),
                          ),
                          onPressed: authController.isLoading.value
                              ? null
                              : () {
                                  FocusScope.of(context).unfocus();
                                  if (formKey.currentState!.validate()) {
                                    String email = emailController.text;
                                    String password = senhaController.text;
                                    authController.signIn(
                                      email: email,
                                      password: password,
                                    );
                                  }
                                },
                          child: authController.isLoading.value
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  'Entrar',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () async {
                         final bool? result = await showDialog(
                            context: context,
                            builder: (_) {
                              return ForgotPasswordDialog(
                                email: emailController.text,
                              );
                            },
                          );
                          if(result ?? false) {
                            utilsService.showToast(
                              isError: false,
                              message: 'Um link para redefinir a senha foi enviado para seu email.',
                            );
                          }
                        },
                        child: const Text(
                          'Exqueceu a Senha?',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          'Ou',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black38,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          width: 2,
                          color: Colors.green,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            18,
                          ),
                        ),
                      ),
                      onPressed: () {
                        Get.toNamed(PagesRoutes.sigUpRoute);
                      },
                      child: const Text(
                        'Criar conta',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
