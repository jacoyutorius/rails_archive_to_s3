require "archive_to_s3/core"

namespace :s3 do
	desc "create s3_archive.yml"
	task :initialize do
		ArchiveToS3::Core.new.generate_settings
	end

	namespace :dump do
		desc "upload archive files to Amazon S3"
		task :archive do
			ArchiveToS3::Core.new.archive
		end
	end
end
