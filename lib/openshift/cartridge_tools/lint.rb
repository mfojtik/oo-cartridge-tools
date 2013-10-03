require 'yaml'
require 'kwalify'

module OpenShift
  module CartridgeTools

    class Lint

      CURRENT_MANIFEST_SCHEMA = "manifest_schema_20130929.yml"

      def self.guess_manifest_path(file=nil)
        base_path = Dir.pwd
        unless file.nil?
          file_path = File.join(base_path, file)
        else
          file_path = File.join(base_path, 'metadata', 'manifest.yml')
        end
        raise "File not found: #{file_path}" unless File.exists?(file_path)
        return file_path
      end

      def self.guess_schema_path(schema=nil)
        base_path = Dir.pwd
        unless schema.nil?
          schema_path = File.join(base_path, schema)
        else
          schema_path = File.join(File.dirname(__FILE__), '..', '..', '..', 'schema', CURRENT_MANIFEST_SCHEMA)
        end
        raise "Schema not found: #{schema_path}" unless File.exists?(schema_path)
        return schema_path
      end

      def self.parse(manifest_file, schema_file=nil)
        manifest = YAML.load_file(manifest_file)
        schema = Kwalify::Yaml.load_file(schema_file)
        validator = Kwalify::Validator.new(schema)
        LintResult.get(validator.validate(manifest))
      end

      class LintResult
        attr_accessor :errors

        def initialize(errors)
          @errors = errors
        end

        def self.get(validator)
          self.new(validator)
        end

        def errors?; !errors.empty?; end
      end

    end

  end
end
