From: "Kathy Frazier" <kfrazier@mdc-dayton.com>
Subject: ide interrupts
Date: Fri, 5 Dec 2003 11:25:30 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <PMEMILJKPKGMMELCJCIGMEDACGAA.kfrazier@mdc-dayton.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from minx.mdc-dayton.com ([12.161.103.182]:16809 "EHLO
	mdc-dayton.com") by vger.kernel.org with ESMTP id S264303AbTLEQU4
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Dec 2003 11:20:56 -0500
Received: from kfrazier (kfrazier [191.9.200.122])
	by mdc-dayton.com (8.12.10/8.12.9) with SMTP id hB5GKtAu006653
	for <linux-ide@vger.kernel.org>; Fri, 5 Dec 2003 11:20:56 -0500 (EST)
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I am currently debugging a problem with an in-house developed PCI Bus Master
card on a Pentium 4 machine.  I saw something that surprised me that I
thought you might be able to shed some light on.  I noticed that my ide1
device (cdrom) is constantly generating interrupts (as per
/proc/interrupts).  The device is mounted, but there is no CD in the drive,
nor am I directly accessing it.  What is causing these interrupts?  I
thought it might be because  APM was enabled, so I added apm=off on the boot
line an re-booted.  However, it still is generating lots of interrupts.  The
section of boot up messages related to the ide stuff is below.  I also
included info resulting from hdparm -i /dev/hdc.

Thanks in advance for your help.

Kathy Frazier
Senior Software Engineer
Max Daetwyler Corporation-Dayton Division
2133 Lyons Road
Miamisburg, OH 45342
Tel #: 937.439-1582 ext 6158
Fax #: 937.439-1592
Email: kfrazier@daetwyler.com
http://www.daetwyler.com


Dec  1 13:29:42 rti10 kernel: Uniform Multi-Platform E-IDE driver Revision:
7.00beta-2.4
Dec  1 13:29:42 rti10 kernel: ide: Assuming 33MHz system bus speed for PIO
modes; override with idebus=xx
Dec  1 13:29:42 rti10 kernel: ICH4: IDE controller at PCI slot 00:1f.1
Dec  1 13:29:42 rti10 kernel: PCI: Found IRQ 10 for device 00:1f.1
Dec  1 13:29:42 rti10 kernel: PCI: Sharing IRQ 10 with 00:1d.2
Dec  1 13:29:42 rti10 aksparlnx: Warning: kernel-module version mismatch
Dec  1 13:29:42 rti10 kernel: ICH4: chipset revision 2
Dec  1 13:29:42 rti10 aksparlnx: ^I/opt/aksparlnx/drv/2.4.19/aksparlnx.o was
compiled for kernel version 2.4.19
Dec  1 13:29:42 rti10 kernel: ICH4: not 100%% native mode: will probe irqs
later
Dec  1 13:29:42 rti10 aksparlnx: ^Iwhile this kernel is version
2.4.20-8custom
Dec  1 13:29:42 rti10 kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS
settings: hda:DMA, hdb:pio
Dec  1 13:29:42 rti10 aksparlnx: Warning: loading
/opt/aksparlnx/drv/2.4.19/aksparlnx.o will taint the kernel: non-GPL
license - Copyright 1999-2002 Aladdin Knowledge Systems.
Dec  1 13:29:42 rti10 kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS
settings: hdc:DMA, hdd:pio
Dec  1 13:29:42 rti10 aksparlnx:   See
http://www.tux.org/lkml/#export-tainted for information about tainted
modules
Dec  1 13:29:42 rti10 kernel: hda: ST340016A, ATA DISK drive
Dec  1 13:29:42 rti10 aksparlnx: Warning: loading
/opt/aksparlnx/drv/2.4.19/aksparlnx.o will taint the kernel: forced load
Dec  1 13:29:42 rti10 kernel: blk: queue c053ab40, I/O limit 4095Mb (mask
0xffffffff)
Dec  1 13:29:42 rti10 aksparlnx: Module aksparlnx loaded, with warnings
Dec  1 13:29:42 rti10 kernel: hdc: FX54++W, ATAPI CD/DVD-ROM drive
Dec  1 13:29:42 rti10 aksparlnx:
Dec  1 13:29:42 rti10 kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Dec  1 13:29:42 rti10 rc: Starting aksparlnx:  succeeded
Dec  1 13:29:42 rti10 kernel: ide1 at 0x170-0x177,0x376 on irq 15
Dec  1 13:29:42 rti10 kernel: hda: host protected area => 1
Dec  1 13:29:42 rti10 kernel: hda: 78165360 sectors (40021 MB) w/2048KiB
Cache, CHS=4865/255/63, UDMA(100)
Dec  1 13:29:42 rti10 kernel: hdc: ATAPI 54X CD-ROM drive, 128kB Cache,
UDMA(33)
Dec  1 13:29:42 rti10 apmd[1060]: Version 3.0.2 (APM BIOS 1.2, Linux driver
1.16)
Dec  1 13:29:42 rti10 kernel: Uniform CD-ROM driver Revision: 3.12
Dec  1 13:29:42 rti10 apmd: apmd startup succeeded
Dec  1 13:29:42 rti10 kernel: ide-floppy driver 0.99.newide
Dec  1 13:29:42 rti10 kernel: Partition check:
Dec  1 13:29:42 rti10 aksusbd[1071]: loaded, daemon version: 1.5, key API
(USB) version: 3.81, key API (parallel) version: 3.81
Dec  1 13:29:42 rti10 aksusbd: aksusbd startup succeeded
Dec  1 13:29:42 rti10 kernel:  hda: hda1 hda2 hda3
Dec  1 13:29:42 rti10 kernel: ide-floppy driver 0.99.newide
Dec  1 13:29:38 rti10 kudzu:  succeeded
Dec  1 13:29:42 rti10 kernel: ohci1394: $Rev: 693 $ Ben Collins
<bcollins@debian.org>
Dec  1 13:29:38 rti10 kudzu: Updating /etc/fstab succeeded
Dec  1 13:29:42 rti10 kernel: PCI: Found IRQ 10 for device 02:03.0
Dec  1 13:29:38 rti10 sysctl: net.ipv4.ip_forward = 0
Dec  1 13:29:42 rti10 kernel: ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[10]
MMIO=[f2000000-f20007ff]  Max Packet=[2048]
Dec  1 13:29:42 rti10 automount[1124]: starting automounter version 3.1.7,
path = /home, maptype = file, mapname = /etc/auto.home
Dec  1 13:29:42 rti10 autofs: automount startup succeeded
Dec  1 13:29:38 rti10 sysctl: net.ipv4.conf.default.rp_filter = 1
Dec  1 13:29:42 rti10 kernel: ieee1394: SelfID completion called outside of
bus reset!
Dec  1 13:29:38 rti10 sysctl: kernel.core_uses_pid = 1
Dec  1 13:29:43 rti10 kernel: raw1394: /dev/raw1394 device initialized
Dec  1 13:29:38 rti10 network: Setting network parameters:  succeeded
Dec  1 13:29:43 rti10 kernel: usb.c: registered new driver usbdevfs
Dec  1 13:29:38 rti10 network: Bringing up loopback interface:  succeeded


/dev/hdc:

 Model=FX54++W, FwRev=U01L, SerialNo=
 Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=128kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  sdma0 sdma1 sdma2 mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 *udma2
 AdvancedPM=no



Kathy Frazier
Senior Software Engineer
Max Daetwyler Corporation-Dayton Division
2133 Lyons Road
Miamisburg, OH 45342
Tel #: 937.439-1582 ext 6158
Fax #: 937.439-1592
Email: kfrazier@daetwyler.com
http://www.daetwyler.com



