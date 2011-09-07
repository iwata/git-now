require 'formula'

class GitNow < Formula
  url  'https://github.com/iwata/git-now.git', :tag => 'v0.0.4'
  version '0.0.4'
  head 'https://github.com/iwata/git-now.git', :branch => 'develop'
  homepage 'https://github.com/iwata/git-now'

  # for longopt
  depends_on 'gnu-getopt'

  def install
    system "make", "prefix=#{prefix}", "install"
    system "brew ln gnu-getopt"
  end

end
