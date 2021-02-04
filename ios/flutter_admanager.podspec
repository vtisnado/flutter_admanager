#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'flutter_admanager'
  s.version          = '0.11.2'
  s.summary          = 'A new Flutter plugin.'
  s.description      = <<-DESC
A new Flutter plugin.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'Google-Mobile-Ads-SDK' # , '~> 7.5.0'
  s.static_framework = true

  s.pod_target_xcconfig = {
		'DEFINES_MODULE' => 'YES',
		# 'ONLY_ACTIVE_ARCH' => 'YES'
	}
	# s.user_target_xcconfig = {
	# 	'ONLY_ACTIVE_ARCH' => 'YES'
	# } # not recommended

  s.ios.deployment_target = '10.0'
end

