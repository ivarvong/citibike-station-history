require 'httparty'
require './s3'

task :download do
	contents = HTTParty.get("https://member.citibikenyc.com/data/stations.json").body
	key = "#{Time.now.strftime("%Y%m%d")}/#{Time.now.utc.to_i}/stations.json"	
	puts S3.upload(key: key, contents: contents)

	S3.update_file_list()
end

task :update_list do
	S3.update_file_list()
end
