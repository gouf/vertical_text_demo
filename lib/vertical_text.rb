class VerticalText
  def initialize(given_text)
    @given_text = given_text
  end

  def to_vertical
    character_array = divide_to_chars(@given_text)

    dummy_line = dummy_line(character_array)
    target_lines = character_array

    # NOTE: Array#zip は最長配列を渡すと、引数に渡された より短い配列に nil を挿入する
    dummy_line.zip(*target_lines)
              .yield_self(&method(:replace_nil_to_white_space))
              .then(&method(:remove_place_holder))
              .then(&method(:reverse_char_set))
              .then(&method(:character_array_to_string))
  end

  private

  # 配列操作で縦表記対応するために、文字列を1文字ずつ含む配列に分解する
  def divide_to_chars(given_text)
    given_text.lines
              .map(&:chomp)
              .map(&:chars)
  end

  # Array#zip で生成された nil を全角空白に置き換える
  def replace_nil_to_white_space(array)
    array.map { |inner| inner.map { |char| char.nil? ? '　' : char } }
  end

  # 縦表記のために Array#zip で使用するプレースホルダを生成するために最長文字数を算出する
  def maximum_word_length(character_array)
    character_array.map(&:size).max
  end

  # Array#zip で縦表記にしたあとはまだ左から右表記なので、逆転させる
  def reverse_char_set(character_array)
    character_array.map { |inner| inner.reverse }
  end

  # 配列操作で縦表記対応した文字列群を String に変換する
  def character_array_to_string(character_array)
    character_array.map { |inner| inner.join }.join("\n")
  end

  # Array#zip を使うためのベースの配列を生成する
  def dummy_line(character_array)
    Array.new(maximum_word_length(character_array), :delete_me)
  end

  # 生成したプレースホルダは返却値として利用しないので取り除く
  def remove_place_holder(character_array)
    character_array.map { |inner| inner.reject { |x| x.eql?(:delete_me) } }
  end
end
