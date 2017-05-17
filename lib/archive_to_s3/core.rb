require "hashie"

module ArchiveToS3
	class Core
		def generate_settings
			File.open(setting_file_path, "w") do |f|
				f.puts(default_settings.to_yaml)
			end
		end

		def archive
			raise StandardError.new("s3_archive.yml doesn't exist. please execute 's3:initialize'") unless File.exist?(setting_file_path)
			raise StandardError.new("aws access_key was invalid!") unless settings.aws_access_key.present?		
			raise StandardError.new("aws access_secret was invalid!") unless settings.aws_access_secret.present?		
			raise StandardError.new("aws bucket name was invalid!") unless settings.bucket_name.present?		

			p settings.aws_access_key
		end

		private

		def setting_file_path
			File.expand_path("s3_archive.yml", Rails.root)
		end

		def settings
			@_settings ||= Hashie::Mash.load(setting_file_path)
		end

		def default_settings
			{
				"aws_access_key": "<YOUR AWS ACCESS KEY>",
				"aws_access_secret": "<YOUR AWS SECRET>",
				"bucket_name": "<S3 BUCKET NAME>"
			}
		end
	end
end