import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sss/application/blocs/bloc/task_bloc.dart';
import 'package:sss/application/widgets/reusables/app_text_form_field.dart';
import 'package:sss/utils/http_service.dart';
import '../utils/extensions.dart';
import 'package:sss/utils/app_constants.dart';
import 'package:sss/utils/styles.dart' as styles;

class LoginPage extends StatefulWidget {
  const LoginPage(
      {required this.taskBloc, required this.navigationFunction, super.key});

  final void Function() navigationFunction;
  final taskBloc;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  HttpService httpService = HttpService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isObscure = true;

  saveValue(userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_id', userId);
  }

  @override
  Widget build(BuildContext context) {
    final size = context.mediaQuerySize;

    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                height: size.height * 0.24,
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppConstants.primaryColor,
                      Color.fromARGB(255, 197, 70, 199),
                    ],
                  ),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sign in to your\nAccount',
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppTextFormField(
                      labelText: 'Username',
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        _formKey.currentState?.validate();
                      },
                      validator: (value) {
                        return value!.isEmpty ? 'Please, Enter Username' : null;
                      },
                      controller: emailController,
                    ),
                    AppTextFormField(
                      labelText: 'Password',
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      onChanged: (value) {
                        _formKey.currentState?.validate();
                      },
                      validator: (value) {
                        return value!.isEmpty
                            ? 'Please, Enter Password'
                            : AppConstants.passwordRegex.hasMatch(value)
                                ? null
                                : 'Invalid Password';
                      },
                      controller: passwordController,
                      obscureText: isObscure,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              isObscure = !isObscure;
                            });
                          },
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(
                              const Size(48, 48),
                            ),
                          ),
                          icon: Icon(
                            isObscure
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    FilledButton(
                      onPressed: _formKey.currentState?.validate() ?? false
                          ? () async {
                              try {
                                dynamic userData =
                                    await httpService.getUserLoginData(
                                        emailController.text,
                                        passwordController.text,
                                        'userLogin');

                                if (userData['success'] == true) {
                                  // print(userData['user_id']);
                                  widget.taskBloc.add(DispatchUserDataEvent(
                                      userId: userData['user_id']));
                                  saveValue(userData['user_id']);
                                  widget.navigationFunction();
                                  styles.customSnackBar(
                                      _scaffoldKey.currentContext,
                                      'Logged in!');
                                } else {
                                  styles.customSnackBar(
                                      _scaffoldKey.currentContext,
                                      'Invalid Credentials!',
                                      Colors.red);
                                }
                              } catch (error) {
                                print("your login error is $error");
                              }

                              emailController.clear();
                              passwordController.clear();
                            }
                          : null,
                      style: const ButtonStyle().copyWith(
                        backgroundColor: MaterialStateProperty.all(
                          _formKey.currentState?.validate() ?? false
                              ? const Color.fromARGB(255, 255, 115, 92)
                              : Colors.grey.shade300,
                        ),
                      ),
                      child: const Text('Login'),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.grey.shade200,
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.grey.shade200,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
