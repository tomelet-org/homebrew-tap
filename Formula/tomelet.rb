class Tomelet < Formula
  desc "Read and annotate your ebooks"
  homepage "https://tomelet.app/"
  url "https://github.com/tomelet-org/tomelet-downloads/releases/download/app-v1.3.0%2B80/tomelet-1.3.0-linux-x86_64.tar.gz"
  version "1.3.0.80"
  sha256 "75ef14c4fc22564cba9a2920da21883e7329108d678be53847e7e222b36003a5"
  # Tomelet is proprietary; the shipped AppStream metadata links to its terms.
  license :cannot_represent

  depends_on arch: :x86_64
  depends_on :linux

  # Keep the upstream release's precompiled bytes intact.
  skip_clean "libexec/bundle"

  def install
    libexec.install "bundle"
    check_runtime
    bin.install_symlink libexec/"bundle/tomelet"
    share.install Dir["share/*"]
    inreplace share/"applications/app.tomelet.Tomelet.desktop",
              "Exec=tomelet %U", "Exec=#{opt_bin}/tomelet %U"
  end

  def check_runtime
    bundle = libexec/"bundle"
    # libapp is Flutter's AOT payload; libdartjni is an unused Android JNI artifact.
    # Neither belongs to the Linux dynamic-library closure.
    libraries = (bundle/"lib").glob("*.so").reject { |path| %w[libapp.so libdartjni.so].include?(path.basename.to_s) }
    output = Utils.safe_popen_read(
      { "LD_LIBRARY_PATH" => (bundle/"lib").to_s },
      "/usr/bin/ldd", bundle/"tomelet", bundle/"lib/crashpad_handler", *libraries
    )
    odie "Missing Linux runtime libraries. #{runtime_prerequisites}\n#{output}" if output.include?("not found")
    external_brew = output.scan(%r{=> (/\S+)}).flatten.any? do |path|
      path.start_with?("#{HOMEBREW_PREFIX}/") && !path.start_with?("#{bundle}/")
    end
    odie "Tomelet requires the distribution runtime, without mixed Homebrew libraries." if external_brew
    output
  end

  def runtime_prerequisites
    "On Ubuntu 24.04, install libgtk-3-0t64, libwebkit2gtk-4.1-0, libsecret-1-0 and libcurl4t64."
  end

  def caveats
    <<~EOS
      Requires an x86_64 Linux desktop with glibc 2.39 or newer.
      #{runtime_prerequisites}
      Keep WebKitGTK's sandbox enabled. This formula does not install distribution packages.
      Run tomelet to open the reader. Uninstalling this formula keeps your library and settings.
    EOS
  end

  test do
    puts check_runtime
    assert_path_exists bin/"tomelet"
    assert_match "Exec=#{opt_bin}/tomelet %U", (share/"applications/app.tomelet.Tomelet.desktop").read
    assert_path_exists share/"metainfo/app.tomelet.Tomelet.metainfo.xml"
  end
end
