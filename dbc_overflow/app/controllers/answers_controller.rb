class AnswersController < ApplicationController
	def new
		@answer = Answer.new
	end

	def create
		@question = Question.find(params[:question_id])
		@answer = Answer.new(answer_params.merge(question_id: params[:question_id]))
		if @answer.save
			redirect_to question_path(@question)
		else
			redirect_to new_question_answer_path(@question)
		end
	end

	private
	def answer_params
		params.require(:answer).permit(:title, :content)
	end
end
