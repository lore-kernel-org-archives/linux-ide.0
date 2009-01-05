From: Karl Auerbach <karl@iwl.com>
Subject: Some IDE issues with 2.6.28 on PC-Engines ALIX2
Date: Sun, 04 Jan 2009 16:37:59 -0800
Message-ID: <49615667.9020408@iwl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from puck.iwl.com ([64.62.206.91]:51644 "EHLO puck.iwl.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751921AbZAEA6v (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 4 Jan 2009 19:58:51 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, karl@cavebear.com

I've found what I believe are some problems with the IDE drivers on the 
2.6.8 kernel on
the PC-Engines ALIX2 platform.

There are two points in particular:

1. The ide_generic driver no longer finds the IDE drive (an EXT3
formatted compact flash on an IDE channel on an AMD CS5536 controller)
unless the kernel is given the ide_generic.probe_mask=0x## command
line parameter.  (I'll get to the values of ## later.)

2. The cs5535 ide driver doesn't seem to be able to recognize the
newer CS5536 controller for IDE.

I will provide more details below.

I'd submit these directly into the bugzilla but as I'm not familar
with the process and conventions I thought I'd begin with this email.

Thanks,
                 --karl--
                 Karl Auerbach (Santa Cruz, CA)
                 karl@cavebear.com

=================================================

Here's the scripts/ver_linux output:

[root@board-1 linux-2.6.28]# sh scripts/ver_linux If some fields are
empty or look unusual you may have an old version.  Compare to the
current minimal requirements in Documentation/Changes.

Linux board-1.cavebear.com 2.6.28-ALIX2 #1 Fri Jan 2 16:58:36 PST 2009 
i586 unknown

Gnu C                  4.2.4
Gnu make               3.81
binutils               2.19
util-linux             fdformat: unrecognized option `--version'
BusyBox v1.13.1 (2009-01-02 17:00:22 PST) multi-call binary

Usage: fdformat [-n] DEVICE

Format floppy disk

Options:
         -n      Don't verify after format

mount                  (rw
(rw,errors=continue,data=ordered
(rw
(rw
(rw,size=1024k,mode=755
(rw
(rw,gid=5,mode=620
(rw
(rw,size=32768k
(ro,noatime,nodiratime,errors=continue,data=ordered
(rw,vers=3,rsize=8192,wsize=8192,namlen=255,hard,nointr,nolock,proto=udp,timeo=7,retrans=3,sec=sys,addr=192.203.17.130
module-init-tools      found
e2fsprogs              1.41.3
Linux C Library        2.6.1
Dynamic linker (ldd)   2.6.1
Procps                 `--version'
Kbd                    78:
Sh-utils               --v
Modules Loaded         ebtable_filter ebtables x_tables bridge stp llc 
geodewdt cs5535_gpio geode_rng

=================================================

I. The ide_generic issue:

[1.] One line summary of the problem:

ide_generic driver under 2.6.28 no longer finds IDE drives on
PC-Engines ALIX2.

[2.] Full description of the problem/report:

The PC-Engines ALIX2 platform uses an AMD Geode LX processor with the
AMD CS5536 companion chip for things like IDE support.  The IDE drive
is a compact flash.

On the 2.6.27.8 kernel the ide_generic driver found the IDE and
compact flash without the need for any kernel command line parameters.

On the 2.6.28 kernel the ide_generic driver no longer finds the IDE
drive unless a ide_generic.probe_mask=0x## command line parameter is
given to the kernel.

I've tried several values for ##, I have not yet found one that
exactly replicates the behaviour of the 2.6.27.8 kernel.

However, values 0x3f, 0x31, and 0x11 all seem to work, although the
last of these (0x11 has the closest behaviour to the 2.6.27.8 kernel.)

Here's the relevant kernel output when using the 0x11 value in the
following kernel command line.  (The 0x31 value gives the same
results.  The 0x3f value finds several more IDE items.)

Kernel command line: console=ttyS0,38400 root=/dev/hda2 
ramdisk_size=16384 initrd=/initrd.gz rw ide_generic.probe_mask=0x11 
BOOT_IMAGE=/linux

Uniform Multi-Platform E-IDE driver
ide_generic: enforcing probing of I/O ports upon user request
hda: TRANSCEND, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x1e0-0x1e7,0x3e6 on irq 8
ide2 at 0x160-0x167,0x366 on irq 12
ide-gd driver 1.18
hda: max request size: 128KiB
hda: 3915072 sectors (2004 MB) w/1KiB Cache, CHS=3884/16/63
  hda: hda1 hda2 hda3
Driver 'sd' needs updating - please use bus_type methods

When the ide_generic.probe_mask=0x11 is not given no ide items are
found under 2.6.28 (although they were found under 2.6.27.8)

[3.] Keywords (i.e., modules, networking, kernel):

ide_generic, ALIX2

[4.] Kernel version (from /proc/version):

2.6.28


[7.7.] Other information that might be relevant to the problem
        (please look in /proc and include all information that you
        think to be relevant):

I can provide kernel .config files if you want.

=================================================

II. The cs5536 controller issue.

[1.] One line summary of the problem:

The cs5535 ide driver doesn't seem to recognize the AMD CS5536
controller.

[2.] Full description of the problem/report

The old AMD Geode used the CS5535 companion chipset for several
purposes including IDE.

The newer AMD Geode LX uses the CS5536 companion chipset.

It is not clear that the cs5535 ide kernel driver is supposed to
handle the newer chipset.  But in any event, it seems that the cs5535
driver, when it is looking for the hardware, is not seeing anything it
recognizes.

There is some ambiguity created becaause at least one "cs5535" driver
works on the The CS5536: cs5535_gpio

This is not a particularly signifcant issue - the ide_generic driver
handles the CS5536 IDE just fine (modulo the command line issue I
reported above.)  But it would be nice if any ambiguity about what the
cs5535 driver supports and what it does not support were clarified.


	Thanks,
		--karl--

