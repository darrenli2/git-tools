require 'open3'
module Helper 
	PATHS = {
						sagone_ca: ["host_app/Gemfile.lock", "config.yml"],
					 	sagone_us: ["host_app/Gemfile.lock", "config.yml"],
					 	sagone_basics_us: ["host_app/Gemfile.lock", "sageone_basics_us/Gemfile.lock", "config.yml"],
					 	sagone_basics_ca: ["host_app/Gemfile.lock", "sageone_basics_ca/Gemfile.lock", "config.yml"]					 	
					}
	NA_REPOS =['na_sage_one',  'sageone_ca', 'sageone_us', 'sageone_basics_us', 'sageone_basics_ca']
	MYNA_REPOS =['mysageone_na', 'mysageone_us', 'mysageone_ca']

	def self.check_path(local_path)
		full_path = File.expand_path(local_path)
		raise ArgumentError, "Invalid path" unless  File.directory?(full_path)
		raise ArgumentError, "Invalid path" unless (full_path.end_with?("na_sage_one") || full_path.end_with?("mysageone_na"))
		#get_branch_name(full_path)
		#get_latest_ref(full_path)
	end

	def self.get_branch_name(local_path)
		Open3.popen3('git rev-parse --abbrev-ref HEAD', :chdir => local_path) do |i, o, e, t |
			return o.read.strip
		end
	end

	def self.get_latest_ref(local_path)
		Open3.popen3('git rev-parse HEAD', :chdir => local_path) do |i, o, e, t |
			puts o.read.strip
		end
	end

	def self.update_refs()
	end

	def self.branches(local_path, branch_name)
		local_path = File.expand_path(local_path)
		if local_path.end_with?('na_sage_one')
			NA_REPOS.each do |repo|
				path = File.join(File.dirname(local_path), repo)
				create_branch(path, branch_name)
			end
		end	
		if local_path.end_with?('mysageone_na')
			MYNA_REPOS.each do |repo|
				path = File.join(File.dirname(local_path), repo)
				create_branch(path, branch_name)
			end
		end	
	end

	def self.create_branch(local_path, branch_name)
		raise ArgumentError, "Invalid branch_name, cannot create master branch" if branch_name == "master"
		puts local_path
		local_path = File.expand_path(local_path)
		puts local_path		
		Open3.popen3('git branch -a', :chdir => local_path) do |i, o, e, t|
			o.readlines.each do |line|
				raise ArgumentError, "Invalid branch_name, #{branch_name} already exist." if (line.strip == branch_name) || (line.strip.split('/')[-1] == branch_name)
			end
		end

		# diff = ""
		# Open3.popen3('git status --porcelain', :chdir => local_path) do |i, o, e, t|
		# 	diff = o.read.strip
		# 	puts diff
		# end

		# unless diff.empty?
		# 	current_branch = get_branch_name(local_path)
		# 	Open3.popen3("git stash save '#{current_branch} local' ", :chdir => local_path)
		# 	puts "saved your local work to stash '#{current_branch} local'"
		# end
		# Open3.popen3("git checkout master", :chdir => local_path)
		# Open3.popen3("git pull origin master", :chdir => local_path)
		# Open3.popen3("git checkout -b #{branch_name}", :chdir => local_path)
		# Open3.popen3("git push origin #{branch_name}", :chdir => local_path)
		# puts "New branch #{branch_name} has been created at local and github"
	end
		
end