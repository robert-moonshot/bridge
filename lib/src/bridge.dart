import 'dart:convert';
import 'dart:developer';
import 'package:bridge/src/aeseverywhere.dart';
import 'package:bridge/src/bridge_params.dart';
import 'package:url_launcher/url_launcher.dart';

/// A class that provides methods to launch a bridge with encrypted parameters and decrypt the received parameters.
class Bridge {
  /// Launches the bridge with the given [params].
  ///
  /// The [params] object contains the necessary information to construct the launch URI.
  /// The parameters are encrypted using AES256 encryption with a passphrase.
  /// The launch URI is constructed by replacing the query parameters of the [params.url] with the encrypted parameters.
  ///
  /// Throws an exception if the launch fails.
  static Future launch(BridgeParams params, String passphrase) async {
    final rawQuery = params.params.toJson().toString();
    final queryParams = Aes256.encrypt(rawQuery, passphrase);

    try {
      await launchUrl(Uri.parse("${params.url}?meta-data=$queryParams"));
    } catch (e) {
      throw Exception('Could not launch');
    }
  }

  /// Decrypts the received encrypted [params] using the provided [passphrase].
  ///
  /// Returns the decrypted parameters as a string.
  /// Decrypts the received encrypted [params] using the provided [passphrase].
  ///
  /// Returns the decrypted parameters as a string.
  ///
  /// Extracts the query parameters from the given [url].
  ///
  /// Returns a map of query parameter keys to their corresponding values.
  static String extractMetaDataParameter(String url) {
    final queryParams = url.split('?')[1];
    final paramPairs = queryParams.split('&');
    for (var pair in paramPairs) {
      final keyValue = pair.split('=');
      if (keyValue[0] == 'meta-data') {
        return keyValue[1];
      }
    }
    return "";
  }

  static Future<Params> decryptParams(String passphrase) async {
    try {
      String url = Uri.base.toString();
      String params = extractMetaDataParameter(url).toString();
      String decryptedParams =
          Aes256.decrypt("$params==", passphrase) ?? "None";
      log('Decrypted Params: $decryptedParams');
      Map<String, dynamic> parsedParams = jsonDecode(decryptedParams
          .replaceAll("{", '{"')
          .replaceAll(": ", '":"')
          .replaceAll(", ", '","')
          .replaceAll("}", '"}'));

      return Params(
        branchId: parsedParams['branchId'],
        token: parsedParams['token'],
        refreshToken: parsedParams['refreshToken'],
        username: parsedParams['username'],
      );
    } catch (err) {
      return Params(
          branchId: "error",
          token: "error",
          refreshToken: "error",
          username: "errpr");
    }
  }
}
