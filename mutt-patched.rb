require 'formula'

class MuttPatched < Formula
  homepage 'http://www.mutt.org/'
  url 'ftp://ftp.mutt.org/pub/mutt/mutt-1.5.24.tar.gz'
  mirror 'https://bitbucket.org/mutt/mutt/downloads/mutt-1.5.24.tar.gz'
  sha1 '38a2da5eb01ff83a90a2caee28fa2e95dbfe6898'

  head do
    url 'http://dev.mutt.org/hg/mutt#default', :using => :hg

    resource 'html' do
      url 'http://dev.mutt.org/doc/manual.html', :using => :nounzip
    end

    depends_on :autoconf
    depends_on :automake
  end

  unless Tab.for_name('signing-party').used_options.include? 'with-rename-pgpring'
    conflicts_with 'signing-party',
      :because => 'mutt installs a private copy of pgpring'
  end

  conflicts_with 'tin',
    :because => 'both install mmdf.5 and mbox.5 man pages'

  conflicts_with 'mutt',
    :because => 'both install mutt binary'

  # Mutt options
  option "with-debug", "Build with debug option enabled"
  option "with-s-lang", "Build against slang instead of ncurses"

  # Patches
  option "with-sidebar-patch", "Apply sidebar folder patch"
  option "with-trash-patch", "Apply trash folder patch"
  option "with-ignore-thread-patch", "Apply ignore-thread patch"
  option "with-pgp-verbose-mime-patch", "Apply PGP verbose mime patch"
  option "with-pgp-multiple-crypt-hook-patch", "Apply PGP multiple-crypt-hook patch"
  option "with-pgp-combined-crypt-hook-patch", "Apply PGP combined-crypt-hook patch"
  option "with-confirm-attachment-patch", "Apply confirm attachment patch"
  option "with-xlabel-patch", "Apply X-Label header editing patch"
  option "with-date-conditional-patch", "Apply conditional date patch"

  depends_on 'tokyo-cabinet'
  depends_on 'openssl'
  depends_on 's-lang' => :optional

  def patches
    urls = [
      ['with-sidebar-patch', 'https://raw.github.com/nedos/mutt-sidebar-patch/master/mutt-sidebar.patch'],
      #['with-trash-patch', 'http://patch-tracker.debian.org/patch/series/dl/mutt/1.5.21-6.4/features/trash-folder'],
      ['with-trash-patch', 'ftp://ftp.openbsd.org/pub/OpenBSD/distfiles/mutt/trashfolder-1.5.22.diff0.gz'],
      # original source for this went missing, patch sourced from Arch at
      # https://aur.archlinux.org/packages/mutt-ignore-thread/
      ['with-ignore-thread-patch', 'https://gist.github.com/mistydemeo/5522742/raw/1439cc157ab673dc8061784829eea267cd736624/ignore-thread-1.5.21.patch'],
      ['with-pgp-verbose-mime-patch',
          'http://patch-tracker.debian.org/patch/series/dl/mutt/1.5.21-6.2/features-old/patch-1.5.4.vk.pgp_verbose_mime'],
      ['with-pgp-multiple-crypt-hook-patch',
          'http://localhost.lu/mutt/patches/patch-1.5.22.sc.multiple-crypt-hook.1'],
      ['with-pgp-combined-crypt-hook-patch',
          'http://localhost.lu/mutt/patches/patch-1.5.22.sc.crypt-combined.1'],
      ['with-confirm-attachment-patch', 'https://gist.github.com/tlvince/5741641/raw/c926ca307dc97727c2bd88a84dcb0d7ac3bb4bf5/mutt-attach.patch'],
      ['with-xlabel-patch', 'https://raw.githubusercontent.com/johndoe75/homebrew-mutt/master/patches/patch-1.5.23.dgc.xlabel_ext.5'],
      ['with-date-conditional-patch','http://www.familie-steinel.de/upload/patch-date-conditional'],
    ]

    p = []
    urls.each do |u|
      p << u[1] if build.include? u[0]
    end

    return p
  end

  def install
    args = ["--disable-dependency-tracking",
            "--disable-warnings",
            "--prefix=#{prefix}",
            "--with-ssl",
            "--with-sasl",
            "--with-gss",
            "--enable-imap",
            "--enable-smtp",
            "--enable-pop",
            "--enable-hcache",
            "--with-tokyocabinet",
            # This is just a trick to keep 'make install' from trying to chgrp
            # the mutt_dotlock file (which we can't do if we're running as an
            # unpriviledged user)
            "--with-homespool=.mbox"]
    args << "--with-slang" if build.with? 's-lang'

    if build.with? 'debug'
      args << "--enable-debug"
    else
      args << "--disable-debug"
    end

    if build.head?
      system "./prepare", *args
    else
      system "./configure", *args
    end
    system "make"
    system "make", "install"

    (share/'doc/mutt').install resource('html') if build.head?
  end
end
