
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "chef/idm/version"

Gem::Specification.new do |spec|
  spec.name          = "chef-idm"
  spec.version       = Chef::Idm::VERSION
  spec.authors       = ["Richard Nixon"]
  spec.email         = ["richard.nixon@btinternet.com"]

  spec.summary       = %q{A GEM that synchronises Chef users and groups with AD}
  spec.description   = %q{A GEM that synchronises Chef users and groups with AD}
  spec.homepage      = "https://github.com/trickyearlobe/gem_chef_idm"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "net-ldap"
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
