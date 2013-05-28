include_recipe("wordpress")

if node['wordpress']['plugins'] then
  node['wordpress']['plugins'].each do |name, plugin_url|
    remote_file "#{Chef::Config[:file_cache_path]}/#{name}.zip" do
      source plugin_url
      mode "0644"
    end

    execute "unzip -u #{Chef::Config[:file_cache_path]}/#{name}.zip -d #{node['wordpress']['dir']}/wp-content/plugins/" do
      user "ubuntu"
    end
  end
end
