From: =?iso-8859-2?Q?Martin=20Zoubek?= <zoubek@seznam.cz>
Subject: =?iso-8859-2?Q?PROBLEM=3A=20VIA=20chipset=2C=20can=27t=20enable=20DMA?=
Date: Tue, 17 Dec 2002 22:41:27 +0100 (CET)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <9547.28676-18082-1362480541-1040161287@seznam.cz>
Reply-To: =?iso-8859-2?Q?Martin=20Zoubek?= <zoubek@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

1. VIA chipset, can't enable DMA
2. VIA chipset is correctly detected, IRQs, ports, everything OK. But
then it says "hda: DMA: disabled". DMA enabling is set in my kernel
config. But in /proc/ide/hd?/settings there is shown using_dma 1.
Using "echo using_dma:1 > settings" don't help. DMA channels are
surely not enabled, disks are slower, trasfer rate dropped from 11
MB/s to 6.5 MB/s when copying files.
3. ide, dma
4. Linux version 2.5.52bk1 (root@kryten) (gcc version 3.2.1) #1 Tue
Dec 17 16:14:49 CET 2002
5. no Oops
7. BASH=3D/os/bash/bin/bash
BASH_VERSINFO=3D([0]=3D"2" [1]=3D"05a" [2]=3D"0" [3]=3D"1" [4]=3D"relea=
se"
[5]=3D"i686-pc-linux-gnu")
BASH_VERSION=3D'2.05a.0(1)-release'
BOOT_IMAGE=3Dbzimage2
COLUMNS=3D80
DIRSTACK=3D()
EUID=3D0
GROUPS=3D()
HISTFILE=3D//.bash_history
HISTFILESIZE=3D500
HISTSIZE=3D500
HOME=3D/
HOSTNAME=3D'(none)'
HOSTTYPE=3Di686
IFS=3D$' \t\n'
LD_LIBRARY_PATH=3D/os/glibc/lib:/os/gcc/lib:/os/ncurses/lib:/os/perl/li=
b:/os/flex/lib:/os/binutils/lib:/os/bzip2/lib:/os/e2fsprogs/lib:/os/lib=
tool/lib:/os/procps/lib:/os/gettext/lib:/os/shadow/lib
LD_RUN_PATH=3D/os/glibc/lib:/os/gcc/lib:/os/ncurses/lib:/os/perl/lib:/o=
s/flex/lib:/os/binutils/lib:/os/bzip2/lib:/os/e2fsprogs/lib:/os/libtool=
/lib:/os/procps/lib:/os/gettext/lib:/os/shadow/lib
LINES=3D25
MACHTYPE=3Di686-pc-linux-gnu
MAILCHECK=3D60
OLDPWD=3D/
OPTERR=3D1
OPTIND=3D1
OSTYPE=3Dlinux-gnu
PATH=3D/os/glibc/libexec:/os/glibc/sbin:/os/glibc/bin:/os/m4/bin:/os/au=
toconf/bin:/os/bison/bin:/os/mawk/bin:/os/gcc/bin:/os/findutils/libexec=
:/os/findutils/bin:/os/ncurses/bin:/os/less/bin:/os/groff/bin:/os/perl/=
bin:/os/textutils/bin:/os/sed/bin:/os/flex/bin:/os/binutils/bin:/os/fil=
eutils/bin:/os/sh-utils/bin:/os/texinfo/bin:/os/bash/bin:/os/bzip2/bin:=
/os/diffutils/bin:/os/e2fsprogs/sbin:/os/e2fsprogs/bin:/os/grep/bin:/os=
/gzip/bin:/os/make/bin:/os/patch/bin:/os/tar/libexec:/os/tar/bin:/os/by=
acc/bin:/os/man/sbin:/os/man/bin:/os/automake/bin:/os/file/bin:/os/libt=
ool/bin:/os/kbd/bin:/os/modutils/sbin:/os/netkit-base/sbin:/os/netkit-b=
ase/bin:/os/procinfo/bin:/os/procps/sbin:/os/procps/bin:/os/psmisc/bin:=
/os/gettext/bin:/os/net-tools/sbin:/os/net-tools/bin:/os/shadow/sbin:/o=
s/shadow/bin:/os/sysklogd/sbin:/os/sysvinit/sbin:/os/sysvinit/bin:/os/u=
til-linux/sbin:/os/util-linux/bin:/os/devfsd/sbin
PIPESTATUS=3D([0]=3D"0")
PPID=3D1
PS1=3D'\s-\v\$ '
PS2=3D'> '
PS4=3D'+ '
PWD=3D/os/linux/src
SHELL=3D/os/bash/bin/bash
SHELLOPTS=3Dbraceexpand:hashall:histexpand:monitor:history:interactive-=
comments:emacs
SHLVL=3D1
TERM=3Dlinux
UID=3D0
_=3Dls
init=3D/linuxrc=20

