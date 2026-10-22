# frozen_string_literal: true

cask "tomelet" do
  version "1.3.0,100"
  sha256 "66db692417f005b2ff62e4f65d2e46b9ab4c0d7edd9223fe4cddce03e584f9a3"

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
