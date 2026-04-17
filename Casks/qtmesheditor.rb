cask 'qtmesheditor' do
  version '2.27.0'
  sha256 '9463f7d759c7e0114cf0f2bb259550af4ade85e74004c1d2b4a131d2fac7ed75'

  url "https://github.com/fernandotonon/QtMeshEditor/releases/download/#{version}/QtMeshEditor-#{version}-MacOS.dmg"
  name 'QtMeshEditor'
  desc 'Qt-based Ogre3D Mesh Editor with AI-enhanced Material Editor'
  homepage 'https://github.com/fernandotonon/QtMeshEditor'

  livecheck do
    url :url
    strategy :github_latest
  end

  app 'QtMeshEditor.app'

  # CLI access: create symlinks in /usr/local/bin
  binary "#{appdir}/QtMeshEditor.app/Contents/MacOS/QtMeshEditor", target: 'qtmesheditor'

  # Temporary workaround for architecture compatibility issues
  postflight do
    # Remove quarantine attribute that may cause "not supported on this mac" errors
    system_command "/usr/bin/xattr",
                   args: ["-rd", "com.apple.quarantine", "#{appdir}/QtMeshEditor.app"],
                   sudo: false

    # Create qtmesh symlink for CLI pipeline usage
    target_dir = "#{HOMEBREW_PREFIX}/bin"
    qtmesh_link = "#{target_dir}/qtmesh"
    File.delete(qtmesh_link) if File.symlink?(qtmesh_link)
    File.symlink("#{appdir}/QtMeshEditor.app/Contents/MacOS/QtMeshEditor", qtmesh_link)
  end

  uninstall_postflight do
    qtmesh_link = "#{HOMEBREW_PREFIX}/bin/qtmesh"
    File.delete(qtmesh_link) if File.symlink?(qtmesh_link)
  end

  caveats do
    <<~EOS
      CLI commands are now available:
        qtmesheditor    # Launch the GUI
        qtmesh          # CLI pipeline (info, convert, fix, scan, etc.)

      Example:
        qtmesh info model.fbx --json
        qtmesh scan ./assets --fail-on warning

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
