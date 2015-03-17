class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end

  def show
    @questions = Question.find(params[:id])
    @answers = @questions.answers
  end
end

