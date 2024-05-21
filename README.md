## API Reference

### `Bridge`

A class that provides methods to launch a bridge with encrypted parameters and decrypt the received parameters.

#### `launch(BridgeParams params, String passphrase)`

Launches the bridge with the given `params`.

The `params` object contains the necessary information to construct the launch URI.
The parameters are encrypted using AES256 encryption with a passphrase.
The launch URI is constructed by replacing the query parameters of the `params.url` with the encrypted parameters.

Throws an exception if the launch fails.

#### `extractMetaDataParameter(String url)`

Decrypts the received encrypted `params` using the provided `passphrase`.

Returns the decrypted parameters as a string.

Extracts the query parameters from the given `url`.

Returns a map of query parameter keys to their corresponding values.

#### `decryptParams(String passphrase)`

Decrypts the received encrypted `params` using the provided `passphrase`.

Returns the decrypted parameters as a `Params` object.

### `Params`

A class that represents the decrypted parameters.

#### Properties

- `branchId`: The branch ID.
- `token`: The token.
- `refreshToken`: The refresh token.
- `username`: The username.
