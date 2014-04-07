require "formula"

class Passwdqc < Formula
  homepage "http://www.openwall.com/passwdqc/"
  url "http://www.openwall.com/passwdqc/passwdqc-1.3.0.tar.gz"
  sha1 "adc85fbfeb32548984ddee11af356719b6747185"

  def install
    system "make"
    system "make", "BINDIR=/bin", "DESTDIR=#{prefix}", "install"
  end

  test do
    system "#{bin}/pwqcheck -h"
    system "#{bin}/pwqgen"
  end
end
