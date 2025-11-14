# Packaging Flutter Flatseal

Guide for creating distribution packages for Flutter Flatseal.

## Table of Contents

1. [Snap Package](#snap-package)
2. [Flatpak Package](#flatpak-package)
3. [AppImage](#appimage)
4. [Debian Package](#debian-package)
5. [RPM Package](#rpm-package)
6. [Arch Linux Package](#arch-linux-package)

## Snap Package

Snap packages work across many Linux distributions.

### Prerequisites

```bash
sudo apt install snapcraft
```

### Create snapcraft.yaml

Create `snap/snapcraft.yaml`:

```yaml
name: flutter-flatseal
version: '1.0.0'
summary: Manage Flatpak permissions
description: |
  A Flutter application to manage Flatpak sandbox permissions,
  inspired by the original Flatseal project.

base: core22
confinement: classic
grade: stable

parts:
  flutter-flatseal:
    plugin: flutter
    source: .
    flutter-target: lib/main.dart
    build-packages:
      - clang
      - cmake
      - ninja-build
      - libgtk-3-dev
    stage-packages:
      - libgtk-3-0
      - flatpak

apps:
  flutter-flatseal:
    command: flutter_flatseal
    desktop: linux/flutter_flatseal.desktop
    plugs:
      - desktop
      - desktop-legacy
      - wayland
      - x11
      - home
      - network
```

### Build Snap

```bash
snapcraft clean
snapcraft
```

### Install Locally

```bash
sudo snap install flutter-flatseal_1.0.0_amd64.snap --dangerous
```

### Publish to Snap Store

```bash
snapcraft login
snapcraft upload flutter-flatseal_1.0.0_amd64.snap --release=stable
```

## Flatpak Package

Create a Flatpak package for distribution through Flathub.

### Prerequisites

```bash
sudo apt install flatpak-builder
```

### Create Manifest

Create `com.example.FlutterFlatseal.yml`:

```yaml
app-id: com.example.FlutterFlatseal
runtime: org.freedesktop.Platform
runtime-version: '23.08'
sdk: org.freedesktop.Sdk
command: flutter_flatseal

finish-args:
  - --share=ipc
  - --socket=wayland
  - --socket=x11
  - --socket=fallback-x11
  - --device=dri
  - --filesystem=host
  - --system-talk-name=org.freedesktop.Flatpak

modules:
  - name: flutter-flatseal
    buildsystem: simple
    build-commands:
      - install -Dm755 flutter_flatseal /app/bin/flutter_flatseal
      - install -Dm644 linux/flutter_flatseal.desktop /app/share/applications/com.example.FlutterFlatseal.desktop
      - install -Dm644 linux/flutter_flatseal.png /app/share/icons/hicolor/128x128/apps/com.example.FlutterFlatseal.png
    sources:
      - type: archive
        path: flutter-flatseal-1.0.0.tar.gz
```

### Build Flatpak

```bash
# Build
flatpak-builder --force-clean build-dir com.example.FlutterFlatseal.yml

# Test locally
flatpak-builder --run build-dir com.example.FlutterFlatseal.yml flutter_flatseal

# Create repository
flatpak-builder --repo=repo --force-clean build-dir com.example.FlutterFlatseal.yml

# Install from local repo
flatpak --user remote-add --no-gpg-verify flutter-flatseal-repo repo
flatpak --user install flutter-flatseal-repo com.example.FlutterFlatseal
```

### Publish to Flathub

1. Fork https://github.com/flathub/flathub
2. Create PR with your manifest
3. Follow Flathub guidelines

## AppImage

Portable application format that works on most Linux distributions.

### Prerequisites

```bash
# Download appimagetool
wget https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage
chmod +x appimagetool-x86_64.AppImage
```

### Create AppDir Structure

```bash
#!/bin/bash
set -e

APP_DIR=flutter-flatseal.AppDir

# Create directory structure
mkdir -p $APP_DIR/usr/bin
mkdir -p $APP_DIR/usr/lib
mkdir -p $APP_DIR/usr/share/applications
mkdir -p $APP_DIR/usr/share/icons/hicolor/128x128/apps

# Copy application
cp -r build/linux/x64/release/bundle/* $APP_DIR/usr/bin/
mv $APP_DIR/usr/bin/flutter_flatseal $APP_DIR/usr/bin/flutter-flatseal

# Copy desktop file
cp linux/flutter_flatseal.desktop $APP_DIR/usr/share/applications/

# Copy icon
cp linux/flutter_flatseal.png $APP_DIR/usr/share/icons/hicolor/128x128/apps/

# Create AppRun script
cat > $APP_DIR/AppRun <<'EOF'
#!/bin/bash
SELF=$(readlink -f "$0")
HERE=${SELF%/*}
export PATH="${HERE}/usr/bin:${PATH}"
export LD_LIBRARY_PATH="${HERE}/usr/lib:${LD_LIBRARY_PATH}"
exec "${HERE}/usr/bin/flutter-flatseal" "$@"
EOF

chmod +x $APP_DIR/AppRun

# Create desktop file
cat > $APP_DIR/flutter-flatseal.desktop <<EOF
[Desktop Entry]
Name=Flutter Flatseal
Exec=flutter-flatseal
Icon=flutter_flatseal
Type=Application
Categories=System;Settings;
EOF

# Link icon
ln -sf usr/share/icons/hicolor/128x128/apps/flutter_flatseal.png $APP_DIR/flutter_flatseal.png
```

### Build AppImage

```bash
# Create AppImage
./appimagetool-x86_64.AppImage flutter-flatseal.AppDir

# Result: Flutter_Flatseal-x86_64.AppImage
```

### Test AppImage

```bash
chmod +x Flutter_Flatseal-x86_64.AppImage
./Flutter_Flatseal-x86_64.AppImage
```

## Debian Package

Create a .deb package for Debian/Ubuntu distributions.

### Prerequisites

```bash
sudo apt install dpkg-dev debhelper
```

### Create Debian Package Structure

```bash
mkdir -p debian-package/DEBIAN
mkdir -p debian-package/usr/bin
mkdir -p debian-package/usr/share/applications
mkdir -p debian-package/usr/share/icons/hicolor/128x128/apps
```

### Create Control File

Create `debian-package/DEBIAN/control`:

```
Package: flutter-flatseal
Version: 1.0.0
Section: utils
Priority: optional
Architecture: amd64
Depends: libgtk-3-0, flatpak
Maintainer: Your Name <your.email@example.com>
Description: Manage Flatpak permissions
 A Flutter application to manage Flatpak sandbox permissions,
 inspired by the original Flatseal project.
 .
 Features include viewing installed Flatpak applications,
 managing permissions, and overriding sandbox settings.
```

### Copy Files

```bash
# Copy application
cp -r build/linux/x64/release/bundle/* debian-package/usr/bin/

# Copy desktop file
cp linux/flutter_flatseal.desktop debian-package/usr/share/applications/

# Copy icon
cp linux/flutter_flatseal.png debian-package/usr/share/icons/hicolor/128x128/apps/
```

### Build Package

```bash
dpkg-deb --build debian-package flutter-flatseal_1.0.0_amd64.deb
```

### Install Package

```bash
sudo dpkg -i flutter-flatseal_1.0.0_amd64.deb
sudo apt-get install -f  # Fix dependencies
```

## RPM Package

Create an RPM package for Fedora/RHEL/CentOS.

### Prerequisites

```bash
sudo dnf install rpm-build rpmdevtools
```

### Setup RPM Build Tree

```bash
rpmdev-setuptree
```

### Create Spec File

Create `~/rpmbuild/SPECS/flutter-flatseal.spec`:

```spec
Name:           flutter-flatseal
Version:        1.0.0
Release:        1%{?dist}
Summary:        Manage Flatpak permissions

License:        GPL-3.0
URL:            https://github.com/meta-flutter/flutter-flatseal
Source0:        %{name}-%{version}.tar.gz

BuildRequires:  cmake
BuildRequires:  ninja-build
BuildRequires:  gtk3-devel
Requires:       gtk3
Requires:       flatpak

%description
A Flutter application to manage Flatpak sandbox permissions,
inspired by the original Flatseal project.

%prep
%setup -q

%build
# Application is pre-built

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT/usr/bin
mkdir -p $RPM_BUILD_ROOT/usr/share/applications
mkdir -p $RPM_BUILD_ROOT/usr/share/icons/hicolor/128x128/apps

cp -r * $RPM_BUILD_ROOT/usr/bin/
cp linux/flutter_flatseal.desktop $RPM_BUILD_ROOT/usr/share/applications/
cp linux/flutter_flatseal.png $RPM_BUILD_ROOT/usr/share/icons/hicolor/128x128/apps/

%files
/usr/bin/flutter_flatseal
/usr/share/applications/flutter_flatseal.desktop
/usr/share/icons/hicolor/128x128/apps/flutter_flatseal.png

%changelog
* Thu Nov 14 2024 Your Name <your.email@example.com> - 1.0.0-1
- Initial package
```

### Build RPM

```bash
# Create source tarball
cd build/linux/x64/release
tar czf ~/rpmbuild/SOURCES/flutter-flatseal-1.0.0.tar.gz bundle/

# Build RPM
cd ~/rpmbuild/SPECS
rpmbuild -ba flutter-flatseal.spec
```

### Install RPM

```bash
sudo dnf install ~/rpmbuild/RPMS/x86_64/flutter-flatseal-1.0.0-1.fc38.x86_64.rpm
```

## Arch Linux Package

Create a PKGBUILD for Arch Linux.

### Create PKGBUILD

Create `PKGBUILD`:

```bash
# Maintainer: Your Name <your.email@example.com>
pkgname=flutter-flatseal
pkgver=1.0.0
pkgrel=1
pkgdesc="Manage Flatpak permissions"
arch=('x86_64')
url="https://github.com/meta-flutter/flutter-flatseal"
license=('GPL3')
depends=('gtk3' 'flatpak')
source=("$pkgname-$pkgver.tar.gz")
sha256sums=('SKIP')

package() {
    cd "$srcdir/$pkgname-$pkgver"
    
    # Install binary
    install -Dm755 flutter_flatseal "$pkgdir/usr/bin/flutter_flatseal"
    
    # Install desktop file
    install -Dm644 linux/flutter_flatseal.desktop \
        "$pkgdir/usr/share/applications/flutter_flatseal.desktop"
    
    # Install icon
    install -Dm644 linux/flutter_flatseal.png \
        "$pkgdir/usr/share/icons/hicolor/128x128/apps/flutter_flatseal.png"
}
```

### Build Package

```bash
makepkg -si
```

### Publish to AUR

1. Create AUR account at https://aur.archlinux.org
2. Generate SSH keys and add to AUR
3. Clone AUR repository:
   ```bash
   git clone ssh://aur@aur.archlinux.org/flutter-flatseal.git
   ```
4. Add PKGBUILD and .SRCINFO
5. Commit and push

## Universal Build Script

Create `package.sh` to build all formats:

```bash
#!/bin/bash
set -e

VERSION="1.0.0"

echo "Building Flutter Flatseal v$VERSION packages..."

# Build application
flutter build linux --release

# Build Snap
if command -v snapcraft &> /dev/null; then
    echo "Building Snap package..."
    snapcraft
fi

# Build AppImage
if [ -f appimagetool-x86_64.AppImage ]; then
    echo "Building AppImage..."
    ./build-appimage.sh
fi

# Build Debian package
echo "Building Debian package..."
./build-deb.sh

echo "Package building complete!"
echo "Check the output directories for packages."
```

## Distribution

### GitHub Releases

1. Create release tag:
   ```bash
   git tag -a v1.0.0 -m "Release v1.0.0"
   git push origin v1.0.0
   ```

2. Upload packages to GitHub Releases

### Package Repositories

- **Snap Store**: `snapcraft upload`
- **Flathub**: Submit PR to flathub/flathub
- **AUR**: Push to AUR repository
- **PPA**: Create Launchpad PPA

## Signing Packages

### Sign AppImage

```bash
gpg --armor --detach-sign Flutter_Flatseal-x86_64.AppImage
```

### Sign Debian Package

```bash
dpkg-sig --sign builder flutter-flatseal_1.0.0_amd64.deb
```

### Sign RPM

```bash
rpm --addsign flutter-flatseal-1.0.0-1.fc38.x86_64.rpm
```

## Best Practices

1. **Version Consistency**: Use same version across all package formats
2. **Metadata**: Include proper descriptions, categories, and keywords
3. **Icons**: Provide icons in multiple sizes
4. **Desktop Integration**: Proper .desktop files with correct categories
5. **Dependencies**: Declare all required dependencies
6. **Testing**: Test packages on clean systems
7. **Documentation**: Include changelog and installation instructions
8. **Signing**: Sign packages for security
9. **Repository**: Maintain package build scripts in version control
10. **Automation**: Use CI/CD for automated package builds

## References

- [Snapcraft Documentation](https://snapcraft.io/docs)
- [Flatpak Documentation](https://docs.flatpak.org/)
- [AppImage Documentation](https://docs.appimage.org/)
- [Debian Packaging Guide](https://www.debian.org/doc/manuals/maint-guide/)
- [RPM Packaging Guide](https://rpm-packaging-guide.github.io/)
- [Arch Package Guidelines](https://wiki.archlinux.org/title/PKGBUILD)
