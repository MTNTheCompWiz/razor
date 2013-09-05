#
# Cookbook Name:: razor
# Resource:: image
#
# Author:: Thomas Mealey (<thomas.mealey@mtnsat.com>)
#
# Copyright 2013, MTN Sattelite Communications
#

actions :add

attribute :label,           :kind_of => String, :name_attribute => true
attribute :template,        :kind_of => String
attribute :description,     :kind_of => String
attribute :image_name,      :kind_of => String
attribute :image_vesrion,   :kind_of => String
attribute :hostname_prefix, :kind_of => String
attribute :domainname:      :kind_of => String
attribute :root_password:   :kind_of => String

def initialize(*args)
  super
  @action = :add
end
