From: Aalderd Bouwman <aalderd.boac@wanadoo.nl>
Subject: Re: [PATCHSET] ahci updates regarding vt8251 support
Date: Sat, 14 Oct 2006 18:49:46 +0200
Message-ID: <1160844586.3040.6.camel@anja>
References: <11607058883329-git-send-email-htejun@gmail.com>
Reply-To: aalderd.boac@wanadoo.nl
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-1.orange.nl ([193.252.22.241]:4304 "EHLO smtp-1.orange.nl")
	by vger.kernel.org with ESMTP id S1422711AbWJNQsW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Oct 2006 12:48:22 -0400
In-Reply-To: <11607058883329-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Tejun,

The result of my test:

Loading the driver at boot:
ahci 0000:00:0f.0: AHCI 0001.0000 32 slots 4 ports 3 Gbps 0xf impl SATA
mode
ahci 0000:00:0f.0: flags: 64bit ncq pm led clo pmp pio slum part
ata1: SATA max UDMA/133 cmd 0xE0006D00 ctl 0x0 bmdma 0x0 irq 10
ata2: SATA max UDMA/133 cmd 0xE0006D80 ctl 0x0 bmdma 0x0 irq 10
ata3: SATA max UDMA/133 cmd 0xE0006E00 ctl 0x0 bmdma 0x0 irq 10
ata4: SATA max UDMA/133 cmd 0xE0006E80 ctl 0x0 bmdma 0x0 irq 10
scsi0 : ahci
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: ATA-7, max UDMA/133, 156301488 sectors: LBA48 NCQ (depth 0/32)
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/133
scsi1 : ahci
ata2: SATA link down (SStatus 0 SControl 300)
scsi2 : ahci
ata3: SATA link down (SStatus 0 SControl 300)
scsi3 : ahci
ata4: SATA link down (SStatus 0 SControl 300)
scsi 0:0:0:0: Direct-Access     ATA      ST3808110AS      3.AA PQ: 0
ANSI: 5
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
sd 0:0:0:0: Attached scsi disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0

Turning my drive on/mount/umount/off:

ata2: exception Emask 0x10 SAct 0x0 SErr 0x4060000 action 0x2 frozen
ata2: (irq_stat 0x00000040, connection status changed)
ata2: waiting for device to spin up (8 secs)
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: ATA-7, max UDMA/133, 160086528 sectors: LBA
ata2.00: ata2: dev 0 multi count 0
ata2.00: configured for UDMA/133
ata2: EH complete
scsi 1:0:0:0: Direct-Access     ATA      Maxtor 6Y080M0   YAR5 PQ: 0
ANSI: 5
SCSI device sdb: 160086528 512-byte hdwr sectors (81964 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 160086528 512-byte hdwr sectors (81964 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
sdb: sdb1 sdb2
sd 1:0:0:0: Attached scsi disk sdb
sd 1:0:0:0: Attached scsi generic sg1 type 0
ReiserFS: sdb1: found reiserfs format "3.6" with standard journal
ReiserFS: sdb1: using ordered data mode
ReiserFS: sdb1: journal params: device sdb1, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
ReiserFS: sdb1: checking transaction log (sdb1)
ReiserFS: sdb1: Using r5 hash to sort names
ata2: exception Emask 0x10 SAct 0x0 SErr 0x30000 action 0x2 frozen
ata2: (irq_stat 0x04400000, PHY RDY changed)
ata2: hard resetting port
ata2: SATA link down (SStatus 0 SControl 300)
ata2: failed to recover some devices, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link down (SStatus 0 SControl 300)
ata2: failed to recover some devices, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link down (SStatus 0 SControl 300)
ata2.00: disabled
ata2: EH complete
ata2.00: detaching (SCSI 1:0:0:0)
Synchronizing SCSI cache for disk sdb:
FAILED
  status = 0, message = 00, host = 4, driver = 00
  <3>ata2: exception Emask 0x10 SAct 0x0 SErr 0x4060000 action 0x2
frozen
ata2: (irq_stat 0x00000040, connection status changed)
ata2: waiting for device to spin up (8 secs)
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: ATA-7, max UDMA/133, 160086528 sectors: LBA
ata2.00: ata2: dev 0 multi count 0
ata2.00: configured for UDMA/133
ata2: EH complete
scsi 1:0:0:0: Direct-Access     ATA      Maxtor 6Y080M0   YAR5 PQ: 0
ANSI: 5
SCSI device sdb: 160086528 512-byte hdwr sectors (81964 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 160086528 512-byte hdwr sectors (81964 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
sdb: sdb1 sdb2
sd 1:0:0:0: Attached scsi disk sdb
sd 1:0:0:0: Attached scsi generic sg1 type 0
ReiserFS: sdb1: found reiserfs format "3.6" with standard journal
ReiserFS: sdb1: using ordered data mode
ReiserFS: sdb1: journal params: device sdb1, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
ReiserFS: sdb1: checking transaction log (sdb1)
ReiserFS: sdb1: Using r5 hash to sort names
ata2: exception Emask 0x10 SAct 0x0 SErr 0x30000 action 0x2 frozen
ata2: (irq_stat 0x04400000, PHY RDY changed)
ata2: hard resetting port
ata2: SATA link down (SStatus 0 SControl 300)
ata2: failed to recover some devices, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link down (SStatus 0 SControl 300)
ata2: failed to recover some devices, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link down (SStatus 0 SControl 300)
ata2.00: disabled
ata2: EH complete
ata2.00: detaching (SCSI 1:0:0:0)
Synchronizing SCSI cache for disk sdb:
FAILED
  status = 0, message = 00, host = 4, driver = 00

As you see it works!!

Only you found FAILED by synchronizing the SCSI cache for disk sdb.
Is that a problem or did I forget anything?

Tejun: Did you also make NCQ working?

Aalderd.

On Fri, 2006-10-13 at 11:18 +0900, Tejun Heo wrote:
> Hello,
> 
> This patchset updates libata and ahci to improve vt8251 EH and hotplug
> support.
> 
> #01 : separate out sata_port_hardreset(), to be used by vt8251 reset
> #02 : update CLO handling in softreset and kill RESET_NEEDS_CLO
> #03 : update vt8251 support in ahci
> 
> This patchset is against the current #upstream
> (da54f5fe54c7d75e2db7d17961fb36a8c28a8501).
> 
> Aalderd, can you test this patchset?
> 
> Thanks.
> 
> --
> tejun
> 
> 
> 

