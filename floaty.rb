cask 'floaty' do
  version '0.4.4'
  sha256 '0c34cbf80873f923afcd1d2319f5b307b6390f06a4512f0f95d7362342d7dae6'

  url "https://github.com/jameszaghini/floaty/releases/download/#{version}/Floaty.app.zip"
  appcast 'https://github.com/jameszaghini/floaty/releases.atom'
  name 'floaty'
  homepage 'https://github.com/jameszaghini/floaty'

app 'Floaty.app'
end
