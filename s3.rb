require 'aws-sdk'
require 'dotenv'
require 'json'
Dotenv.load

class S3
	def self.client
		AWS::S3.new(
			use_ssl:           true,
        	access_key_id:     ENV['S3_ACCESS_KEY'],
        	secret_access_key: ENV['S3_SECRET_KEY']
		).buckets[ ENV['S3_BUCKET'] ]
	end

	def self.upload(key: nil, contents: nil)
		if key.nil? or contents.nil?
			raise "Need a key and contents"
		end

		client = self.client()

		obj = client.objects[key]
		
		cache_length = 60 # seconds
		obj.write(
			contents,
			acl: 'public-read',
			cache_control: "public, max_age=#{cache_length.to_i}",
			content_type: 'application/json',
			expires: (Time.now + cache_length).httpdate
		)
		return obj.public_url.to_s
	end

	def self.update_file_list
		client = self.client()
		snapshots = client.objects.map(&:key).select do |key|
			key.include?('201') # dont count snapshots.json, check for year fragment in filename. not the best solution.
		end
		puts self.upload(
			key: "snapshots.json",
			contents: JSON.generate(snapshots)
		)
	end
end