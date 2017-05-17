$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "archive_to_s3/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "archive_to_s3"
  s.version     = ArchiveToS3::VERSION
  s.authors     = ["yutoogi"]
  s.email       = ["yuto.ogi@fourier.jp"]
  s.homepage    = ""
  s.summary     = "Summary of ArchiveToS3."
  s.description = "Description of ArchiveToS3."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.0.beta1"
  s.add_dependency "sprockets", "3.6"
  s.add_dependency "hashie"

  s.add_development_dependency "sqlite3"
end
