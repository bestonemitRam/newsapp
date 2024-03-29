import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shortnews/view/auth/authentication.dart';
import 'package:shortnews/view/dashboard_screeen.dart';
import 'package:shortnews/view/uitl/appimage.dart';
import 'package:shortnews/view/uitl/my_progress_bar.dart';

class LoginByConatact extends StatefulWidget {
  const LoginByConatact({super.key});

  @override
  State<LoginByConatact> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<LoginByConatact> {
  final AuthController controller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: InkWell(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                duration: Duration(milliseconds: 700),
                child: DashBoardScreenActivity(),
              ),
            );
          },
        ),
        title: Center(
          child: Text(
            "",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppImages.welcomescreenillimage,
                      fit: BoxFit.fill,
                      width: 30.w,
                      height: 10.h,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        // Get.toNamed(ApplicationPages.homeScreen);
                        // Get.toNamed(ApplicationPages.selectRoleScreen,arguments: {'user_id':'167'});
                        // Get.toNamed(ApplicationPages.basicInformationScreen,
                        //     arguments: {'user_id':'1','mobile':'+619876543210','first_name':'Alok','last_name':'Maurya'});
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 23),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "     Contact",
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                            width: size.width * 0.80,
                            height: 55,
                            padding: const EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(28)),
                                border: Border.all(color: Colors.white)),
                            child: Form(
                                child: TextFormField(
                              controller: controller.mobileController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter phone number ',
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 13)),
                              style: const TextStyle(color: Colors.white),
                            ))),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    controller.isLoading.value
                        ? myProgressBar()
                        : ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.amber)),
                            onPressed: () {
                              if (controller.validation()) {
                                controller.signUpWithPhoneNumber();
                                controller.isLoading.value = true;
                              }
                            },
                            child: SizedBox(
                                height: 50,
                                width: size.width * 0.68,
                                child: const Center(
                                    child: Text(
                                  'Login',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )))),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }

}
