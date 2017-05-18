require "hashie"
require "yaml_db"
require "aws-sdk"
require "active_support"

module ArchiveToS3

	class Core
		attr_accessor :setting_file_path

		def initialize setting_file_path: ""
			@setting_file_path = setting_file_path.present? ? setting_file_path : File.expand_path("s3_archive.yml", Rails.root)

			path = File.expand_path('config/database.yml', Rails.root)
			config = YAML.load_file(path)[rails_env]
			ActiveRecord::Base.establish_connection(config)
		end

		def generate_settings
			File.open(setting_file_path, "w") do |f|
				f.puts(default_settings.to_yaml)
			end
		end

		def archive
			validation
			db_data_dump(backup_name)
			archive_filename = "db/#{backup_name}.zip"
			system("zip #{archive_filename} db/#{backup_name}/*")
 		  ret = s3_client.put_object(
 		  	bucket: settings.bucket_name,
 		  	key: backup_name,
 		  	body: File.expand_path(archive_filename, Rails.root),
 		  	tagging: app_name
 		  	)
			File.delete(File.expand_path(archive_filename, Rails.root))
			force_delete(File.expand_path("db/#{backup_name}", Rails.root))

 		  p ret
		end

		def validation
			raise StandardError.new("aws access_key was invalid!") unless settings.aws_access_key.present?
			raise StandardError.new("aws access_secret was invalid!") unless settings.aws_access_secret.present?
			raise StandardError.new("aws bucket name was invalid!") unless settings.bucket_name.present?
		end

		private

		def app_name
			return "dummy" unless defined?(Rails.application)
			Rails.application.class.parent_name.underscore
		end

		def app_env
			return "test" unless defined?(Rails.application)
			Rails.env
		end

		# def app_root
		# 	return File.expand_path("../../../test/dummy", __FILE__) unless defined?(Rails.application)
		# 	Rails.root
		# end

		def backup_name
			@_backup_name ||= "#{app_name}-#{app_env}-#{Time.now.strftime('%Y-%m-%d-%H%M%S')}"
		end

		def db_data_dump filename
			ENV["dir"] = backup_name
			YamlDb::RakeTasks.data_dump_dir_task
		end

		def rails_env
			@_rails_env ||= ENV["RAILS_ENV"].present? ? ENV["RAILS_ENV"] : "test"
		end

		def aws_credentials
			@_aws_credentials ||= Aws::Credentials.new(settings.aws_access_key, settings.aws_access_secret)
		end

		def s3_client
			@_s3_client ||= Aws::S3::Client.new(region: settings.region, credentials: aws_credentials)
		end

		def settings
			@_settings ||= Hashie::Mash.load(setting_file_path)
		end

		def default_settings
			{
				"aws_access_key": "<YOUR AWS ACCESS KEY>",
				"aws_access_secret": "<YOUR AWS SECRET>",
				"region": "<YOUR REGION>",
				"bucket_name": "<S3 BUCKET NAME>",
			}
		end

		def force_delete dir_path
			Dir.glob("#{dir_path}/*").map{|f| File.delete(f) }
			Dir.delete(dir_path)
		end
	end
end


if __FILE__ == $0
	require "pry"
	require "awesome_print"

	core = ArchiveToS3::Core.new(setting_file_path: File.expand_path("../../../s3_archive.yml", __FILE__))
	ap core.archive
end
