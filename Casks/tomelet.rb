# frozen_string_literal: true

cask "tomelet" do
  version "1.3.0,111"
  sha256 "00a36abb27252ef25f1f25a44c48f8ba298ec95ba900e5c8d11251c11e342b33"

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
