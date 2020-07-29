# encoding: UTF-8
# frozen_string_literal: true

module API
  module V2
    module Admin
      class Abilities < Grape::API
        namespace :abilities do
          desc 'Get all roles and permissions.'
          get do
            Ability.load_abilities
          end
        end
      end
    end
  end
end
