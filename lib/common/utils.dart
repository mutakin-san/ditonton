import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/io_client.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();


EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}


Future<SecurityContext> get globalContext async {
  final sslCert = await rootBundle.load('certificates/themoviedb_cert.pem');
  SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
  securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
  return securityContext;
}


Future<http.Client> getSSLPinningClient() async {
  HttpClient client = HttpClient(context: await globalContext);
  client.badCertificateCallback =
      (X509Certificate cert, String host, int port) => false;
  IOClient ioClient = IOClient(client);
  return ioClient;
}