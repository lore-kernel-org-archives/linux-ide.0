From: Andre Noll <maan@systemlinux.org>
Subject: ST380013AS works on SiI 3112
Date: Thu, 21 Jul 2005 18:53:11 +0200
Message-ID: <20050721165311.GB3200@skl-net.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from systemlinux.org ([83.151.29.59]:12190 "EHLO m18s25.vlinux.de")
	by vger.kernel.org with ESMTP id S261803AbVGUQxk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Jul 2005 12:53:40 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: garzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hi Jeff, list

Some days ago I bought a 80G Seatate ST380013AS Sata Disk and connected
it to my SiI 3112 onboard Controller.

The drive runs only at about 1/3 speed and the driver consumes way
too much CPU. IMHO this is due to the MOD15WRITE quirk which is turned
on for the ST380013AS as it is blacklisted by the driver.

In your mail

	http://archives.free.net.ph/message/20040812.064323.27500c92.html
	
from August 04 you say this is a known issue and you have no plans
to address it in the future as the number of blacklisted drives is
finite.

I also noted that the ST380013AS drive was added quite recently to
the blacklist because Daniel E. Markle reported drive lockups on his
AMD64 system with the SiI 3114 controller.

	http://www.mail-archive.com/linux-ide@vger.kernel.org/msg00091.html                                                  

As both controller and architecture differ between Daniel's system
and mine, I thought there might be the chance that the quirk is
unnecessary for my particular setup.

So I removed ST380013AS from the blacklist and to my surprise,
everything seems to work very well.

I created a partition and a filesystem, mounted it, and did the
following in parallel for about 20 hours now:
	
	run 65 tasks in parallel, each of which writes/unlinks 1G of
	data in an endless loop (stress -d 65)

	run "cat /dev/sda > /dev/null" in an endless loop

	extract a kernel tar.gz, compare the contents with known "good"
	contents, remove the tar.gz, create a tar.gz from the unpacked
	sources, remove the unpacked sources. Also in an endless loop.

If there are other tests which might trigger the problem more likely,
please tell me and I will run them.

OTOH, if you think my tests show that the MOD15 problem does not
occur with the ST380013AS/SiI 3112 combination, the driver should be
changed to reflect this.

In fact, I already looked at sata_sil.c a bit and tried to implement
blacklisting only for some controller/disk combinations, but I did
not succeed because I was unable to find out how to obtain the
pci_device_id associated with the drive from sil_dev_config() :(

Anyway, here's the relevant output of "lspci -vvv" and dmesg (kernel
2.6.12.3)

------------------------------------
00:0f.0 RAID bus controller: Silicon Image, Inc. (formerly CMD
Technology Inc) SiI 3112 [SATALink/SATARaid] Serial ATA Controller (rev 02)
        Subsystem: Silicon Image, Inc. (formerly CMD Technology Inc) SiI 3112 SATARaid Controller
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 11
        I/O ports at c000 [size=8]
        I/O ports at c400 [size=4]
        I/O ports at c800 [size=8]
        I/O ports at cc00 [size=4]
        I/O ports at d000 [size=16]
        Memory at ed001000 (32-bit, non-prefetchable) [size=512]
        Expansion ROM at <unassigned> [disabled] [size=512K]
        Capabilities: [60] Power Management version 2
------------------------------------
libata version 1.11 loaded.
sata_sil version 0.9
ACPI: PCI Interrupt 0000:00:0f.0[A] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
ata1: SATA max UDMA/100 cmd 0xF0802080 ctl 0xF080208A bmdma 0xF0802000 irq 11
ata2: SATA max UDMA/100 cmd 0xF08020C0 ctl 0xF08020CA bmdma 0xF0802008 irq 11
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:207f
ata1: dev 0 ATA, max UDMA/133, 156301488 sectors: lba48
ata1: dev 0 configured for UDMA/100
scsi0 : sata_sil
ata2: no device found (phy stat 00000000)
scsi1 : sata_sil
  Vendor: ATA       Model: ST380013AS        Rev: 3.00
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sda: drive cache: write back
 sda: sda1
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
------------------------------------

One last question: Why does "hdparm -iv /dev/sda" fail with

HDIO_GET_IDENTITY failed: Inappropriate ioctl for device

This is the latest hdparm v6.1.

Have fun
Andre

PS: Please CC me as I'm not on the list.
-- 
Jesus not only saves, he also frequently makes backups
