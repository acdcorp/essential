class Role < ActiveRecord::Base
  extend Enumerize

  include RolePermissions

  has_many :users
  has_one :user_setting

  attr_reader :names

  @names = [
    :dev          , :admin          , :system ,
    :acd_staff    , :acd_manager    ,
    :client_staff , :client_manager ,
    :api
  ]

  self.inheritance_column = 'rails_type'

  enumerize :name, in: @names

  scope :acd,     -> { where(name: [:admin, :dev, :acd_staff, :acd_manager]) }
  scope :client,  -> { where(name: [:client_staff, :client_manager]) }

  #simple function to check if user is in the "group"
  def in_group? group_name
    if %w(acd client vendor).include? group_name.to_s
      if name == 'dev' || name == 'admin'
        true if group_name == :acd
      else
        name.include?(group_name.to_s)
      end
    elsif group_name == :dev
      true if name == 'dev'
    elsif group_name == :admin
      true if name == 'admin'
    else
      raise "Bad Group Name"
    end
  end

  def group
    return "acd"    if name.include?("acd")
    return "client" if name.include?("client")
    name
  end

  def self.names
    @names
  end

  @names.each do |role_name|
    define_singleton_method "new_#{role_name}" do
      Role.where(name: role_name).first
    end
  end
end