7.1. If some fields are empty or look unusual you may have an old
version.
Compare to the current minimal requirements in Documentation/Changes.
=20
Linux (none) 2.5.52bk1 #1 Tue Dec 17 16:14:49 CET 2002 i686 unknown
=20
Gnu C                  3.2.1
Gnu make               3.79.1
binutils               2.11.2
util-linux             2.11n
mount                  2.11n
modutils               2.4.13
e2fsprogs              1.26-WIP
Linux C Library        2.2.5
Linux C Library        2.2.5
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 mounted
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0=20

7.2. processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 4
model name	: AMD Athlon(tm) Processor
stepping	: 2
cpu MHz		: 751.127
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat
pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips	: 1470.46
=20

7.4. 0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
4000-40ff : VIA Technologies, In VT82C686 [Apollo Sup
5000-500f : VIA Technologies, In VT82C686 [Apollo Sup
6000-607f : VIA Technologies, In VT82C686 [Apollo Sup
d000-d00f : VIA Technologies, In VT82C586B PIPC Bus M
  d000-d007 : ide0
  d008-d00f : ide1
dc00-dcff : VIA Technologies, In VT82C686 AC97 Audio=20
e000-e003 : VIA Technologies, In VT82C686 AC97 Audio=20
e400-e403 : VIA Technologies, In VT82C686 AC97 Audio =20

00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-00efffff : System RAM
  00100000-00364fc1 : Kernel code
  00364fc2-003f097f : Kernel data
00f00000-00ffffff : reserved
01000000-07feffff : System RAM
07ff0000-07ff2fff : ACPI Non-volatile Storage
07ff3000-07ffffff : ACPI Tables
d0000000-d7ffffff : PCI Bus #01
  d0000000-d7ffffff : nVidia Corporation NV11 [GeForce2 MX]
d8000000-dbffffff : VIA Technologies, In VT8363/8365 [KT133/K
dc000000-ddffffff : PCI Bus #01
  dc000000-dcffffff : nVidia Corporation NV11 [GeForce2 MX]
de000000-de0001ff : Philips Semiconducto SAA7146
de001000-de001fff : Brooktree Corporatio Bt878 Video Capture
de002000-de002fff : Brooktree Corporatio Bt878 Audio Capture
ffff0000-ffffffff : reserved=20

7.5. PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, In VT8363/8365 [KT133/K (rev 3).
      Prefetchable 32 bit memory at 0xd8000000 [0xdbffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, In VT8363/8365 [KT133/K (rev 0).
      Master Capable.  No bursts.  Min Gnt=3D12.
  Bus  0, device   7, function  0:
    ISA bridge: VIA Technologies, In VT82C686 [Apollo Sup (rev 34).
  Bus  0, device   7, function  1:
    IDE interface: VIA Technologies, In VT82C586B PIPC Bus M (rev
16).
      Master Capable.  Latency=3D32. =20
      I/O at 0xd000 [0xd00f].
  Bus  0, device   7, function  4:
    Host bridge: VIA Technologies, In VT82C686 [Apollo Sup (rev 48).
      IRQ 11.
  Bus  0, device   7, function  5:
    Multimedia audio controller: VIA Technologies, In VT82C686 AC97
Audio  (rev 32).
      IRQ 12.
      I/O at 0xdc00 [0xdcff].
      I/O at 0xe000 [0xe003].
      I/O at 0xe400 [0xe403].
  Bus  0, device  10, function  0:
    Multimedia controller: Philips Semiconducto SAA7146 (rev 1).
      IRQ 9.
      Master Capable.  Latency=3D32.  Min Gnt=3D15.Max Lat=3D38.
      Non-prefetchable 32 bit memory at 0xde000000 [0xde0001ff].
  Bus  0, device  12, function  0:
    Multimedia video controller: Brooktree Corporatio Bt878 Video
Capture (rev 2).
      IRQ 10.
      Master Capable.  Latency=3D32.  Min Gnt=3D16.Max Lat=3D40.
      Prefetchable 32 bit memory at 0xde001000 [0xde001fff].
  Bus  0, device  12, function  1:
    Multimedia controller: Brooktree Corporatio Bt878 Audio Capture
(rev 2).
      IRQ 10.
      Master Capable.  Latency=3D32.  Min Gnt=3D4.Max Lat=3D255.
      Prefetchable 32 bit memory at 0xde002000 [0xde002fff].
  Bus  1, device   0, function  0:
    VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX]
(rev 161).
      IRQ 11.
      Master Capable.  Latency=3D32.  Min Gnt=3D5.Max Lat=3D1.
      Non-prefetchable 32 bit memory at 0xdc000000 [0xdcffffff].
      Prefetchable 32 bit memory at 0xd0000000 [0xd7ffffff].=20

X. With my 2.5.3 kernel (compiled under the same compiler,
environment, etc.) there is no such problem.

Bye,

Martin Zoubek
zoubek@seznam.cz

______________________________________________________________________
Reklama:
MP3 autor=E1dio SONY CDX-MP30 za 8 990,-!/10 hodin hudby na jednom CD/o=
dn=EDm. =E8eln=ED panel/4x50W/D-bass/CD-R,RW play http://ad2.seznam.cz/=
redir.cgi?instance=3D38953%26url=3Dhttp://www.sony-mobile.cz/
