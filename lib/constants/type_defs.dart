// Package imports:
import 'package:dartz/dartz.dart';
import 'package:hotspot_hosts/features/common/models/failure_model.dart';

// Project imports:

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureEitherVoid = FutureEither<void>;
