require "archive_to_s3"
require "rails"

module ArchiveToS3
	class Railtie < Rails::Railtie
		railtie_name :archive_to_s3
		rake_tasks do
			load "tasks/archive_to_s3_tasks.rake"
		end
	end
end