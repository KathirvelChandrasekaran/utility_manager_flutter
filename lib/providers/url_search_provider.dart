import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase/supabase.dart';
import 'package:todo_supabase/providers/search_provider.dart';

final urlSearchProvider =
    FutureProvider.autoDispose.family<PostgrestResponse, String>(
  (ref, query) {
    final res = ref.read(urlSearchNotifier);
    return res.get(query);
  },
);
