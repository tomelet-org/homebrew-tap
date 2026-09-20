# Tomelet Homebrew tap

The Homebrew tap for [Tomelet](https://tomelet.app/), an ebook reader for EPUB, PDF and comics.

> **Not published yet.** The cask lands here once the Mac app is signed with a Developer ID certificate and
> notarised. Until then this tap is empty on purpose, and the Mac app isn't downloadable anywhere. Android,
> Windows and Linux builds are at [tomelet.app](https://tomelet.app/).

Once it is published:

```
brew install --cask tomelet-org/tap/tomelet
```

Homebrew expands `tomelet-org/tap` to this repository.

## What lives here

- `Casks/tomelet.rb` — the cask. It installs the notarised Tomelet disk image that each release publishes to
  [`tomelet-org/tomelet-downloads`](https://github.com/tomelet-org/tomelet-downloads), and nothing else.

## Support

Bugs and questions about the app belong at [tomelet.app/support](https://tomelet.app/support/). Issues here are
for the cask itself.

© 2026 Tomelet Pte Ltd
