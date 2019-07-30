module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.jpg'
    end
  end

  def sklonenie(number, krokodil, krokodila, krokodilov)

    if number == nil || !number.is_a?(Numeric)
      number = 0
    end

    if (number % 100 == 11) || (number % 100 == 12) ||
      (number % 100 == 13)  || (number % 100 == 14)
      return krokodilov
    end

    ostatok = number % 10

    if (ostatok == 1)
      return krokodil
    end

    if (ostatok >= 2 && ostatok <= 4)
      return krokodila
    end

    if (ostatok > 4 || ostatok == 0)
      return krokodilov
    end
  end
end
