class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
    @answers = @question.answers
  end

  def new
  	@new_question = Question.new
  end

  def edit
  	@question = Question.find(params[:id])
  end

  def create
  	@question = Question.new(question_params)
  	if @question.save
  		redirect_to @question
  	else
  		render 'new'
  	end
  end

  def update 
  	@question = Question.find(params[:id])
  	if @question.update(question_params)
  		redirect_to @question
  	else 
  		render 'edit'
  	end
  end

  def destroy
  	@question = Question.find(params[:id])
  	@question.destroy
  	redirect_to questions_path
  end

  def upvote
  	@question = Question.find(params[:id])
  	@question.increment!(:vote_count)
  	redirect_to questions_path
  end

  def downvote
  	@question = Question.find(params[:id])
  	@question.decrement!(:vote_count)
  	redirect_to questions_path
  end

  private 
  def question_params
  	params.require(:question).permit(:title, :content)

  end

end

