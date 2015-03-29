require 'httparty'

task :download do
	contents = HTTParty.get("https://member.citibikenyc.com/data/stations.json").body
	puts contents
end
