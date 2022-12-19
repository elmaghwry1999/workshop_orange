import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:workshop/business_logic/auth/login/login_cubit.dart';
import 'package:workshop/constants/constant_methods.dart';
import 'package:workshop/presentation/screens/app_layout/app_layout.dart';
import 'package:workshop/presentation/screens/register/register_screen.dart';
import 'package:workshop/presentation/styles/app_colors.dart';
import 'package:workshop/presentation/widgets/default_text.dart';
import 'package:workshop/presentation/widgets/default_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          flutterToast(msg: 'Logged is Successfully', color: Colors.green);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const AppLayout(),
              ),
                  (route) => false);
        }
      },
      builder: (context, state) {
        LoginCubit loginCubit = LoginCubit.get(context);
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Form(
              key: loginKey,
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:   [
                        Text(
                          'Orange',
                          style: TextStyle(
                            color: Colors.deepOrange,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Digital Center',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.h),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24.sp,
                      ),
                    ),
                  ),
                  DefaultTextFormField(
                    validation: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter Your Email';
                      } else if (!RegExp(
                              "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9+_.-]+.[com]")
                          .hasMatch(value)) {
                        return 'Please Enter your email as example@gmail.com';
                      }
                    },
                    onChanged: () {},
                    hintText: 'Email',
                    isObscureText: false,
                    controller: emailController,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  DefaultTextFormField(
                    validation: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter Your Password';
                      }
                    },
                    onChanged: () {},
                    isPasswordField: true,
                    hintText: 'Password',
                    controller: passwordController,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 3.h),
                    child: Text(
                      "Forget Password?",
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 10.sp,
                      ),
                    ),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      if (loginKey.currentState!.validate()) {
                        loginCubit.postLogin(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                      }
                    },
                    style:ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10.sp
                        )),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.orange)
                            )
                        )
                    ),
                    child:   Text('Login',style: TextStyle(fontSize: 20.sp,color: Colors.white),),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    child: Row(
                      children: [
                        const Expanded(
                            child: Divider(
                          color: Colors.grey,
                        )),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 1.w),
                          child: const DefaultText(
                              text: 'OR', textColor: Colors.grey),
                        ),
                        const Expanded(
                            child: Divider(
                          color: Colors.grey,
                        )),
                      ],
                    ),
                  ),
                  OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterScreen(),
                            ));
                      },
                      style:ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10.sp
                          )),
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.orange),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.orange)
                              )
                          )
                      ),
                      child: Text('Register',style: TextStyle(fontSize: 20.sp,color: AppColors.primaryColor),))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
