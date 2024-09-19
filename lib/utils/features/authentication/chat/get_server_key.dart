import 'package:googleapis_auth/auth_io.dart';

class GetServerKey {
  Future<String> getServerKeyToken() async {
    final scopes = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging',
    ];

    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson({
        "type": "service_account",
        "project_id": "unitrade-5b903",
        "private_key_id": "34f8bc18e53e21bb3b34913b723dbe7bd4c1f35d",
        "private_key":
            "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCfa7oEKHEC7nQv\nyfK+KkGc3Ucm93TxlI6zPqVkyuajRvrajivrg7mR0Z4efHd13GFF9TFd5A4cIG0s\nupmP1KrVNj37brLY0c/gCElL/2EvVXbmOmK8Gl4Wh0jib7BFyilHhO/TBejGQ4eu\nDTwj6VqbXlhxrCkIwutg1bk7V7VJrs4LNj1HPMTNHZu5wtnhvym4NHYi9pE88ZJL\nT94Rt3kd2tlPcdgJKB1PMUz921x+KyKDwUaq7DZe18p87GUOoiufMEFBBn+aTno0\n/YNIjO9Lz1t8caSmlUBZTAgau6RPYVQuluQNYZEMqFA5teOpTxy4eq2B0BWChAg7\nSQ2IfaCLAgMBAAECggEAR4zsEg2smyo2z3QOFLeWdzcBRkXuILcSTPSi+tfuJ/4l\nfI4uvCeE1COGmhw26Zkdt25S19cRViJfnaGqZlmGyubrbrvCXXndmKlfbFKUZdAv\n6yjtQ4t6CxZw6eBC9y/C0yyhDs8qKEIK1V1vTpbfabgwbeRdDmediPqjhjTZUtYC\nIyVeYtd9sI1BzWm5hjQJ87l7qwX98pjiTtvPYP1m0mUbD7ubY0Nt8kGJTPoIYE76\nboGvSzvIa98XBmDH8VbNiRPd4spxOuQCejLFDeHNkdvbKKpC32nGfZZFY1nTsQNf\nWsXyrU7rjlVme8zy04d4xHHLnprw8H2sGmxUDcl28QKBgQDZb49ruUshGNAI8XtE\nGRNdS0O5KG/UWy12V3TeuA5OM2JyfAkuLdvyLOl+dVGnTLvvmdQw6VoVw1sXi+/m\n84FipoFRohxozJThyx4P6Mz8pQdnCBf2xqQ3YG4wWQLy1S2VWweyR6SLqZ4snFas\ngoDrPuzqRVzAygeXL+VrOD8hnQKBgQC7sg7ulkPvAVY0OTNrhWXozOz7z/PaEVlC\nViZiOwkh3b8lqlLBkwkJrlbQr/PTE9BWz5JGraXwbb8h6d5gUnUYaqH1rCzpwsza\nR1PATk0ELtYvSNayro2b49mfNKoh2Pjj5r9hggwcBaT7V7chkCpb6bwiKy2fBG0V\nbqxR9pYmRwKBgHm94tl3177iO6imPFQ2jgcQWwzSvTpzCpNWCFOjTi8uyhI7rJA0\nkQ+ZYeqyGVPIvPk8cfgoz42b4ebfLSVsdaccfw+L6sgqs7lwlpZlzFAwvmJLv88m\nDVAMJ+XeEK6R+YHEhBynzFN+Vte3eTgBodkVVGUfDP3MoE9gO926km5pAoGAegZd\n3NEGY2kcESGrA1kbkwk/fMqKf5hNzmnR1IUK/+B5N9SOrtiXxJp6SHxL6Ut1ZCrY\nr2iPfErtOvAfqcGR7QjOOLjyDhueML60fU6qlXCZwO363vnKiLHONsn3XcAAt7G5\ndHwmwUUOKHWzUne2gkDoFdK6eypWfNuR3kuQ/FsCgYBs44A9dV6xl8kFSvjWJ0rH\nn8H0RIozeRP9mOmFB6MvQLMhQdCAZrMfcmSmi5759KONQUT69YO/EUkEPAU2V1Mb\nFmuqUEoI4M9s919027ne5AlssO5+fhAphlvTNHxYjrT1VJcqGOC2hqN1BIDCIt8f\n47iP24QqRx1ceFV1T6XXJw==\n-----END PRIVATE KEY-----\n",
        "client_email":
            "firebase-adminsdk-oy8eh@unitrade-5b903.iam.gserviceaccount.com",
        "client_id": "100758936581974463888",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url":
            "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url":
            "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-oy8eh%40unitrade-5b903.iam.gserviceaccount.com",
        "universe_domain": "googleapis.com"
      }),
      scopes,
    );
    final accessServerKey = client.credentials.accessToken.data;
    return accessServerKey;
  }
}
