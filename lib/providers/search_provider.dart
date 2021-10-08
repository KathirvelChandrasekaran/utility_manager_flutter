import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_supabase/services/search_service.dart';

final urlSearchNotifier = Provider(
  (_) => URLSearchService(),
);
