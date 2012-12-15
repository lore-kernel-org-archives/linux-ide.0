From: bl0 <bl0-052@playker.info>
Subject: sata_sil data corruption, possible workarounds
Date: Sat, 15 Dec 2012 09:02:19 +0100
Message-ID: <kahap3$mur$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:48435 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750783Ab2LOIE4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 15 Dec 2012 03:04:56 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-ide@m.gmane.org>)
	id 1Tjmk3-0000Js-Ky
	for linux-ide@vger.kernel.org; Sat, 15 Dec 2012 09:05:03 +0100
Received: from 91.150.147.9.internetia.net.pl ([91.150.147.9])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sat, 15 Dec 2012 09:05:03 +0100
Received: from bl0-052 by 91.150.147.9.internetia.net.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sat, 15 Dec 2012 09:05:03 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I have a PCI card based on Silicon Image 3114 SATA controller. Like many
people in the past I have experienced silent data corruption.
I am lucky to have a hardware configuration where it is easy to reproduce
this behavior with 100% rate by copying a file from a USB stick plugged
into another PCI card. My motherboard has nvidia chipset.

Going through messages and bug reports about this problem, someone mentioned
that PCI cache line size may be relevant. I did some testing with different
CLS values and found that the problem of data corruption is solved if
either
A). CLS is set to 0, before or after sata_sil kernel driver is loaded
  # setpci -d 1095:3114 CACHE_LINE_SIZE=0
where 1095:3114 is the device id as shown by 'lspci -nn'. The same command
can also be used in grub2 (recent versions) shell or configuration file
before booting linux.
or
B). CLS is set to a sufficiently large value, only after sata_sil is loaded.
  # setpci -d 1095:3114 CACHE_LINE_SIZE=28
(value is hexadecimal, in 4-byte units, here it's 160 bytes)
What is a sufficiently large value depends on the value that is set before
the driver is loaded. If the value before the driver is loaded is 32 or 64
bytes, I have to increase it (after the driver is loaded) to 128 or 160
bytes, respectively.

In sata_sil.c source in sil_init_controller it writes some hardware-specific
value depending on PCI cache line size. By lowering this value I can get it
to work with lower CLS. The lowest value 0 works with CLS 64 bytes. If the
CLS is 32 bytes, I have to increase the CLS.

Data corruption is the biggest problem for me and these workarounds help but
another problem remains, sometimes when accessing multiple PCI devices at
the same time sata becomes inaccessible and times out with log messages
similar to:
[  411.351805] ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
frozen
[  411.351824] ata3.00: cmd c8/00:00:00:af:00/00:00:00:00:00/e0 tag 0 dma
131072 in
[  411.351826]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4
(timeout)
[  411.351830] ata3.00: status: { DRDY }
[  411.351843] ata3: hard resetting link
[  411.671775] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  411.697059] ata3.00: configured for UDMA/100
[  411.697080] ata3: EH complete

Reboot is needed to access sata drives again. If I had the root filesystem
on a sata drive it would probably crash the system.

Another thing that may be related. Comparing lspci output reveals that when
accessing multiple PCI devices at the same time, the flag DiscTmrStat
(Discard Timer Status) gets toggled on for device "00:08.0 PCI bridge:
nVidia Corporation nForce2 External PCI Bridge". I don't know if it's
normal or not.

Finally, the same simple test that I use on Linux does not produce data
corruption on FreeBSD. Either this problem doesn't occur there or it's not
trivial to reproduce.

This bug has been around for so long. I hope someone will find this
information useful.


