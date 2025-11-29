// import 'package:local_auth/local_auth.dart';

// class AuthService {
//   final LocalAuthentication auth = LocalAuthentication();

//   Future<bool> authenticateWithBiometrics() async {
//     try {
//       bool isBiometricSupported = await auth.isDeviceSupported();
//       bool canCheckBiometrics = await auth.canCheckBiometrics;

//       if (!isBiometricSupported || !canCheckBiometrics) return false;

//       return await auth.authenticate(
//         localizedReason: 'Please authenticate to proceed',
//         options: const AuthenticationOptions(
//           stickyAuth: true,
//           biometricOnly: true,
//         ),
//       );
//     } catch (e) {
//       print('Biometric auth error: $e');
//       return false;
//     }
//   }
// }
