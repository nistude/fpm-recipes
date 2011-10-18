class JRuby < FPM::Cookery::Recipe
  description 'Java implementation of the Ruby programming language'

  name     'jruby'
  version  '1.6.4'
  revision 2
  homepage 'http://www.jruby.org/'
  source   "http://jruby.org.s3.amazonaws.com/downloads/#{version}/jruby-bin-#{version}.tar.gz"
  arch     'all'

  section  'interpreters'

  depends  'openjdk-6-jre | java6-runtime'

  def build
    rm Dir['bin/*.{bat,dll,exe}'], :verbose => true
    rm_rf %w{docs samples share tool}, :verbose => true
  end

  def install
    prefix("jruby-#{version}").install Dir['*']

    bin.mkdir
    File.open(bin('jruby'), 'w') do |f|
      with_trueprefix do
        f.write <<-__SHELL
#!/bin/bash
exec #{prefix("jruby-#{version}/bin/jruby")} "$@"
        __SHELL
      end
    end
    chmod 0555, bin('jruby')
  end
end
