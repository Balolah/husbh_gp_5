 import 'package:firebase_auth/firebase_auth.dart';

 Future<bool> checkIfEmailInUse(
                          String emailAddress) async {
                        try {
                          // Fetch sign-in methods for the email address
                          final list = await FirebaseAuth.instance
                              .fetchSignInMethodsForEmail(emailAddress);

                          // In case list is not empty
                          if (list.isNotEmpty) {
                            // Return true because there is an existing
                            // user using the email address
                            return true;
                          } else {
                            // Return false because email adress is not in use
                            return false;
                          }
                        } catch (error) {
                          // Handle error
                          // ...
                          return false;
                        }
                      }