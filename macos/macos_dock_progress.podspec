#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint macos_dock_progress.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'macos_dock_progress'
  s.version          = '1.1.0'
  s.summary          = 'An API wrapper of DockProgress for Flutter'
  s.description      = <<-DESC
  Interacting with macOS dock icon progress bars in Flutter.
                       DESC
  s.homepage         = 'https://github.com/NightFeather0615/macos_dock_progress'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'NightFeather' => 'leolee50910@gmail.com' }

  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.dependency 'FlutterMacOS'
  s.dependency 'DockProgress'

  s.platform = :osx, '10.14'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
