require 'clockwork'
require 'active_job'

ActiveJob::Base.queue_adapter = :sidekiq

# Load all AJ jobs
require File.join(File.expand_path('.'), 'app', 'jobs', 'application_job')
Dir.glob(File.join(File.expand_path('.'), 'app', 'jobs', '**')).each do |file|
	require file
end

# DSL Docs: https://github.com/Rykian/clockwork
module Clockwork
	handler do |job|
		puts "Running #{job}"
	end

	every(1.day, 'problems.update') { ProblemUpdateJob.perform_later }
	every(1.day, 'accounts.update') { AccountUpdateJob.perform_later }

	every(1.minute, 'judgings.update') { JudgingsUpdateJob.perform_later }

	# Update Sphinx indices
	every(1.hour, 'sphinx.index') { `bundle exec rake ts:index` }

	# Database integrity check, technically not needed
#	every(1.day, 'submissions.update') { SubmissionUpdateJob.perform_later }
	every(1.week, 'solved_problem_sets.check') do
		BuildSolvedProblemSetsJob.perform_later
	end
end
