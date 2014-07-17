$:.push File.expand_path('../../', __FILE__)
require 'fileutils'
require 'longbow'

command :install do |c|
  c.syntax = 'longbow install [options]'
  c.summary = 'Creates the required files in your directory.'
  c.description = ''
  c.option '-d', '--directory DIRECTORY', 'Path where the .xcproj or .xcworkspace file && the longbow.json file live.'

  c.action do |args, options|
    # Check for newer version
    Longbow::check_for_newer_version unless $nolog

    # Set Up
    @directory = options.directory ? options.directory : Dir.pwd
    @json_path = @directory + '/longbow.json'

    # Install
    if File.exist?(@json_path)
      Longbow::red '  longbow.json already exists at ' + @json_path
    else
      File.open(@json_path, 'w') do |f|
        f.write('{
	"targets":[
		{
			"name":"TargetName",
			"icon_url":"https://somewhere.net/img.png",
			"launch_phone_p_url":"https://somewhere.net/img2.png",
			"info_plist": {
        		"CFBundleIdentifier":"com.company.target1",
            	"ProprietaryKey":"Value"
      		}
		},
		{
			"name":"TargetName2",
			"icon_path":"/relative/path/to/file.png",
			"launch_phone_p_path":"/relative/path/to/file2.png",
			"info_plist": {
        		"CFBundleIdentifier":"com.company.target2",
            	"ProprietaryKey":"Value2"
      		}
		}
	],
 	"global_info_keys":{
 		"somekey":"somevalue"
 	},
    "devices":["iPhone","iPad"]
}')
      end
      Longbow::green '  longbow.json created' unless $nolog
    end
  end
end