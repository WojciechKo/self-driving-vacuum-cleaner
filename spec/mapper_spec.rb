require_relative '../model/roomba/mapper'

describe Mapper do

  describe '#moved' do
    context 'single move' do
      context 'with :up' do
        before :each do
          subject.moved(:up)
        end

        describe '#map' do
          it 'is :visited at [[0, 0], [0, 1]' do
            expect(subject.map.field(0, 0)).to eq(:visited)
            expect(subject.map.field(0, 1)).to eq(:visited)
          end
        end
      end

      context 'with :down' do
        before :each do
          subject.moved(:down)
        end

        describe '#map' do
          it 'is :visited at [[0, 0], [0, -1]' do
            expect(subject.map.field(0, 0)).to eq(:visited)
            expect(subject.map.field(0, -1)).to eq(:visited)
          end
        end
      end

      context 'with :left' do
        before :each do
          subject.moved(:left)
        end

        describe '#map' do
          it 'is :visited at [[0, 0], [-1, 0]' do
            expect(subject.map.field(0, 0)).to eq(:visited)
            expect(subject.map.field(-1, 0)).to eq(:visited)
          end
        end
      end

      context 'with :right' do
        before :each do
          subject.moved(:right)
        end

        describe '#map' do
          it 'is :visited at [[0, 0], [1, 0]' do
            expect(subject.map.field(0, 0)).to eq(:visited)
            expect(subject.map.field(1, 0)).to eq(:visited)
          end
        end
      end
    end

    context 'triple moves' do
      context 'with :up :up :down' do
        before :each do
          subject.moved :up
          subject.moved :up
          subject.moved :down
        end

        it 'is :visited at [[0, 0], [0, 1], [0, 2]' do
          expect(subject.map.field(0, 0)).to eq(:visited)
          expect(subject.map.field(0, 1)).to eq(:visited)
          expect(subject.map.field(0, 2)).to eq(:visited)
        end
      end

      context 'with :right :right :up' do
        before :each do
          subject.moved :right
          subject.moved :right
          subject.moved :up
        end

        it 'is :visited at [[-0, 0], [1, 0], [2, 0], [2, 1]' do
          expect(subject.map.field(0, 0)).to eq(:visited)
          expect(subject.map.field(1, 0)).to eq(:visited)
          expect(subject.map.field(2, 0)).to eq(:visited)
          expect(subject.map.field(2, 1)).to eq(:visited)
        end
      end
    end
  end
end
