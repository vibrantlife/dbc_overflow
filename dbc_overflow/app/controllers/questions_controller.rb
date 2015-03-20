class QuestionsController < ApplicationController
  def index
    @quote = HTTParty.get("https://api.github.com/zen?access_token=#{ENV['TOKEN']}", :headers => {"User-Agent" => "vibrantlife"})
    @questions = Question.all.sort
    respond_to do |format|
      format.html
      format.json {render :json => @questions}
    end
  end

  def show
    @question = Question.find(params[:id])
    @answers = @question.answers.sort
    respond_to do |format|
      format.html
      format.json {render :json => @answers}
    end
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
      render :json => @question
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

