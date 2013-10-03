require 'fileutils'
require 'erb'

module OpenShift
  module CartridgeTools
    class Diy

      TEMPLATE_DIR = File.join(File.dirname(__FILE__), '..', '..', '..', 'schema', 'templates', 'diy')

      def self.init_cartridge_dir(directory_name)
        FileUtils.mkdir_p(directory_name)
        Dir.chdir(directory_name) do
          ['bin', 'configuration/etc/conf.d', 'env', 'hooks', 'metadata', 'usr'].each do |f|
            FileUtils.mkdir_p(f)
          end
        end
      end

      def self.parse_bin(directory_name, options={})
        Dir.chdir(directory_name) do
          control_template = ERB.new(File.read(File.join(TEMPLATE_DIR, 'bin/control.erb')))
          File.open('bin/control', 'w') { |f| f.write(control_template.result(binding)) }
          FileUtils.chmod(0755, 'bin/control')
          setup_template = ERB.new(File.read(File.join(TEMPLATE_DIR, 'bin/setup.erb')))
          File.open('bin/setup', 'w') { |f| f.write(setup_template.result(binding)) }
          FileUtils.chmod(0755, 'bin/setup')
        end
      end

      def self.parse_docs(directory_name, options={})
        Dir.chdir(directory_name) do
          FileUtils.cp(File.join(TEMPLATE_DIR, 'COPYRIGHT'), '.')
          FileUtils.cp(File.join(TEMPLATE_DIR, 'LICENSE'), '.')
          File.open('README.md', 'w') { |f| f.write("#{options[:short_name].capitalize} OpenShift Cartridge") }
        end
      end

      def self.parse_spec(directory_name, options={})
        Dir.chdir(directory_name) do
          spec_template = ERB.new(File.read(File.join(TEMPLATE_DIR, 'openshift-diy-cartridge.spec.erb')))
          File.open("#{directory_name}.spec", 'w') { |f| f.write(spec_template.result(binding)) }
        end
      end

      def self.parse_manifest(directory_name, options={})
        Dir.chdir(directory_name) do
          manifest = YAML::load_file(File.join(TEMPLATE_DIR, 'metadata', 'manifest.yml'))
          manifest.merge!({
            'Name' => options[:short_name],
            'Cartridge-Short-Name' => options[:short_name].upcase,
            'Version' => options[:version],
            'Cartridge-Version' => '0.0.1',
            'Compatible-Versions' => [],
            'Cart-Data' => [],
            'Provides' => [ options[:short_name], "#{options[:short_name]}-#{options[:version]}"]
          })
          File.write('metadata/manifest.yml', YAML::dump(manifest))
          FileUtils.cp(File.join(TEMPLATE_DIR, 'metadata/managed_files.yml'), 'metadata/')
        end
      end

      def self.git_keep(directory_name)
        Dir.chdir(directory_name) do
          FileUtils.touch('env/.gitkeep')
          FileUtils.touch('configuration/etc/conf.d/.gitkeep')
          FileUtils.touch('hooks/.gitkeep')
          FileUtils.touch('usr/.gitkeep')
        end
      end

    end
  end
end
