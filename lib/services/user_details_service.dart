import 'package:todo_supabase/utils/constants.dart';
import 'package:supabase/supabase.dart';

class UserDetailsService {
  Future<PostgrestResponse> getSingleUserDetails() async {
    final res = await supabase
        .from('profiles')
        .select()
        .eq('id', supabase.auth.currentUser?.id)
        .single()
        .execute();
    return res;
  }
}
