import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_supabase/services/user_details_service.dart';
import 'package:supabase/supabase.dart';

final getSingleUserDetailsProvider =
    FutureProvider.autoDispose<PostgrestResponse>(
  (_) => UserDetailsService().getSingleUserDetails(),
);
