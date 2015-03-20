class AnswersController < ApplicationController
	def new
		@answer = Answer.new
	end

	def create
		@question = Question.find(params[:id])
		@answer = @question.answers.new(answer_params)
		if @answer.save
			render :json => @answer
		else
			render 'new'
		end
	end

	# def update
	# 	@question = Question.find(params[:id])
	# 	@answer = @question.answers.update_attributes(answers_params)

	# end

	def upvote
		@answer = Answer.find(params[:id])
		@answer.increment!(:vote_count)
		render :json => @answer
	end

	def downvote
		@answer = Answer.find(params[:id])
		@answer.decrement!(:vote_count)
		render :json => @answer

	end

	private
	def answer_params
		params.require(:answer).permit(:title, :content)
	end
end
