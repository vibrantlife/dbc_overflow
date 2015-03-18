class AnswersController < ApplicationController
	def new
		@answer = Answer.new
	end

	def create
		@question = Question.find(params[:question_id])
		@answer = @question.answers.new(answer_params)
		if @answer.save
			redirect_to answers_path(@question)
		else
			render 'new'
		end
	end

	private
	def answer_params
		params.require(:answer).permit(:title, :content)
	end
end
