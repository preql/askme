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

    @questions = [
      Question.new(text: 'Как дела?', created_at: Date.parse('27.03.2016')),
      Question.new(
        text: 'В чем смысл жизни?', created_at: Date.parse('27.03.2016')
      ),
      Question.new(
        text: 'Кто по жизни?', created_at: Date.parse('27.03.2016')
      ),
      Question.new(
        text: 'За Митю Гладкого слыхал?', created_at: Date.parse('27.03.2016')
      )
    ]

    @new_question = Question.new
  end
end
