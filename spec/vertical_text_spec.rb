describe VerticalText do
  subject { VerticalText.new(given_text).to_vertical }

  context 'given "こんにちは\nせかい"' do
    let(:given_text) { "こんにちは\nせかい" }

    it 'gets "せこ\nかん\nいに\n  ち\n  は"' do
      expected = <<EOF.chomp
せこ
かん
いに
　ち
　は
EOF
      # 上のヒアドキュメントは次と同じ
      # "せこ\nかん\nいに\n  ち\n  は\n"
      expect(subject).to eq expected
    end
  end

  context 'given "やあ\nこんにちは\nせかい"' do
    let(:given_text) { "やあ\nこんにちは\nせかい" }

    it 'gets "せこや\nかんあ\nいに　\n  ち　\n  は　"' do
      expected = <<EOF.chomp
せこや
かんあ
いに　
　ち　
　は　
EOF
      expect(subject).to eq expected
    end
  end
end
