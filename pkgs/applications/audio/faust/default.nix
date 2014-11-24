{ fetchurl, stdenv, unzip, pkgconfig,  gcc }:

stdenv.mkDerivation rec {

  version = "0.9.67";
  name = "faust-${version}";
  src = fetchurl {
    url = "http://downloads.sourceforge.net/project/faudiostream/${name}.zip";
    sha256 = "068vl9536zn0j4pknwfcchzi90rx5pk64wbcbd67z32w0csx8xm1";
  };

  buildInputs = [ unzip pkgconfig gcc ];

  patchPhase=''
    sed -i 's#?= $(shell uname -s)#:= Linux#g'  architecture/osclib/oscpack/Makefile
    sed -e "s@\$FAUST_INSTALL /usr/local /usr /opt /opt/local@$out@g" -i tools/faust2appls/faustpath
    '';

  
  makeFlags="PREFIX=$(out)";

  meta = with stdenv.lib; {
    description = "A functional programming language for realtime audio signal processing";
    longDescription = ''
      FAUST (Functional Audio Stream) is a functional programming
      language specifically designed for real-time signal processing
      and synthesis. FAUST targets high-performance signal processing
      applications and audio plug-ins for a variety of platforms and
      standards.
      The Faust compiler translates DSP specifications into very
      efficient C++ code. Thanks to the notion of architecture,
      FAUST programs can be easily deployed on a large variety of
      audio platforms and plugin formats (jack, alsa, ladspa, maxmsp,
      puredata, csound, supercollider, pure, vst, coreaudio) without
      any change to the FAUST code.
    '';
    homepage = http://faust.grame.fr/;
    downloadPage = http://sourceforge.net/projects/faudiostream/files/;
    license = licenses.gpl2;
    platforms = platforms.linux;
    maintainers = [ maintainers.magnetophon ];
  };
}

