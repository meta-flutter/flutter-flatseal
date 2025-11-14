/// Represents a Flatpak permission category and its values
class Permission {
  final String category;
  final String key;
  final String displayName;
  final String? description;
  final PermissionType type;
  bool enabled;
  String? value;

  Permission({
    required this.category,
    required this.key,
    required this.displayName,
    this.description,
    required this.type,
    this.enabled = false,
    this.value,
  });

  Permission copyWith({
    String? category,
    String? key,
    String? displayName,
    String? description,
    PermissionType? type,
    bool? enabled,
    String? value,
  }) {
    return Permission(
      category: category ?? this.category,
      key: key ?? this.key,
      displayName: displayName ?? this.displayName,
      description: description ?? this.description,
      type: type ?? this.type,
      enabled: enabled ?? this.enabled,
      value: value ?? this.value,
    );
  }
}

enum PermissionType {
  boolean,
  filesystem,
  device,
  feature,
  socket,
  environment,
  dbus,
  custom,
}

/// Predefined Flatpak permissions based on Flatseal categories
class FlatpakPermissions {
  static List<Permission> getDefaultPermissions() {
    return [
      // Filesystem permissions
      Permission(
        category: 'filesystems',
        key: 'home',
        displayName: 'All user files',
        description: 'Access to all files in home directory',
        type: PermissionType.filesystem,
      ),
      Permission(
        category: 'filesystems',
        key: 'host',
        displayName: 'All system files',
        description: 'Access to all files on the system',
        type: PermissionType.filesystem,
      ),
      Permission(
        category: 'filesystems',
        key: 'xdg-download',
        displayName: 'Downloads folder',
        description: 'Access to downloads folder',
        type: PermissionType.filesystem,
      ),
      Permission(
        category: 'filesystems',
        key: 'xdg-documents',
        displayName: 'Documents folder',
        description: 'Access to documents folder',
        type: PermissionType.filesystem,
      ),
      Permission(
        category: 'filesystems',
        key: 'xdg-pictures',
        displayName: 'Pictures folder',
        description: 'Access to pictures folder',
        type: PermissionType.filesystem,
      ),
      Permission(
        category: 'filesystems',
        key: 'xdg-music',
        displayName: 'Music folder',
        description: 'Access to music folder',
        type: PermissionType.filesystem,
      ),
      Permission(
        category: 'filesystems',
        key: 'xdg-videos',
        displayName: 'Videos folder',
        description: 'Access to videos folder',
        type: PermissionType.filesystem,
      ),

      // Device access
      Permission(
        category: 'devices',
        key: 'all',
        displayName: 'All devices',
        description: 'Access to all devices',
        type: PermissionType.device,
      ),
      Permission(
        category: 'devices',
        key: 'dri',
        displayName: 'GPU acceleration',
        description: 'Access to GPU for hardware acceleration',
        type: PermissionType.device,
      ),
      Permission(
        category: 'devices',
        key: 'kvm',
        displayName: 'Virtualization',
        description: 'Access to KVM for virtualization',
        type: PermissionType.device,
      ),

      // Features
      Permission(
        category: 'features',
        key: 'devel',
        displayName: 'Development access',
        description: 'Access to development tools',
        type: PermissionType.feature,
      ),
      Permission(
        category: 'features',
        key: 'multiarch',
        displayName: 'Multi-architecture',
        description: 'Support for multiple architectures',
        type: PermissionType.feature,
      ),
      Permission(
        category: 'features',
        key: 'bluetooth',
        displayName: 'Bluetooth',
        description: 'Access to Bluetooth devices',
        type: PermissionType.feature,
      ),
      Permission(
        category: 'features',
        key: 'canbus',
        displayName: 'CAN bus',
        description: 'Access to CAN bus',
        type: PermissionType.feature,
      ),

      // Sockets
      Permission(
        category: 'sockets',
        key: 'x11',
        displayName: 'X11 windowing system',
        description: 'Access to X11 display server',
        type: PermissionType.socket,
      ),
      Permission(
        category: 'sockets',
        key: 'wayland',
        displayName: 'Wayland windowing system',
        description: 'Access to Wayland display server',
        type: PermissionType.socket,
      ),
      Permission(
        category: 'sockets',
        key: 'fallback-x11',
        displayName: 'Fallback to X11',
        description: 'Fallback to X11 if Wayland is not available',
        type: PermissionType.socket,
      ),
      Permission(
        category: 'sockets',
        key: 'pulseaudio',
        displayName: 'PulseAudio',
        description: 'Access to PulseAudio sound server',
        type: PermissionType.socket,
      ),
      Permission(
        category: 'sockets',
        key: 'session-bus',
        displayName: 'Session bus',
        description: 'Access to session D-Bus',
        type: PermissionType.socket,
      ),
      Permission(
        category: 'sockets',
        key: 'system-bus',
        displayName: 'System bus',
        description: 'Access to system D-Bus',
        type: PermissionType.socket,
      ),
      Permission(
        category: 'sockets',
        key: 'ssh-auth',
        displayName: 'SSH agent',
        description: 'Access to SSH authentication agent',
        type: PermissionType.socket,
      ),
      Permission(
        category: 'sockets',
        key: 'pcsc',
        displayName: 'Smart cards',
        description: 'Access to smart card daemon',
        type: PermissionType.socket,
      ),
      Permission(
        category: 'sockets',
        key: 'cups',
        displayName: 'Print system',
        description: 'Access to CUPS printing system',
        type: PermissionType.socket,
      ),

      // Network
      Permission(
        category: 'features',
        key: 'network',
        displayName: 'Network access',
        description: 'Access to network',
        type: PermissionType.feature,
      ),
    ];
  }
}
