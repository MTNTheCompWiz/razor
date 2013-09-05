#
# Cookbook Name:: razor
# Provider:: image
#
# Author:: Thomas Mealey (<thomas.mealey@mtnsat.com>)
#
# Copyright 2013, MTN Satellite Communications
#

require 'safety_razor'

action :add do
  if !model_exists?
    model_config = {
      label: new_resource.label,
      image_uuid: razor_client.image.all.select{ |x| razor_client.image.get((x['uuid'])['name'] == new_resource.image_name) && (x['uuid'])['version'] == new_resource.image_version)) },
      template: new_resource.template,
      req_meta_hash: {
        hostname_prefix: new_resource.hostname_prefix
        domainname: new_resource.domainname
        root_password: new_resource.root_password
      }
    }
    razor_client.model.create(model_config)
    new_resource.updated_by_last_action(true)
  else
    Chef::Log.debug("#{new_resource} is already added, so skipping")
  end
end

private

def razor_bin
  ::File.join(node['razor']['install_path'], "bin/razor")
end

def model_exists?
  razor_models = razor_client.model.all.select{ |x| razor_client.model.get(x['uuid'])['label'] == new_resource.label }
  razor_models.count > 0 #no model yet made
end

def razor_client
  if @_razor_client.nil?
    @_razor_client = SafetyRazor::Client.new(uri: 'http://localhost:8026')
  end
  @_razor_client
end
