cask 'floaty' do
  version '0.4.5'
  sha256 '6f37b22518df5c43875bf813cac2c19e0f77c79f97226c4c7690004aa779104a'

  url "https://github.com/jameszaghini/floaty/releases/download/#{version}/Floaty.app.zip"
  appcast 'https://github.com/jameszaghini/floaty/releases.atom'
  name 'floaty'
  homepage 'https://github.com/jameszaghini/floaty'

app 'Floaty.app'
end
