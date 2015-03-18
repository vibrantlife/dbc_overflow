class AnswersController < ApplicationController
	def new
		@answer = Answer.new
	end

	def create
		@question = Question.find(params[:id])
		@answer = @question.answers.new(answer_params)
		if @answer.save
			redirect_to question_path(@question)
		else
			render 'new'
		end
	end

	# def update
	# 	@question = Question.find(params[:id])
	# 	@answer = @question.answers.update_attributes(answers_params)
		
	# end

	def upvote
		@queston = Question.find(params[:id])
		@answer = @question.answers.find(params[:id])
		@answer.increment!(:vote_count)
		redirect_to question_path(@question)
		
	end

	private
	def answer_params
		params.require(:answer).permit(:title, :content)
	end
end
