class UsersController < ApplicationController
  def index
    @users = [
      User.new(
        id: 1,
        name: 'Eugeny',
        username: 'preql',
        avatar_url: 'http://pikchyriki.net/avatar/krutye/100/74.jpg'
      ),
      User.new(id: 2, name: 'Misha', username: 'aristofun')
    ]
  end

  def new
  end

  def edit
  end

  def show
    @user = User.new(
      name: 'Eugeny',
      username: 'preql',
      avatar_url: 'http://pikchyriki.net/avatar/krutye/100/74.jpg'
    )

    @questions = Question.all
    @questions_count = @questions.count
    @answered_count = @questions.where.not(answer: nil).count
    @unanswered_count = @questions_count - @answered_count

    @new_question = Question.new
  end
end
