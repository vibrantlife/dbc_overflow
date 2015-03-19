class QuestionsController < ApplicationController
  def index
    @questions = Question.all.sort
    @quote = HTTParty.get("https://api.github.com/zen?access_token=#{ENV['TOKEN']}", :headers => {"User-Agent" => "vibrantlife"})
  end

  def show
    @question = Question.find(params[:id])
    @answers = @question.answers.sort
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
  		# redirect_to root_path
      render :json => @question
  	else
  		render 'new'
  	end
    # respond_to do |format|
    #   format.html
    #   format.json {render :json => @question}
    # end
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

  def method_name

  end

  private
  def question_params
  	params.require(:question).permit(:title, :content)

  end

end

