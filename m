From: Jim Carter <jimc@math.ucla.edu>
Subject: ata_piix on ICH6M loses ATAPI CD
Date: Sun, 27 Mar 2005 16:50:35 -0800 (PST)
Message-ID: <Pine.LNX.4.61.0503271645350.5513@xena.cft.ca.us>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Received: from harlech.math.ucla.edu ([128.97.4.250]:37508 "EHLO
	harlech.math.ucla.edu") by vger.kernel.org with ESMTP
	id S261638AbVC1Auf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 27 Mar 2005 19:50:35 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org

Distro:		SuSE 9.2
Kernel:		2.6.8 from distro; also 2.6.12-rc1
Hardware:	Dell Inspiron 6000d, Pentium-M, chipset 915PM
		(ICH6M, 82801FBM), PCI ID of SATA controller: 8086:2653
Discs:		FUJITSU MHT2040A; SATA, UDMA/100
		Toshiba-Samsung CDRW/DVD SN-324S 24X; ATAPI, UDMA/33

The initial symptom was that the CD was very slow (4X) and had extreme
errors when burning (error-free on Windows).  This was blamed on no DMA.
In the distro's kernel ide_generic is compiled in.  It bypasses ide0
(SATA disc) but serves ide1 (ATAPI CD), of course without DMA.  I tried
a kernel parameter of "ide1=none", which is effective: ata_piix serves
ata2 and configures its only device for udma/33.  However, the CD itself
is not registered; probing the "scsi bus" uncovers nothing on that bus.
/sys/block has subdirs for loop devices, ramdiscs, and sda (SATA disc);
nothing else.

No relief was obtained through numerous combinations of modules in the
kernel, in the initrd or loaded later, in a variety of orders.  For
example, the following list of modules (in order) in the initrd had the
same result as described above: scsi_mod sd_mod cdrom sr_mod libata
ata_piix ide_cd jbd ext3. This was with "ide1=none".  Combinations were
also tried with piix (the IDE module, and without "ide1=none") without
making the CD appear.  Am I right that piix can't deal with even the
channel with the PATA device, causing it to serve nothing even if
ata_piix is maneuvered out of the way?

As it stands now, I need to compile ata_piix and friends into the kernel
to make software suspend work, but if I want to install any other
software I'll have to read the installation media on a different
machine.  Any suggestions for making both work at the same time would be
appreciated.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)


Shortened dmesg output from 2.6.12-rc1 with ata_piix and dependencies
compiled into the kernel, but no ide whatsoever.  This sequence is 
shown because there are lots of debug messages.

<7>device class 'scsi_host': registering
<7>bus type 'scsi' registered
<7>device class 'scsi_device': registering
<5>SCSI subsystem initialized
<7>bus scsi: add driver sd
<7>libata version 1.10 loaded.
<7>bus pci: add driver ata_piix
<7>ata_piix version 1.03
<6>ACPI: PCI interrupt 0000:00:1f.2[B] -> GSI 17 (level, low) -> IRQ 193
<7>PCI: Setting latency timer of device 0000:00:1f.2 to 64
<6>ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xBFA0 irq 14
<7>ata1: dev 0 cfg 49:2b00 82:346b 83:5b29 84:4003 85:3469 86:1a09 87:4003 88:20
3f
<6>ata1: dev 0 ATA, max UDMA/100, 78140160 sectors:
<6>ata1: dev 0 configured for UDMA/100
<6>scsi0 : ata_piix
<7>DEV: registering device: ID = 'host0'
<7>PM: Adding info for No Bus:host0
<7>CLASS: registering class device: ID = 'host0'
<7>class_hotplug - name = host0
<7>DEV: registering device: ID = 'target0:0:0'
<7>PM: Adding info for No Bus:target0:0:0
<5>  Vendor: ATA       Model: FUJITSU MHT2040A  Rev: 006C
<5>  Type:   Direct-Access                      ANSI SCSI revision: 05
<7>DEV: registering device: ID = '0:0:0:0'
<7>PM: Adding info for scsi:0:0:0:0
<7>bus scsi: add device 0:0:0:0
<5>SCSI device sda: 78140160 512-byte hdwr sectors (40008 MB)
<5>SCSI device sda: drive cache: write back
<5>SCSI device sda: 78140160 512-byte hdwr sectors (40008 MB)
<5>SCSI device sda: drive cache: write back
<6> sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
<5>Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
<7>bound device '0:0:0:0' to driver 'sd'
<7>CLASS: registering class device: ID = '0:0:0:0'
<7>class_hotplug - name = 0:0:0:0
<7>DEV: registering device: ID = 'target0:0:1'
<7>PM: Adding info for No Bus:target0:0:1
<7>PM: Removing info for No Bus:target0:0:1
	-- similarly up to target0:1:15
<6>ata2: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xBFA8 irq 15
<7>ata2: dev 0 cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:04
07
<6>ata2: dev 0 ATAPI, max UDMA/33
<6>ata2: dev 0 configured for UDMA/33
<6>scsi1 : ata_piix
<7>DEV: registering device: ID = 'host1'
<7>PM: Adding info for No Bus:host1
<7>CLASS: registering class device: ID = 'host1'
<7>class_hotplug - name = host1
<7>DEV: registering device: ID = 'target1:0:0'
<7>PM: Adding info for No Bus:target1:0:0
<7>PM: Removing info for No Bus:target1:0:0
	-- note, probe missed the device.
	-- similarly up to target1:1:15


Analogous dmesg output from 2.6.8 with ata_piix and dependencies 
(scsi_mod sd_mod libata) plus ide_core and piix (ide module) compiled 
into the kernel.  Note that IDE is initialized first but claims no
interfaces.

<6>Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
<6>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
<7>libata version 1.02 loaded.
<7>ata_piix version 1.02
<6>ACPI: PCI interrupt 0000:00:1f.2[B] -> GSI 7 (level, low) -> IRQ 7
<7>PCI: Setting latency timer of device 0000:00:1f.2 to 64
<6>ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xBFA0 irq 14
<7>ata1: dev 0 cfg 49:2b00 82:346b 83:5b29 84:4003 85:3469 86:1a09 87:4003 88:20
3f
<6>ata1: dev 0 ATA, max UDMA/100, 78140160 sectors:
<6>ata1: dev 0 configured for UDMA/100
<6>scsi0 : ata_piix
<5>  Vendor: ATA       Model: FUJITSU MHT2040A  Rev: 006C
<5>  Type:   Direct-Access                      ANSI SCSI revision: 05
<6>ata2: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xBFA8 irq 15
<7>ata2: dev 0 cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:04
07
<6>ata2: dev 0 ATAPI, max UDMA/33
<6>ata2: dev 0 configured for UDMA/33
<6>scsi1 : ata_piix
<5>SCSI device sda: 78140160 512-byte hdwr sectors (40008 MB)
<5>SCSI device sda: drive cache: write back
<6> sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
<5>Attached scsi disk sda at scsi0, channel 0, id 0, lun 0

Subsequently these modules were loaded: cdrom ide_cd sr_mod st sg
(plus NICs, iptables, USB, etc etc).  The CD was not recognized nor
registered.  /sys/block shows loop[0-7] ram[0-15] and sda.  In another
try with ide_cd and cdrom compiled into the kernel, the result was
the same.
