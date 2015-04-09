require "#{File.dirname(__FILE__)}/helper"

namespace :git do 
	task :update_refs, [:local_path] do |t, args|
		puts args.local_path
		puts "update"
		Helper.check_path(args.local_path)
	end

	task :create_branches, [:local_path, :branch_name] do |t, args|
		puts args.local_path
		puts args.branch_name
		Helper.create_branch(args.local_path, args.branch_name)
	end

	task :branches, [:local_path, :branch_name] do |t, args|
		Helper.branches(args.local_path, args.branch_name)
	end	

	task :test, [:local_path, :branch_name] do |t, args|
		puts args.local_path
		puts args.branch_name
		#Helper.create_branch(args.local_path, args.branch_name)
	end

end
