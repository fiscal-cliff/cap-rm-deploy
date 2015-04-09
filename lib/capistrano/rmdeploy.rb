require "capistrano/rmdeploy/version"
require 'active_resource'

#load File.expand_path("../../../capistrano/tasks/tasks.rake", __FILE__)

module Capistrano
    module Rmdeploy
      class << self
        attr_accessor :configuration
      end

      class Configuration
        attr_accessor :site, :user, :password, :key
        attr_accessor :done_status_id, :status_id_to_update

        def initialize
          self.site = 'http://localhost:80'
          self.user = 'user2'
          self.password = 'useruser'
          self.done_status_id = 3
          self.status_id_to_update = [1]
        end
      end

      def self.configuration
        @configuration ||=  Configuration.new
      end

      def self.configure
        yield(configuration) if block_given?
        Capistrano::Rmdeploy::Base.site = @configuration.site
      end

      class Base < ActiveResource::Base

        class << self
          def site=(site)
            @site = URI.parse(site)
          end

          def user
            Capistrano::Rmdeploy.configuration.user
          end

          def password
            Capistrano::Rmdeploy.configuration.password
          end

          def key
            Capistrano::Rmdeploy.configuration.key
          end


          # [:user, :password, :key].each do |method|
          #     self.singleton_class do
          #       define_method(method) do
          #       Capistrano::Rmdeploy.configuration.send(method)
          #       puts "method #{method}"
          #     end
          #   end
          # end
        end

        self.format = ActiveResource::Formats::XmlFormat

        def save
          prefix_options[:key] = key
          super
        end
      end

      class Issue < Base
        def self.list(from)
          tasks = from.scan(/^[\t\ ]+.*((?<!D)(?<!\d)\d{4,5})/i).flatten.uniq
          puts "Found #{tasks.count} tasks, here are those ids: #{tasks.join(', ')}"
          tasks
        end

        def process!
          return if Capistrano::Rmdeploy.configuration.status_id_to_update.include?(self.status.id)
          reassign!
          self.done_ratio = 100
          self.status_id = Deploy.configuration.done_status_id
          puts "Updating #{self.id}..."
          save
        end

        private

        def reassign!
          self.assigned_to_id = author.id
        end
      end
    end

end
