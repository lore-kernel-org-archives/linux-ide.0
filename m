From: Andy Smith <andy@strugglers.net>
Subject: NCQ-related READ/WRITE frozen ATA errors with Intel C220 and Intel
 s3610 SSDs
Date: Sun, 9 Aug 2015 04:27:56 +0000
Message-ID: <20150809042756.GX4243@bitfolk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bitfolk.com ([85.119.80.223]:48979 "EHLO mail.bitfolk.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751051AbbHIEpq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 9 Aug 2015 00:45:46 -0400
Received: from andy by mail.bitfolk.com with local (Exim 4.72)
	(envelope-from <andy@strugglers.net>)
	id 1ZOIDE-0000eH-V7
	for linux-ide@vger.kernel.org; Sun, 09 Aug 2015 04:27:57 +0000
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I've just put together a system based on a Supermicro X10SDV-F
motherboard, which comes with an Intel C220 SATA controller. I've
got two Intel DC s3610 SSDs plugged into this, and have
intermittently been seeing the following ATA errors:

Jul 23 17:14:41 snaps kernel: [68044.504092] ata2.00: exception Emask 0x0 SAct 0x3000000 SErr 0x0 action 0x6 frozen
Jul 23 17:14:41 snaps kernel: [68044.504215] ata2.00: failed command: WRITE FPDMA QUEUED
Jul 23 17:14:41 snaps kernel: [68044.504291] ata2.00: cmd 61/01:c0:00:a8:75/00:00:66:00:00/40 tag 24 ncq 512 out
Jul 23 17:14:41 snaps kernel: [68044.504291]          res 40/00:01:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
Jul 23 17:14:41 snaps kernel: [68044.504357] ata2.00: status: { DRDY }
Jul 23 17:14:41 snaps kernel: [68044.504376] ata2.00: failed command: WRITE FPDMA QUEUED
Jul 23 17:14:41 snaps kernel: [68044.504402] ata2.00: cmd 61/08:c8:d1:b1:b5/00:00:09:00:00/40 tag 25 ncq 4096 out
Jul 23 17:14:41 snaps kernel: [68044.504402]          res 40/00:01:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
Jul 23 17:14:41 snaps kernel: [68044.504468] ata2.00: status: { DRDY }
Jul 23 17:14:41 snaps kernel: [68044.504488] ata2: hard resetting link
Jul 23 17:14:42 snaps kernel: [68044.824115] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
Jul 23 17:14:42 snaps kernel: [68044.825069] ata2.00: configured for UDMA/133
Jul 23 17:14:42 snaps kernel: [68044.825096] ata2.00: device reported invalid CHS sector 0
Jul 23 17:14:42 snaps kernel: [68044.825123] ata2.00: device reported invalid CHS sector 0
Jul 23 17:14:42 snaps kernel: [68044.825153] ata2: EH complete

This would happen once every couple of days, not seemingly related
to any particular level of IO load.

Initially this was restricted to ata2, and after the SSDs were
swapped around the problem then followed the drive to ata1, so some
time was wasted asking Intel if this was a faulty drive. However
while that was taking place similar errors started to happen with
ata2 again, so in fact both drives are affected and the possibility
of it being a pair of faulty drives now seems unlikely.

This machine spent the first few weeks of its life with different
SSDs in it (Crucial M5s) without problem so that suggests to me that
the cabling etc is all okay too.

I then disabled NCQ. After first booting with kernel command line
libata.force=noncq yet still observing what looked to be NCQ still
enabled in dmesg and /sys/block/sd?/device/queue_depth, I also wrote
1 to /sys/block/sd?/device/queue_depth.

It's now been 5 days and the problem hasn't manifested itself again.

So, should I be reporting this as a bug in the kernel bugzilla and
if so, would that be against the ahci driver?

Distribution is Debian 8.1 so that comes with kernel package
3.16.7-ckt11-1+deb8u2. I also tried kernel 4.0.8-2 from Debian
testing with no improvement. I did not try an upstream kernel yet.

$ sudo lspci -vvx -s 00:1f.2
00:1f.2 SATA controller: Intel Corporation 8 Series/C220 Series Chipset Family 6-port SATA Controller 1 [AHCI mode] (rev 05) (prog-if 01 [AHCI 1.0])
        Subsystem: Super Micro Computer Inc Device 086d
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 164
        Region 0: I/O ports at f070 [size=8]
        Region 1: I/O ports at f060 [size=4]
        Region 2: I/O ports at f050 [size=8]
        Region 3: I/O ports at f040 [size=4]
        Region 4: I/O ports at f020 [size=32]
        Region 5: Memory at fb312000 (32-bit, non-prefetchable) [size=2K]
        Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
                Address: fee002b8  Data: 0000
        Capabilities: [70] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
        Kernel driver in use: ahci
00: 86 80 02 8c 07 04 b0 02 05 01 06 01 00 00 00 00
10: 71 f0 00 00 61 f0 00 00 51 f0 00 00 41 f0 00 00
20: 21 f0 00 00 00 20 31 fb 00 00 00 00 d9 15 6d 08
30: 00 00 00 00 80 00 00 00 00 00 00 00 0b 01 00 00

$ for d in /dev/sd?; do sudo smartctl -i $d; done
smartctl 6.4 2014-10-07 r4002 [x86_64-linux-3.16.0-4-amd64] (local build)
Copyright (C) 2002-14, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF INFORMATION SECTION ===
Device Model:     INTEL SSDSC2BX016T4
Serial Number:    BTHC511604V41P6PGN
LU WWN Device Id: 5 5cd2e4 04b7b1bfa
Firmware Version: G2010110
User Capacity:    1,600,321,314,816 bytes [1.60 TB]
Sector Sizes:     512 bytes logical, 4096 bytes physical
Rotation Rate:    Solid State Device
Form Factor:      2.5 inches
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   ACS-2 T13/2015-D revision 3
SATA Version is:  SATA 2.6, 6.0 Gb/s (current: 6.0 Gb/s)
Local Time is:    Sun Aug  9 04:24:26 2015 UTC
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

smartctl 6.4 2014-10-07 r4002 [x86_64-linux-3.16.0-4-amd64] (local build)
Copyright (C) 2002-14, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF INFORMATION SECTION ===
Device Model:     INTEL SSDSC2BX016T4
Serial Number:    BTHC511604SD1P6PGN
LU WWN Device Id: 5 5cd2e4 04b7b1ba2
Firmware Version: G2010110
User Capacity:    1,600,321,314,816 bytes [1.60 TB]
Sector Sizes:     512 bytes logical, 4096 bytes physical
Rotation Rate:    Solid State Device
Form Factor:      2.5 inches
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   ACS-2 T13/2015-D revision 3
SATA Version is:  SATA 2.6, 6.0 Gb/s (current: 6.0 Gb/s)
Local Time is:    Sun Aug  9 04:24:26 2015 UTC
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

Cheers,
Andy
