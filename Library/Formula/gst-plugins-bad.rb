require 'formula'

class GstPluginsBad < Formula
  homepage 'http://gstreamer.freedesktop.org/'
  url 'http://gstreamer.freedesktop.org/src/gst-plugins-bad/gst-plugins-bad-1.4.5.tar.xz'
  mirror 'http://ftp.osuosl.org/pub/blfs/svn/g/gst-plugins-bad-1.4.5.tar.xz'
  sha256 "152fad7250683d72f9deb36c5685428338365fe4a4c87ffe15e38783b14f983c"

  bottle do
    sha1 "be2942960f2dc10cc86398ecc3e8597b86d676d8" => :yosemite
    sha1 "b082a92824c1ed785d742dcdfaec0fdaac2decf9" => :mavericks
    sha1 "db71b768ec27497e98cc71712fd24be67e16a029" => :mountain_lion
  end

  head do
    url 'git://anongit.freedesktop.org/gstreamer/gst-plugins-bad'

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on 'pkg-config' => :build
  depends_on 'gettext'
  depends_on 'gst-plugins-base'

  depends_on 'dirac' => :optional
  depends_on 'faac' => :optional
  depends_on 'faad2' => :optional
  depends_on 'gnutls' => :optional
  depends_on 'libdvdread' => :optional
  depends_on 'libexif' => :optional
  depends_on 'libmms' => :optional
  depends_on 'rtmpdump' => :optional
  depends_on 'schroedinger' => :optional

  option 'with-applemedia', 'Build with applemedia support'

  def install
    args = %W[
      --prefix=#{prefix}
      --disable-yadif
      --disable-sdl
      --disable-debug
      --disable-dependency-tracking
    ]

    args << "--disable-apple_media" if build.without? "applemedia"

    if build.head?
      ENV["NOCONFIGURE"] = "yes"
      system "./autogen.sh"
    end

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
