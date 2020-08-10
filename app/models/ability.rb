# encoding: UTF-8
# frozen_string_literal: true

# Full list of roles abilities could be found on docs/roles.md
class Ability
  include CanCan::Ability

  def initialize(member)
    # check if member related to admin roles
    if member.role.in?(Member::ADMIN_ROLES)
      # return nil if there is no permissions for this role
      return nil if Ability.permissions[member.role].nil?

      # Iterate through member permissions
      Ability.permissions[member.role].each do |action, objects|
        # Iterate through a list of member model access

        objects.each do |object|
          # check if model has some attributes for which she can access
          model = object.is_a?(Hash) ? object.keys[0] : object
          # example, can :read, Currency, :attributes => [:visible, :name] (model attributes)
          can action.to_sym, model == 'all' ? model.to_sym : model.constantize, :attributes => object.is_a?(Hash) ? object[model].map(&:to_sym) : :all
        end
      end
    end
  end

  class << self
    def permissions
      @@permissions ||= Ability.load_abilities
      @@permissions['permissions']
    end

    def load_abilities(file='abilities.yml')
      YAML.load_file("#{Rails.root}/config/#{file}")
    end
  end
end
