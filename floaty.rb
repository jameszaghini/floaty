cask 'floaty' do
  version '0.4.5'
  sha256 '76e8c71374861a7964dad938f30c2cf2e7c0124cbdb51a6415e52f2b6c5e5f3a'

  url "https://github.com/jameszaghini/floaty/releases/download/#{version}/Floaty.app.zip"
  appcast 'https://github.com/jameszaghini/floaty/releases.atom'
  name 'floaty'
  homepage 'https://github.com/jameszaghini/floaty'

app 'Floaty.app'
end
