From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Subject: need help with ata error
Date: Fri, 09 Feb 2007 20:39:26 +1100
Message-ID: <45CC414E.1080609@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from customer-domains.icp-qv1-irony13.iinet.net.au ([203.59.1.163]:33069
	"EHLO customer-domains.icp-qv1-irony13.iinet.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946278AbXBIJtc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Feb 2007 04:49:32 -0500
Received: from [192.168.3.7] (really [192.168.3.7]) by eyal.emu.id.au
	via smail with esmtp
	id <m1HFSE4-0034HoC@eyal.emu.id.au> (Debian Smail3.2.0.115)
	for <linux-ide@vger.kernel.org>; Fri, 9 Feb 2007 20:39:28 +1100 (EST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: list linux-ide <linux-ide@vger.kernel.org>

I recently added a 6th disk to a RAID5. All disks are WD 320GB SATA, of different
Caviar models (SE, RE) and this new one is RE16.

It worked well for about 5 days (completed a 20 hour grow OK). I now see the following
messages logged (see at end). Can someone explain what it means? The raid5 is still
up and it did not react to this. Being a mythtv repository it gets used regularly.

Is this a disk issue? A controller issue (the new disk is now the fourth on a
Promise SATA-II-150-TX4)? A kernel problem (2.6.20 vanilla).

ata6.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata6.00: cmd 25/00:b8:3f:c4:b6/00:00:20:00:00/e0 tag 0 cdb 0x0 data 94208 in
         res 50/00:00:f6:c4:b6/00:00:00:00:00/e0 Emask 0x1 (device error)
ata6.00: configured for UDMA/133
ata6: EH complete
SCSI device sdf: 625142448 512-byte hdwr sectors (320073 MB)
sdf: Write Protect is off
sdf: Mode Sense: 00 3a 00 00
SCSI device sdf: write cache: enabled, read cache: enabled, doesn't support DPO or FUA

The disk was detected at bootup as:

sata_promise 0000:03:01.0: version 1.05
ACPI: PCI Interrupt 0000:03:01.0[A] -> GSI 21 (level, low) -> IRQ 19
ata3: SATA max UDMA/133 cmd 0xF8CB2200 ctl 0xF8CB2238 bmdma 0x0 irq 19
ata4: SATA max UDMA/133 cmd 0xF8CB2280 ctl 0xF8CB22B8 bmdma 0x0 irq 19
ata5: SATA max UDMA/133 cmd 0xF8CB2300 ctl 0xF8CB2338 bmdma 0x0 irq 19
ata6: SATA max UDMA/133 cmd 0xF8CB2380 ctl 0xF8CB23B8 bmdma 0x0 irq 19
.....
scsi5 : sata_promise
.....
ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata6.00: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth 0/1)
ata6.00: ata6: dev 0 multi count 0
ata6.00: configured for UDMA/133
.....
scsi 5:0:0:0: Direct-Access     ATA      WDC WD3200YS-01P 21.0 PQ: 0 ANSI: 5
SCSI device sdf: 625142448 512-byte hdwr sectors (320073 MB)
sdf: Write Protect is off
sdf: Mode Sense: 00 3a 00 00
SCSI device sdf: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
SCSI device sdf: 625142448 512-byte hdwr sectors (320073 MB)
sdf: Write Protect is off
sdf: Mode Sense: 00 3a 00 00
SCSI device sdf: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdf: sdf1
sd 5:0:0:0: Attached scsi disk sdf

TIA

-- 
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
	attach .zip as .dat
