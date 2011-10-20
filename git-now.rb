require 'formula'

class GitNow < Formula
  url  'https://github.com/iwata/git-now.git', :tag => 'v0.1.0.6'
  version '0.1.0.6'
  head 'https://github.com/iwata/git-now.git', :branch => 'develop'
  homepage 'https://github.com/iwata/git-now'

  def options
    [
        ['--gnu-getopt', "Link a gnu-getopt formula"],
        ['--zsh-completion', "copy zsh completion function file to $fpath"]
    ]
  end

  # for longopt
  if ARGV.include? '--gnu-getopt'
    depends_on 'gnu-getopt'
  end

  def install
    system "make", "prefix=#{prefix}", "install"
    if ARGV.include? '--gnu-getopt'
      system "brew ln gnu-getopt"
    end
    if ARGV.include?('--zsh-completion') && ENV.include?('FPATH')
      ENV['FPATH'].split(':').find do |path|
        system "cp etc/_git-now #{path}" if File.directory? path
      end
    end
  end

end
