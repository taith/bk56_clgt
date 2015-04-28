class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    #@answers = Answer.all
    @question = Question.find params[:question_id]
    @answers = @question.answers
    respond_with ( @answers)
  end

  def show
    @question = Question.find params[:question_id]
    respond_with(@answer)
  end

  def new
    if current_user==nil then redirect_to '/users/sign_in'; return end
    @question = Question.find params[:question_id]
      @answer = Answer.new 
    respond_with(@answer) 
  end

  def edit
    @question = Question.find params[:question_id]
  end

  def create
    @question = Question.find params[:question_id]
    @answer = Answer.new(answer_params.merge!({user: current_user}).merge!( {question: @question}))
    #@answer = @question.answers.build(user: current_user)
    @answer.save
    respond_with(@question, @answer)
  end

  def update
    @question = Question.find params[:question_id]
    @answer.update(answer_params)
    respond_with(@question, @answer)
  end

  def destroy
    if current_user==nil then redirect_to '/users/sign_in';  return end
      if current_user.id!=@answer.user_id then redirect_to '/questions/'; return end
    @answer.destroy
    respond_with(@answer)
  end

  private
    def set_answer
      @answer = Answer.find(params[:id])
    end

    def answer_params
      params.require(:answer).permit(:question_id, :title, :description)
    end
end
