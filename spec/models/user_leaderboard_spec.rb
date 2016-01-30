require 'rails_helper'

describe UserLeaderboard do
  include ActiveSupport::Testing::TimeHelpers

  describe ".calculate" do
    let!(:user) { create :user }

    context 'without entries' do
      it 'is not generating the leaderboard' do
        expect do
          UserLeaderboard.calculate
        end.to change(UserLeaderboard.where(total_minutes: 0), :count).by(1)
      end
    end

    context 'with entries' do
      let!(:entry) { create :entry, user: user }

      it 'is generating the leaderboard' do
        expect { UserLeaderboard.calculate }.to change(
          UserLeaderboard.where(total_minutes: 0),
          :count
        ).by(0)

        expect(UserLeaderboard.where(
          total_minutes: entry.minutes).count).to eq(1)
      end
    end
  end
end