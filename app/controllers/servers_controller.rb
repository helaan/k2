# Responsible for showing an overview of a server
class ServersController < ApplicationController
	def index
		@servers = Server.all
		redirect_to @servers.first if @servers.length == 1
	end

	def show
		@server = Server.find(params[:id])
		@feed = @server.submissions.includes(:account, :problem).order(submission_id: :desc).references(:accounts, :problems).limit(10)
		@problems = @server.problems.order(short_name: :asc)
		                   .where.not(short_name: nil)
		# TODO: consider not hiding system accounts
		@accounts = @server.accounts.where.not(score: nil).order(
			solvedProblems: :desc, score: :asc
		)
	end

	def auth
		response.headers['X-Auth-Account'] = current_user.username if user_signed_in?
		render plain: 'your privileges have been checked'
	end
end
