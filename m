From: "Paul Check" <paul@thechecks.ca>
Subject: Re: Intermittent SATA link down SStatus 0
Date: Thu, 21 Jan 2010 12:36:00 -0500
Message-ID: <011e6ac0021a97d1f5871dae0c441073.squirrel@thechecks.ca>
References: <f4d0374cb498479438e76ac749465a7d.squirrel@thechecks.ca>
    <20100121171103.3db5b496@lxorguk.ukuu.org.uk>
    <e2bbfd706edab2ff5f5eb5f43a3ddb2e.squirrel@thechecks.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from d72-38-7-254.commercial1.cgocable.net ([72.38.7.254]:2005 "EHLO
	max" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751673Ab0AURgE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Jan 2010 12:36:04 -0500
In-Reply-To: <e2bbfd706edab2ff5f5eb5f43a3ddb2e.squirrel@thechecks.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paul Check <paul@thechecks.ca>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

My apologies for the repeat post...I should have noted that there are two
"link down messages" but one is correct (in the sense that a device is not
plugged into the external SATA connector), but one shouldn't have occurred
(one of the ST31000528AS's is not getting picked up).  In this case of the
kern.log messages I've included below, the ST31000528AS that is not
getting picked up is on the "ata1.01: SATA link down" line...you can see
the other drive getting picked up on ata1.00 and the other two on ata2.00
and ata2.01.

The "ata4: SATA link down" line is correct in that nothing is plugged in
there.

Again, I have seen three of my ST31000528AS's not get picked up at
different times, and since they are in groups of two per cable, I find it
unlikely that it is either a drive or cable problem, leaving the
controller and/or driver...probably...right?

P

> Here is the kern.log from the last time the link failed.  Any other
> thoughts?  Regards, Paul
>
>
> Jan 21 01:33:50 min kernel: [    1.298419] SCSI subsystem initialized
> Jan 21 01:33:50 min kernel: [    1.307312] libata version 3.00 loaded.
> Jan 21 01:33:50 min kernel: [    1.308742] ata_piix 0000:00:1f.2: version
> 2.13
> Jan 21 01:33:50 min kernel: [    1.308750]   alloc irq_desc for 20 on node
> 0
> Jan 21 01:33:50 min kernel: [    1.308751]   alloc kstat_irqs on node 0
> Jan 21 01:33:50 min kernel: [    1.308755] ata_piix 0000:00:1f.2: PCI INT
> B -> GSI 20 (level, low) -> IRQ 20
> Jan 21 01:33:50 min kernel: [    1.308759] ata_piix 0000:00:1f.2: MAP [ P0
> P2 P1 P3 ]
> Jan 21 01:33:50 min kernel: [    1.308785] ata_piix 0000:00:1f.2: setting
> latency timer to 64
> Jan 21 01:33:50 min kernel: [    1.308816] scsi0 : ata_piix
> Jan 21 01:33:50 min kernel: [    1.308907] scsi1 : ata_piix
> Jan 21 01:33:50 min kernel: [    1.310237] ata1: SATA max UDMA/133 cmd
> 0x8000 ctl 0x7c00 bmdma 0x7480 irq 20
> Jan 21 01:33:50 min kernel: [    1.310241] ata2: SATA max UDMA/133 cmd
> 0x7880 ctl 0x7800 bmdma 0x7488 irq 20
> Jan 21 01:33:50 min kernel: [    1.310268] ata_piix 0000:00:1f.5: PCI INT
> B -> GSI 20 (level, low) -> IRQ 20
> Jan 21 01:33:50 min kernel: [    1.310272] ata_piix 0000:00:1f.5: MAP [ P0
> -- P1 -- ]
> Jan 21 01:33:50 min kernel: [    1.310297] ata_piix 0000:00:1f.5: setting
> latency timer to 64
> Jan 21 01:33:50 min kernel: [    1.310321] scsi2 : ata_piix
> Jan 21 01:33:50 min kernel: [    1.310390] scsi3 : ata_piix
> Jan 21 01:33:50 min kernel: [    1.311419] ata3: SATA max UDMA/133 cmd
> 0x9000 ctl 0x8c00 bmdma 0x8480 irq 20
> Jan 21 01:33:50 min kernel: [    1.311422] ata4: SATA max UDMA/133 cmd
> 0x8880 ctl 0x8800 bmdma 0x8488 irq 20
> Jan 21 01:33:50 min kernel: [    1.342568] firewire_ohci: Added fw-ohci
> device 0000:08:02.0, OHCI version 1.10
> Jan 21 01:33:50 min kernel: [    1.360870] ahci 0000:05:00.0: version 3.0
> Jan 21 01:33:50 min kernel: [    1.640689] ata4: SATA link down (SStatus 0
> SControl 300)
> Jan 21 01:33:50 min kernel: [    1.793866] ata3: SATA link up 1.5 Gbps
> (SStatus 113 SControl 300)
> Jan 21 01:33:50 min kernel: [    1.801807] usb 1-5: new high speed USB
> device using ehci_hcd and address 4
> Jan 21 01:33:50 min kernel: [    1.802253] ata3.00: ATAPI: SONY    BDRW
> BWU-300S, 1.0c, max UDMA/66
> Jan 21 01:33:50 min kernel: [    1.822227] ata3.00: configured for UDMA/66
> Jan 21 01:33:50 min kernel: [    1.837796] firewire_core: created device
> fw0: GUID 001e8c0000b9c49a, S400
> Jan 21 01:33:50 min kernel: [    1.933879] usb 1-5: New USB device found,
> idVendor=0409, idProduct=005a
> Jan 21 01:33:50 min kernel: [    1.933882] usb 1-5: New USB device
> strings: Mfr=0, Product=0, SerialNumber=0
> Jan 21 01:33:50 min kernel: [    1.933945] usb 1-5: configuration #1
> chosen from 1 choice
> Jan 21 01:33:50 min kernel: [    1.934096] hub 1-5:1.0: USB hub found
> Jan 21 01:33:50 min kernel: [    1.934129] hub 1-5:1.0: 4 ports detected
> Jan 21 01:33:50 min kernel: [    2.109345] ata1.00: SATA link up 3.0 Gbps
> (SStatus 123 SControl 300)
> Jan 21 01:33:50 min kernel: [    2.109358] ata1.01: SATA link down
> (SStatus 0 SControl 301)
> Jan 21 01:33:50 min kernel: [    2.117681] ata1.00: ATA-8: ST31000528AS,
> CC37, max UDMA/133
> Jan 21 01:33:50 min kernel: [    2.117685] ata1.00: 1953525168 sectors,
> multi 16: LBA48 NCQ (depth 0/32)
> Jan 21 01:33:50 min kernel: [    2.133663] ata1.00: configured for
> UDMA/133
> Jan 21 01:33:50 min kernel: [    2.133752] scsi 0:0:0:0: Direct-Access
> ATA      ST31000528AS     CC37 PQ: 0 ANSI: 5
> Jan 21 01:33:50 min kernel: [    2.173189] usb 2-1: new full speed USB
> device using uhci_hcd and address 2
> Jan 21 01:33:50 min kernel: [    2.181240] ata2.00: SATA link up 3.0 Gbps
> (SStatus 123 SControl 300)
> Jan 21 01:33:50 min kernel: [    2.181254] ata2.01: SATA link up 3.0 Gbps
> (SStatus 123 SControl 320)
> Jan 21 01:33:50 min kernel: [    2.201542] ata2.00: ATA-8: ST31000528AS,
> CC37, max UDMA/133
> Jan 21 01:33:50 min kernel: [    2.201546] ata2.00: 1953525168 sectors,
> multi 16: LBA48 NCQ (depth 0/32)
> Jan 21 01:33:50 min kernel: [    2.201791] ata2.01: ATA-8: ST31000528AS,
> CC37, max UDMA/133
> Jan 21 01:33:50 min kernel: [    2.201794] ata2.01: 1953525168 sectors,
> multi 16: LBA48 NCQ (depth 0/32)
> Jan 21 01:33:50 min kernel: [    2.217522] ata2.00: configured for
> UDMA/133
> Jan 21 01:33:50 min kernel: [    2.233497] ata2.01: configured for
> UDMA/133
> Jan 21 01:33:50 min kernel: [    2.233579] scsi 1:0:0:0: Direct-Access
> ATA      ST31000528AS     CC37 PQ: 0 ANSI: 5
> Jan 21 01:33:50 min kernel: [    2.233669] scsi 1:0:1:0: Direct-Access
> ATA      ST31000528AS     CC37 PQ: 0 ANSI: 5
> Jan 21 01:33:50 min kernel: [    2.235406] scsi 2:0:0:0: CD-ROM
> SONY     BDRW BWU-300S    1.0c PQ: 0 ANSI: 5
> Jan 21 01:33:50 min kernel: [    2.237031] pata_marvell 0000:05:00.0: PCI
> INT A -> GSI 16 (level, low) -> IRQ 16
> Jan 21 01:33:50 min kernel: [    2.237049] pata_marvell 0000:05:00.0:
> setting latency timer to 64
> Jan 21 01:33:50 min kernel: [    2.237451] scsi4 : pata_marvell
> Jan 21 01:33:50 min kernel: [    2.237530] scsi5 : pata_marvell
> Jan 21 01:33:50 min kernel: [    2.237551] ata5: PATA max UDMA/100 cmd
> 0xcc00 ctl 0xc880 bmdma 0xc400 irq 16
> Jan 21 01:33:50 min kernel: [    2.237553] ata6: PATA max UDMA/133 cmd
> 0xc800 ctl 0xc480 bmdma 0xc408 irq 16
> Jan 21 01:33:50 min kernel: [    2.239264] sd 0:0:0:0: [sda] 1953525168
> 512-byte logical blocks: (1.00 TB/931 GiB)
> Jan 21 01:33:50 min kernel: [    2.239289] sd 0:0:0:0: [sda] Write Protect
> is off
> Jan 21 01:33:50 min kernel: [    2.239290] sd 0:0:0:0: [sda] Mode Sense:
> 00 3a 00 00
> Jan 21 01:33:50 min kernel: [    2.239303] sd 0:0:0:0: [sda] Write cache:
> enabled, read cache: enabled, doesn't support DPO or FUA
> Jan 21 01:33:50 min kernel: [    2.239338] sd 1:0:0:0: [sdb] 1953525168
> 512-byte logical blocks: (1.00 TB/931 GiB)
> Jan 21 01:33:50 min kernel: [    2.239376]  sda:
> Jan 21 01:33:50 min kernel: [    2.239384] sd 1:0:0:0: [sdb] Write Protect
> is off
> Jan 21 01:33:50 min kernel: [    2.239387] sd 1:0:0:0: [sdb] Mode Sense:
> 00 3a 00 00
> Jan 21 01:33:50 min kernel: [    2.239476] sd 1:0:0:0: [sdb] Write cache:
> enabled, read cache: enabled, doesn't support DPO or FUA
> Jan 21 01:33:50 min kernel: [    2.239479] sd 1:0:1:0: [sdc] 1953525168
> 512-byte logical blocks: (1.00 TB/931 GiB)
> Jan 21 01:33:50 min kernel: [    2.239501] sd 1:0:1:0: [sdc] Write Protect
> is off
> Jan 21 01:33:50 min kernel: [    2.239503] sd 1:0:1:0: [sdc] Mode Sense:
> 00 3a 00 00
> Jan 21 01:33:50 min kernel: [    2.239524] sd 1:0:1:0: [sdc] Write cache:
> enabled, read cache: enabled, doesn't support DPO or FUA
> Jan 21 01:33:50 min kernel: [    2.239570]  sdb: sda1 sda2 sda3 sda4 <sr0:
> scsi3-mmc drive: 125x/125x writer dvd-ram cd/rw xa/form2 cdda tray
> Jan 21 01:33:50 min kernel: [    2.245151] Uniform CD-ROM driver Revision:
> 3.20
> Jan 21 01:33:50 min kernel: [    2.245246] sr 2:0:0:0: Attached scsi
> CD-ROM sr0
> Jan 21 01:33:50 min kernel: [    2.250328]  sdb1
> Jan 21 01:33:50 min kernel: [    2.250394]  sdc: sda5
> Jan 21 01:33:50 min kernel: [    2.260257] sd 1:0:0:0: [sdb] Attached SCSI
> disk
> Jan 21 01:33:50 min kernel: [    2.260265]  sdc1
> Jan 21 01:33:50 min kernel: [    2.260448] sd 1:0:1:0: [sdc] Attached SCSI
> disk
> Jan 21 01:33:50 min kernel: [    2.275404]  sda6 >
> Jan 21 01:33:50 min kernel: [    2.275626] sd 0:0:0:0: [sda] Attached SCSI
> disk
> Jan 21 01:33:50 min kernel: [    2.347208] usb 2-1: New USB device found,
> idVendor=051d, idProduct=0003
> Jan 21 01:33:50 min kernel: [    2.347212] usb 2-1: New USB device
> strings: Mfr=1, Product=2, SerialNumber=3
> Jan 21 01:33:50 min kernel: [    2.347215] usb 2-1: Product: Sm
>    FW:COM 01.1 / UPS.02.D
> Jan 21 01:33:50 min kernel: [    2.347218] usb 2-1: Manufacturer: American
> Power Conversion
> Jan 21 01:33:50 min kernel: [    2.347221] usb 2-1: SerialNumber:
> AS0942125041
> Jan 21 01:33:50 min kernel: [    2.347288] usb 2-1: configuration #1
> chosen from 1 choice
> Jan 21 01:33:50 min kernel: [    2.577495] usbcore: registered new
> interface driver hiddev
> Jan 21 01:33:50 min kernel: [    2.578758] sd 0:0:0:0: Attached scsi
> generic sg0 type 0
> Jan 21 01:33:50 min kernel: [    2.578775] sd 1:0:0:0: Attached scsi
> generic sg1 type 0
> Jan 21 01:33:50 min kernel: [    2.578791] sd 1:0:1:0: Attached scsi
> generic sg2 type 0
> Jan 21 01:33:50 min kernel: [    2.578806] sr 2:0:0:0: Attached scsi
> generic sg3 type 5
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


