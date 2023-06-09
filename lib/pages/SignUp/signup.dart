// ignore_for_file: prefer_const_constructors, unused_field, no_leading_underscores_for_local_identifiers, avoid_print, use_build_context_synchronously, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterdatabasesalah/pages/nav_pages/main_page.dart';

import 'Services/auth.dart';
import 'package:image_picker/image_picker.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();
  final _pageController = PageController();
  final List<TextEditingController> _controllers =
      List.generate(6, (String) => TextEditingController());


  String _email = '';
  String _password = '';
  String _firstName = '';
  String _lastName = '';
  String _squat = '';
  String _bench = '';
  String _deadlift = '';
  String _confrimpassword = '';

  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    }
    print('No image selected');
  }

  Uint8List? _image;
  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            _emailPage(),
            _codePage(),
            _passwordPage(),
            _namePage(),
            _liftsPage(),
          ],
        ),
      ),
    );
  }

  Widget _emailPage() {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 3, 3, 3),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(children: [
            SizedBox(
              height: 30,
            ),
            Image(
              image: AssetImage('images/logo.png'),
              height: 80,
            ),
            SizedBox(
              height: 60,
            ),
            Center(
              child: Text(
                ' SignUp',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Enter your email',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color.fromARGB(255, 48, 50, 51),
              ),
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        _email = value.trim();
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!_isValidEmail(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle:
                            TextStyle(fontSize: 18, color: Colors.white),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Color(0xff45B39D),
                          size: 20,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff45B39D)),
                        )),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        bool isSignedUp =
                            await AuthService().isUserSignedUp(_email);
                        if (isSignedUp) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor:
                                    Color.fromARGB(255, 48, 50, 51),
                                title: Text(
                                  'Sign Up Error',
                                  style: TextStyle(color: Colors.white),
                                ),
                                content: Text(
                                  'The email is already registered.',
                                  style: TextStyle(color: Colors.white),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'OK',
                                      style:
                                          TextStyle(color: Color(0xff45B39D)),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                          return;
                        }
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(380, 40)),
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xff45B39D)),
                      padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                    ),
                    child: Text(
                      "Next",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _codePage() {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 150,
              ),
              Center(
                child: Text(
                  'Enter Verification code',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                  //textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Enter the code sent to your email',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 140,
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color.fromARGB(255, 48, 50, 51),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        6,
                        (index) => SizedBox(
                          height: 40,
                          width: 40,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter code';
                              }
                              return null;
                            },
                            controller: _controllers[index],
                            onChanged: (value) {
                              if (value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            style: Theme.of(context).textTheme.headline6,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 32, 33, 34)),
                              ),
                            ),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        Uint8List _image = Uint8List(0);
                        final verificationCode = _controllers
                            .map((controller) => controller.text)
                            .join();
                        final athleteId =
                            await _authService.checkVerificationCodeAndUpdate(verificationCode,_email,'','','','','','', _image);
                        if (athleteId != null) {
                          print("Matching document found with ID: $athleteId");
                          // Navigate to the next page
                          _pageController.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          // Show error message
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Invalid code'),
                              content: Text(
                                  'The code you entered is invalid. Please try again.'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(380, 40)),
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xff45B39D)),
                        padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                      ),
                      child: Text(
                        "Next",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _passwordPage() {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.circle,
                  color: Color(0xff45B39D),
                  size: 10,
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.circle,
                  color: Colors.grey,
                  size: 10,
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.circle,
                  color: Colors.grey,
                  size: 10,
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            Image(
              image: AssetImage('images/logo.png'),
              height: 100,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Create a new password',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color.fromARGB(255, 48, 50, 51),
              ),
              child: Column(children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _password = value.trim();
                    });
                  },
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  obscureText: _obscureText,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(fontSize: 15, color: Colors.white),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Color(0xff45B39D),
                          size: 20,
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Color(0xff45B39D),
                        size: 20,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 32, 33, 34)),
                      )),
                ),
                TextFormField(
                  onChanged: (value) {
                    _confrimpassword = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    } else if (value != _password) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  obscureText: _obscureText,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                      labelText: "Password confirmation",
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Color(0xff45B39D),
                          size: 20,
                        ),
                      ),
                      labelStyle: TextStyle(fontSize: 15, color: Colors.white),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Color(0xff45B39D),
                        size: 20,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 32, 33, 34)),
                      )),
                ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(380, 40)),
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xff45B39D)),
                    padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                  ),
                  child: Text(
                    "Next",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                SizedBox(
                  height: 15,
                )
              ]),
            )
          ],
        )),
      ),
    );
  }

  Widget _namePage() {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.circle,
                  color: Colors.grey,
                  size: 10,
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.circle,
                  color: Color(0xff45B39D),
                  size: 10,
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.circle,
                  color: Colors.grey,
                  size: 10,
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            Image(
              image: AssetImage('images/logo.png'),
              height: 100,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Setup your Profile',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color.fromARGB(255, 48, 50, 51),
              ),
              child: Column(children: [
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _firstName = value.trim();
                    });
                  },
                  style: TextStyle(color: Colors.white),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      labelText: "First name",
                      labelStyle: TextStyle(fontSize: 15, color: Colors.white),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 32, 33, 34)),
                      )),
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _lastName = value.trim();
                    });
                  },
                  style: TextStyle(color: Colors.white),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      labelText: "Last name",
                      labelStyle: TextStyle(fontSize: 15, color: Colors.white),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 32, 33, 34)),
                      )),
                ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(380, 40)),
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xff45B39D)),
                    padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                  ),
                  child: Text(
                    "Next",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                SizedBox(
                  height: 15,
                )
              ]),
            )
          ],
        )),
      ),
    );
  }

  Widget _liftsPage() {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.circle,
                  color: Colors.grey,
                  size: 10,
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.circle,
                  color: Colors.grey,
                  size: 10,
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.circle,
                  color: Color(0xff45B39D),
                  size: 10,
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: SafeArea(
        child: Center(
          child: Column(
            children: [
              Image(
                image: AssetImage('images/logo.png'),
                height: 50,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Profile details',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
                maxLines: 5,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text(
                  'Enter your 1RMs to help us calculate the weights for you to use in your programs. These can always be changed later, so include your best estimate of a weight you can lift for 1 repetition on any day.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color.fromARGB(255, 48, 50, 51),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Profile picture',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Stack(
                        children: <Widget>[
                          _image != null
                              ? CircleAvatar(
                                  radius: 50.0,
                                  backgroundImage: MemoryImage(_image!),
                                )
                              : CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  radius: 50.0,
                                  backgroundImage: AssetImage(
                                    'images/Profile.png',
                                  )),
                          Positioned(
                              bottom: 1,
                              right: -2,
                              child: IconButton(
                                  onPressed: selectImage,
                                  icon: Icon(
                                    Icons.add_a_photo_outlined,
                                    color: Colors.black,
                                    size: 25,
                                  )))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Measurements system',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Squat 1RM',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                        Text(
                          'Branch 1RM',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            right: 10,
                          ),
                          child: Text(
                            'Deadlift 1RM',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 60,
                          width: 100,
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your 1RM';
                              }
                              if (double.tryParse(value) == null ||
                                  double.parse(value) <= 0) {
                                return 'Please enter a valid weight';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _squat = value.trim();
                              });
                            },
                            style: Theme.of(context).textTheme.headline6,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              suffixText: 'kg',
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                            ),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(3),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 60,
                          width: 100,
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your 1RM';
                              }
                              if (double.tryParse(value) == null ||
                                  double.parse(value) <= 0) {
                                return 'Please enter a valid weight';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _bench = value.trim();
                              });
                            },
                            style: Theme.of(context).textTheme.headline6,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              suffixText: 'kg',
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                            ),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(3),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 60,
                          width: 100,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your 1RM';
                              }
                              if (double.tryParse(value) == null ||
                                  double.parse(value) <= 0) {
                                return 'Please enter a valid weight';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _deadlift = value.trim();
                              });
                            },
                            textInputAction: TextInputAction.done,
                            style: Theme.of(context).textTheme.headline6,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              suffixText: 'kg',
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                            ),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(3),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                        alignment: Alignment.center,
                        child: Text(
                          '*1RM = 1 repetition maximum',
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        String code=_controllers
                            .map((controller) => controller.text).join();
                           
                        if (_formKey.currentState!.validate()) {
                          try {

                            String? uid = await _authService.registerUser(_email, _password);
                             await _authService.checkVerificationCodeAndUpdate(code,uid,_email,_firstName,_lastName,_squat,_bench,_deadlift,_image!);
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => MainPage(),
                              ),
                            );
                          } catch (e) {
                            print('Error signing up: $e');
                            // Handle error signing up
                          }
                        }
                      },
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(380, 40)),
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xff45B39D)),
                        padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                      ),
                      child: Text(
                        "Start Training",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }

  bool _isValidEmail(String email) {
    // Use a regular expression to validate email format
    const pattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    final regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }
}
