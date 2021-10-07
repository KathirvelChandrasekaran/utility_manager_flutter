import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_supabase/services/meta_collection_service.dart';
import 'package:supabase/supabase.dart';

final metaCollectionOfUser = FutureProvider.autoDispose<PostgrestResponse>(
  (_) => MetaCollectionService().getData(),
);
