=begin
#<
Wrapper around upstream grafana recipe to provide a custom default configuration
#>
=end

include_recipe 'grafana'

grafana_datasource 'graphite-cluster' do
  source(
    type: 'graphite',
    url: 'http://' + node[:graphite][:host] + ':8081',
    access: 'direct'
  )
end

template "#{node['grafana']['install_dir']}/app/dashboards/default.json" do
  source 'system_stats.json.erb'
  owner 'root'
  group 'root'
  mode '0664'
end
