require 'locomotive/coal'
require 'netrc'

module Locomotive::Wagon

  class PushCommand < Struct.new(:env, :path, :options)

    def push
      puts read_from_yaml_file.inspect
      true
    end

    def connection_information
      if information = read_from_yaml_file
        # the site should exist
        information
      else
        # TODO
        # 1. ask for the platform URL (or LOCOMOTIVE_PLATFORM_URL env variable)
        platform_url = shell.ask "Enter the URL of your platform? (default: #{default_platform_url})"

        puts platform_url

        # 2. retrieve email + api_key
        # 3. get an instance of the Steam services => common to the read_from_yaml_file way
        # 4. load the information about the site (SiteRepository)
        # 5. ask for a handle if not found (blank: random one)
        # 6. create the site
        # 7. update the deploy.yml
      end

      # clean the URI (ssl, without scheme?)
      # assign the site to the Steam services and repositories
      # build an instance of the Coal client class
    end



    private

    def shell
      options[:shell]
    end

    def default_platform_url
      ENV['LOCOMOTIVE_PLATFORM_URL'] || DEFAULT_PLATFORM_URL
    end

    def deploy_file
      File.join(path, 'config', 'deploy.yml')
    end

    def read_from_yaml_file
      # pre-processing: erb code to parse and render?
      parsed_deploy_file = ERB.new(File.open(deploy_file).read).result

      # finally, get the hash from the YAML file
      environments = YAML::load(parsed_deploy_file)
      (environments.is_a?(Hash) ? environments : {})[env.to_s]
    rescue Exception => e
      raise "Unable to read the config/deploy.yml file (#{e.message})"
    end

    def read_from_netrc

    end

  end

end
