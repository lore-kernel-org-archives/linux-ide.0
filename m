From: =?ISO-8859-15?Q?Erik_Inge_Bols=F8?= <knan-ata@anduin.net>
Subject: pata_via/libata.force fails forcing mwdma/pio modes
Date: Mon, 10 Mar 2008 18:55:20 +0100 (CET)
Message-ID: <alpine.BSF.1.00.0803101814430.84237@anduin.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anduin.net ([213.225.74.230]:53601 "EHLO anduin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751132AbYCJTFa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Mar 2008 15:05:30 -0400
Received: from localhost.anduin.net
	([127.0.0.1] helo=localhost ident=knan)
	by anduin.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <knan-ata@anduin.net>)
	id 1JYmDY-0000DI-CQ
	for linux-ide@vger.kernel.org; Mon, 10 Mar 2008 18:55:20 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

But autonegotiating mwdma/pio modes with appropriate slow drives always 
works fine. Via VT8235 chipset. Kernel 2.6.25-rc4-and-a-bit from 
saturday's git.

Tested on a Western Digital UDMA/100 disk via a nice 80-pin cable and 
had the same behaviour when I swapped in a pata-compactflash adapter.

Forcing UDMA1 with libata.force=1.00:udma1 works fine - speed is fine, 
hdparm -I looks fine.

Forcing MWDMA2 with libata.force=1.00:mwdma2 hangs hard when scanning 
partitions.

Forcing PIO3 with libata.force=1.00:pio3 results in PIO0 speeds and hdparm 
-I reporting that best udma mode is still selected. (ignore the unknown 
partition table - the disk is wiped and unpartitioned)

MWDMA hang log:
[    5.026117] ACPI: PCI Interrupt 0000:00:11.1[A] -> Link [LNKA] -> GSI 15 (level, low) -> IRQ 15
[    5.026412] pata_via 0000:00:11.1: VIA VLink IRQ fixup, from 255 to 15
[    5.026998] scsi0 : pata_via
[    5.027548] scsi1 : pata_via
[    5.038879] ata1: PATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0xe000 irq 14
[    5.038978] ata2: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xe008 irq 15
[    5.194536] ata1.00: ATA-5: WDC WD200EB-00CSF0, 04.01B04, max UDMA/100
[    5.194536] ata1.00: 39102336 sectors, multi 16: LBA 
[    5.194536] ata1.00: FORCE: xfer_mask set to mwdma2
[    5.201625] ata1.00: configured for MWDMA2
[    5.201625] scsi 0:0:0:0: Direct-Access     ATA      WDC WD200EB-00CS 04.0 PQ: 0 ANSI: 5
[    5.202300] sd 0:0:0:0: [sda] 39102336 512-byte hardware sectors (20020 MB)
[    5.202432] sd 0:0:0:0: [sda] Write Protect is off
[    5.202597] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    5.202872] sd 0:0:0:0: [sda] 39102336 512-byte hardware sectors (20020 MB)
[    5.202991] sd 0:0:0:0: [sda] Write Protect is off
[    5.203153] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    5.203254]  sda:

The system is at this point completely wedged, not responding to magic 
sysrq or anything.

PIO forcing log:
[    5.024147] ACPI: PCI Interrupt 0000:00:11.1[A] -> Link [LNKA] -> GSI 15 (level, low) -> IRQ 15
[    5.024485] pata_via 0000:00:11.1: VIA VLink IRQ fixup, from 255 to 15
[    5.025080] scsi0 : pata_via
[    5.025587] scsi1 : pata_via
[    5.036920] ata1: PATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0xe000 irq 14
[    5.037017] ata2: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xe008 irq 15
[    5.193551] ata1.00: ATA-5: WDC WD200EB-00CSF0, 04.01B04, max UDMA/100
[    5.193551] ata1.00: 39102336 sectors, multi 16: LBA 
[    5.193551] ata1.00: FORCE: xfer_mask set to pio3
[    5.200655] ata1.00: configured for PIO3
[    5.200655] scsi 0:0:0:0: Direct-Access     ATA      WDC WD200EB-00CS 04.0 PQ: 0 ANSI: 5
[    5.201347] sd 0:0:0:0: [sda] 39102336 512-byte hardware sectors (20020 MB)
[    5.201493] sd 0:0:0:0: [sda] Write Protect is off
[    5.201690] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    5.202013] sd 0:0:0:0: [sda] 39102336 512-byte hardware sectors (20020 MB)
[    5.202130] sd 0:0:0:0: [sda] Write Protect is off
[    5.202291] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    5.202392]  sda: unknown partition table
[    5.227680] sd 0:0:0:0: [sda] Attached SCSI disk
[    5.227680] sd 0:0:0:0: Attached scsi generic sg0 type 0

hdparm -tT /dev/sda

/dev/sda:
 Timing cached reads:    94 MB in  2.03 seconds =  46.31 MB/sec
 Timing buffered disk reads:   10 MB in  3.18 seconds =   3.15 MB/sec


hdparm -I /dev/sda

/dev/sda:

ATA device, with non-removable media
	Model Number:       WDC WD200EB-00CSF0                      
	Serial Number:      XX-XXXXXXXXXXXX
	Firmware Revision:  04.01B04
Standards:
	Supported: 5 4 3 
	Likely used: 6
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:   16514064
	LBA    user addressable sectors:   39102336
	device size with M = 1024*1024:       19092 MBytes
	device size with M = 1000*1000:       20020 MBytes (20 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	bytes avail on r/w long: 40
	Standby timer values: spec'd by Standard, with device specific minimum
	R/W multiple sector transfer: Max = 16	Current = 16
	Recommended acoustic management value: 128, current value: 254
	DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4 
	     Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
	Enabled	Supported:
	   *	SMART feature set
	    	Security Mode feature set
	   *	Power Management feature set
	   *	Write cache
	   *	Look-ahead
	   *	Host Protected Area feature set
	   *	WRITE_BUFFER command
	   *	READ_BUFFER command
	   *	DOWNLOAD_MICROCODE
	    	SET_MAX security extension
	    	Automatic Acoustic Management feature set
Security: 
		supported
	not	enabled
	not	locked
	not	frozen
	not	expired: security count
	not	supported: enhanced erase
HW reset results:
	CBLID- above Vih
	Device num = 0 determined by the jumper
Checksum: correct

--
-erik	http://useofwords.blogspot.com/
