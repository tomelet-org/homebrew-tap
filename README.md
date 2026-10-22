# Tomelet Homebrew tap

Install [Tomelet](https://tomelet.app/), an ebook reader for EPUB, PDF and comics.

## macOS

```sh
brew install --cask tomelet-org/tap/tomelet
```

The cask installs Tomelet's signed and notarised Mac app.

## Linux

The formula supports x86_64 Linux desktops with glibc 2.39 or newer. It is tested on Ubuntu 24.04.
It uses your distribution's GTK 3, WebKitGTK 4.1, libsecret and curl libraries. On Ubuntu 24.04,
install those prerequisites first:

```sh
sudo apt-get install libgtk-3-0t64 libwebkit2gtk-4.1-0 libsecret-1-0 libcurl4t64
brew install --formula tomelet-org/tap/tomelet
tomelet
```

The formula checks the runtime before installation succeeds. Keep WebKitGTK's sandbox enabled;
the formula does not install distribution packages or change your default file handlers.
Linux ARM is not supported by this formula.

To update or remove the Linux package:

```sh
brew upgrade --formula tomelet-org/tap/tomelet
brew uninstall --formula tomelet-org/tap/tomelet
```

Uninstalling the formula keeps your books, settings and credentials.

## What lives here

- `Casks/tomelet.rb` installs the notarised Mac disk image.
- `Formula/tomelet.rb` installs the Linux bundle and its desktop integration.

Both use checksum-verified releases from
[`tomelet-org/tomelet-downloads`](https://github.com/tomelet-org/tomelet-downloads).
Use the explicit `--cask` or `--formula` option to select your platform.

## Support

For help with the app, visit [Tomelet support](https://tomelet.app/support/).
Issues in this repository are for the Homebrew packages.

© 2026 Tomelet Pte Ltd
