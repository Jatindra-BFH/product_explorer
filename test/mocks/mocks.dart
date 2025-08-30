import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:product_explorer/provider/auth_provider.dart';
import 'package:hive/hive.dart';
import 'package:product_explorer/domain/data_models/user.dart';

@GenerateMocks([
  AuthProvider,
  Box<User>,
  http.Client
])
void main() {}
