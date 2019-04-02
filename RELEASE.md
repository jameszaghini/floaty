# Release steps

* Bump version in Xcode & floaty.rb
* Switch schemes build configuration to "Release" & build
* Right click on Floaty.app in the Products folder and reveal in finder
* Zip Floaty.app
* Run `shasum -a 256 <path-to-floaty.app>`
* Put the sha in floaty.rb
* Commit and merge to master
* Create release on github