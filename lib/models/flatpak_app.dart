/// Represents a Flatpak application installed on the system
class FlatpakApp {
  final String id;
  final String name;
  final String version;
  final String branch;
  final String origin;
  final String? runtime;
  final Map<String, dynamic> permissions;

  FlatpakApp({
    required this.id,
    required this.name,
    required this.version,
    required this.branch,
    required this.origin,
    this.runtime,
    Map<String, dynamic>? permissions,
  }) : permissions = permissions ?? {};

  /// Creates a FlatpakApp from flatpak command output
  factory FlatpakApp.fromFlatpakInfo(Map<String, dynamic> info) {
    return FlatpakApp(
      id: info['id'] ?? '',
      name: info['name'] ?? info['id'] ?? 'Unknown',
      version: info['version'] ?? 'Unknown',
      branch: info['branch'] ?? 'stable',
      origin: info['origin'] ?? 'Unknown',
      runtime: info['runtime'],
      permissions: info['permissions'] ?? {},
    );
  }

  FlatpakApp copyWith({
    String? id,
    String? name,
    String? version,
    String? branch,
    String? origin,
    String? runtime,
    Map<String, dynamic>? permissions,
  }) {
    return FlatpakApp(
      id: id ?? this.id,
      name: name ?? this.name,
      version: version ?? this.version,
      branch: branch ?? this.branch,
      origin: origin ?? this.origin,
      runtime: runtime ?? this.runtime,
      permissions: permissions ?? this.permissions,
    );
  }
}
