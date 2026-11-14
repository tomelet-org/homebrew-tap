# frozen_string_literal: true

cask "tomelet" do
  version "1.5.0,138"
  sha256 "f20f81aea99dbc4fdc57c80a822087faaa1fa73a71e96b52ac58fae6555d5fb1"

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
