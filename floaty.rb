cask 'floaty' do
  version '0.4.1'
  sha256 '502d4dab156df01da3a51ed652895ea5f2211ac5be43cb3f2e40e25a5a92c5d6'

  url "https://github.com/jameszaghini/floaty/releases/download/#{version}/Floaty.app.zip"
  appcast 'https://github.com/jameszaghini/floaty/releases.atom'
  name 'floaty'
  homepage 'https://github.com/jameszaghini/floaty'

app 'Floaty.app'
end
