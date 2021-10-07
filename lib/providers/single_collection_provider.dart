import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_supabase/services/meta_collection_service.dart';

final singleCollectionNotifier = Provider((_) => MetaCollectionService());
