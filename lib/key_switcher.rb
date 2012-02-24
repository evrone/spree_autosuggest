module KeySwitcher
  extend self

  def switch(str)

    ru = "йцукенгшщзхъфывапролджэячсмитьбюёЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮЁ".split('')
    en = "qwertyuiop[]asdfghjkl;'zxcvbnm,.`QWERTYUIOP{}ASDFGHJKL:\"ZXCVBNM<>~".split('')

    first_letter = str.match(/([^\W\d_])/)[0]
    mapping = first_letter.in?(ru) ? Hash[ru.zip(en)] : Hash[en.zip(ru)]

    str.split('').inject('') { |result, char| result << (mapping[char] || char) }

  end
end

