cask 'qtmesheditor' do
  version '2.2.0'
  sha256 '49ef824755062f69d7870a08a8a7823c58adf20c46b81bead3e07e02cec880d0'

  url "https://github.com/fernandotonon/QtMeshEditor/releases/download/#{version}/QtMeshEditor-#{version}-MacOS.dmg"
  name 'QtMeshEditor'
  desc 'Qt-based Ogre3D Mesh Editor with AI-enhanced Material Editor'
  homepage 'https://github.com/fernandotonon/QtMeshEditor'

  livecheck do
    url :url
    strategy :github_latest
  end

  app 'QtMeshEditor.app'

  # Temporary workaround for architecture compatibility issues
  postflight do
    # Remove quarantine attribute that may cause "not supported on this mac" errors
    system_command "/usr/bin/xattr",
                   args: ["-rd", "com.apple.quarantine", "#{appdir}/QtMeshEditor.app"],
                   sudo: false
  end

  caveats do
    <<~EOS
      If you encounter "not supported on this mac" error:
      
      1. For Apple Silicon Macs, try running with Rosetta:
         arch -x86_64 /Applications/QtMeshEditor.app/Contents/MacOS/QtMeshEditor
      
      2. You may need to allow the app in System Preferences > Security & Privacy
      
      3. If issues persist, please report at: https://github.com/fernandotonon/QtMeshEditor/issues
    EOS
  end

  zap trash: [
    '~/Library/Preferences/com.qtmesheditor.QtMeshEditor.plist',
    '~/Library/Saved Application State/com.qtmesheditor.QtMeshEditor.savedState',
  ]
end
