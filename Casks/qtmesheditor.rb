cask 'qtmesheditor' do
  version '1.8.0'
  sha256 '41aad2917870b377894d0766d49ed5e7c39d31db3a40b9ffd5035bc9b5d754e8'

  url "https://github.com/fernandotonon/QtMeshEditor/releases/download/#{version}/QtMeshEditor-#{version}-MacOS.dmg"
  name 'QtMeshEditor'
  homepage 'https://github.com/fernandotonon/QtMeshEditor'
  desc 'Qt-based Ogre3D Mesh Editor'

  app 'QtMeshEditor.app'
end
