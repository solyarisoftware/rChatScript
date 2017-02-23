# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chatscript/version'

Gem::Specification.new do |spec|
  spec.name          = "chatscript"
  spec.version       = ChatScript::VERSION
  spec.authors       = ["Giorgio Robino"]
  spec.email         = ["giorgio.robino@gmail.com"]

  spec.summary       = %q{simple Ruby ChatScript client, with usage examples.}
  spec.description   = %q{simple ChatScript (https://github.com/bwilcox-1234/ChatScript) client, as Ruby gem, with application usage examples.}
  spec.homepage      = "https://github.com/solyaris/rChatScript"
  spec.license       = "MIT"
  
  spec.files       = ["lib/chatscript.rb", "lib/chatscript/version.rb"]
  #spec.files         = `git ls-files -z`.split("\x0").reject do |f|
  #  f.match(%r{^(test|spec|features)/})
  #end
  
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # because of local variable scope in blocks
  spec.required_ruby_version = '~> 2.0'
       
  # runtime dependencies, from others gem
  # spec.add_runtime_dependency "..."
  
  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
end
