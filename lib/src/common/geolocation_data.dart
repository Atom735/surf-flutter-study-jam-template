import 'package:meta/meta.dart';

/// Data transfer object representing geolocation point.
@immutable
class GeolocationData {
  const GeolocationData(this.latitude, this.longitude);

  /// Latitude, in degrees.
  final double latitude;

  /// Longitude, in degrees.
  final double longitude;

  @override
  String toString() =>
      'GeolocationData(latitude: $latitude, longitude: $longitude)';
}
