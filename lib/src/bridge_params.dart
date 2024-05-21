/// Represents the parameters required for bridging authentication.
class BridgeParams {
  final String url;
  final Params params;

  BridgeParams({
    required this.url,
    required this.params,
  });

  /// Creates a [BridgeParams] instance from a JSON map.
  factory BridgeParams.fromJson(Map<String, dynamic> json) {
    return BridgeParams(
      url: json['url'],
      params: Params.fromJson(json['params']),
    );
  }

  /// Converts the [BridgeParams] instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'params': params.toJson(),
    };
  }
}

/// Represents the parameters required for authentication.
class Params {
  final String branchId;
  final String token;
  final String refreshToken;
  final String username;

  Params({
    required this.branchId,
    required this.token,
    required this.refreshToken,
    required this.username,
  });

  /// Creates a [Params] instance from a JSON map.
  factory Params.fromJson(Map<String, dynamic> json) {
    return Params(
      branchId: json['branchId'],
      token: json['token'],
      refreshToken: json['refreshToken'],
      username: json['username'],
    );
  }

  /// Converts the [Params] instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'branchId': branchId,
      'token': token,
      'refreshToken': refreshToken,
      'username': username,
    };
  }
}
