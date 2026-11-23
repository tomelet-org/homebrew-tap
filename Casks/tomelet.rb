# frozen_string_literal: true

cask "tomelet" do
  version "1.5.2,148"
  sha256 "91ca7b7560cfb9720692f7e3dc7d8cd16a773afadebe8773fa32db1348cc8e16"

  url "https://github.com/tomelet-org/tomelet-downloads/releases/download/app-v#{version.csv.first}%2B#{version.csv.second}/tomelet-#{version.csv.first}-macos.dmg"
  name "Tomelet"
  desc "Ebook reader for EPUB, PDF and comics"
  homepage "https://tomelet.app/"

  livecheck do
    url "https://github.com/tomelet-org/tomelet-downloads"
    regex(/^app-v(\d+\.\d+\.\d+)\+(\d+)$/i)
    strategy :github_releases do |json, regex|
      json.filter_map do |release|
        next if release["draft"] || release["prerelease"]

        match = release["tag_name"]&.match(regex)
        next unless match
        next unless release["assets"]&.any? { |asset| asset["name"] == "tomelet-#{match[1]}-macos.dmg" }

        "#{match[1]},#{match[2]}"
      end
    end
  end

  depends_on macos: :monterey

  app "Tomelet.app"

  zap trash: "~/Library/Containers/app.tomelet"
end
