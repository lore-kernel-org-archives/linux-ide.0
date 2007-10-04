From: idurdanovic@comcast.net (Igor Durdanovic)
Subject: Re: sata_sil24 and sil-4726
Date: Thu, 4 Oct 2007 03:43:23 -0400
Message-ID: <18180.39323.750969.577889@kitty1.shrimp.net>
References: <18180.26625.216781.626572@kitty1.shrimp.net>
	<470468EE.909@gmail.com>
	<18180.30643.554165.292012@kitty1.shrimp.net>
	<4704790C.7060901@gmail.com>
	<18180.31651.305092.579581@kitty1.shrimp.net>
	<470480C9.9030309@gmail.com>
	<18180.34107.704754.565573@kitty1.shrimp.net>
	<47048C2B.1060202@gmail.com>
	<47049344.6010603@gmail.com>
	<18180.38483.139258.690293@kitty1.shrimp.net>
	<47049799.3030509@gmail.com>
Reply-To: idurdanovic@comcast.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sccrmhc11.comcast.net ([204.127.200.81]:55609 "EHLO
	sccrmhc11.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754254AbXJDHn0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Oct 2007 03:43:26 -0400
In-Reply-To: <47049799.3030509@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: idurdanovic@comcast.net, linux-ide@vger.kernel.org

Tejun Heo writes:
> > Have some weird problems .. the whole thing just froze, sigh.
> > Also, why can't I enable write-caching on each drive behind PM?
> 
> You should be.  What do you mean by not being able to enable
> write-caching?

Had a major crash (had to push the switch off) and now things behave
very different!

Now when I say hdparm -W1 /dev/sdb and then check, the write cache is
finally on!

Also, the booting went without a hitch see log at the end.


> SRST failure puts the host port into non-responding state and the driver
> resets the host port which in turn resets the PMP, so libata tries to
> reinitialize everything.  Can you post boot log with printk timestamp
> (CONFIG_PRINTK_TIME) turned on?

Will do if the hard/soft reset appears again, for the moment
everything behaves differently from before (maybe because the card did
not reset the array when I switched the laptop off?)

Igor


sata_sil24 0000:0d:00.0: version 1.0
ACPI: PCI Interrupt 0000:0d:00.0[A] -> GSI 19 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:0d:00.0 to 64
scsi2 : sata_sil24
scsi3 : sata_sil24
ata3: SATA max UDMA/100 cmd 0xf8d08000 ctl 0x00000000 bmdma 0x00000000 irq 16
ata4: SATA max UDMA/100 cmd 0xf8d0a000 ctl 0x00000000 bmdma 0x00000000 irq 16
ata3: SATA link down (SStatus 0 SControl 0)
ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata4.15: Port Multiplier 1.1, 0x1095:0x4726 r31, 7 ports, feat 0x1/0x9
ata4.00: hard resetting link
ata4.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.01: hard resetting link
ata4.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.02: hard resetting link
ata4.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.03: hard resetting link
ata4.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.04: hard resetting link
ata4.04: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.05: hard resetting link
ata4.05: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata4.06: hard resetting link
ata4.06: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.00: ATA-7: ST3750640AS, 3.AAE, max UDMA/133
ata4.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata4.00: configured for UDMA/100
ata4.01: ATA-7: ST3750640AS, 3.AAD, max UDMA/133
ata4.01: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata4.01: configured for UDMA/100
ata4.02: ATA-7: ST3750640AS, 3.AAE, max UDMA/133
ata4.02: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata4.02: configured for UDMA/100
ata4.03: ATA-7: ST3750640AS, 3.AAD, max UDMA/133
ata4.03: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata4.03: configured for UDMA/100
ata4.04: ATA-7: ST3750640AS, 3.AAE, max UDMA/133
ata4.04: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata4.04: configured for UDMA/100
ata4.05: ATA-6: Config  Disk, PLS12052, max UDMA/133
ata4.05: 640 sectors, multi 1: LBA 
ata4.05: device is on DMA blacklist, disabling DMA
ata4.05: configured for PIO4
ata4: EH complete
scsi 3:0:0:0: Direct-Access     ATA      ST3750640AS      3.AA PQ: 0 ANSI: 5
sd 3:0:0:0: [sdb] 1465149168 512-byte hardware sectors (750156 MB)
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 3:0:0:0: [sdb] 1465149168 512-byte hardware sectors (750156 MB)
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdb: sdb1 sdb2 sdb3 < sdb5 sdb6 sdb7 sdb8 sdb9 sdb10 >
sd 3:0:0:0: [sdb] Attached SCSI disk
sd 3:0:0:0: Attached scsi generic sg2 type 0
scsi 3:1:0:0: Direct-Access     ATA      ST3750640AS      3.AA PQ: 0 ANSI: 5
sd 3:1:0:0: [sdc] 1465149168 512-byte hardware sectors (750156 MB)
sd 3:1:0:0: [sdc] Write Protect is off
sd 3:1:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 3:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 3:1:0:0: [sdc] 1465149168 512-byte hardware sectors (750156 MB)
sd 3:1:0:0: [sdc] Write Protect is off
sd 3:1:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 3:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdc: sdc1 sdc2 sdc3 < sdc5 sdc6 sdc7 sdc8 sdc9 sdc10 >
sd 3:1:0:0: [sdc] Attached SCSI disk
sd 3:1:0:0: Attached scsi generic sg3 type 0
scsi 3:2:0:0: Direct-Access     ATA      ST3750640AS      3.AA PQ: 0 ANSI: 5
sd 3:2:0:0: [sdd] 1465149168 512-byte hardware sectors (750156 MB)
sd 3:2:0:0: [sdd] Write Protect is off
sd 3:2:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 3:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 3:2:0:0: [sdd] 1465149168 512-byte hardware sectors (750156 MB)
sd 3:2:0:0: [sdd] Write Protect is off
sd 3:2:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 3:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdd: sdd1 sdd2 sdd3 < sdd5 sdd6 sdd7 sdd8 sdd9 sdd10 >
sd 3:2:0:0: [sdd] Attached SCSI disk
sd 3:2:0:0: Attached scsi generic sg4 type 0
scsi 3:3:0:0: Direct-Access     ATA      ST3750640AS      3.AA PQ: 0 ANSI: 5
sd 3:3:0:0: [sde] 1465149168 512-byte hardware sectors (750156 MB)
sd 3:3:0:0: [sde] Write Protect is off
sd 3:3:0:0: [sde] Mode Sense: 00 3a 00 00
sd 3:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 3:3:0:0: [sde] 1465149168 512-byte hardware sectors (750156 MB)
sd 3:3:0:0: [sde] Write Protect is off
sd 3:3:0:0: [sde] Mode Sense: 00 3a 00 00
sd 3:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sde: sde1 sde2 sde3 < sde5 sde6 sde7 sde8 sde9 sde10 >
sd 3:3:0:0: [sde] Attached SCSI disk
sd 3:3:0:0: Attached scsi generic sg5 type 0
scsi 3:4:0:0: Direct-Access     ATA      ST3750640AS      3.AA PQ: 0 ANSI: 5
sd 3:4:0:0: [sdf] 1465149168 512-byte hardware sectors (750156 MB)
sd 3:4:0:0: [sdf] Write Protect is off
sd 3:4:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 3:4:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 3:4:0:0: [sdf] 1465149168 512-byte hardware sectors (750156 MB)
sd 3:4:0:0: [sdf] Write Protect is off
sd 3:4:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 3:4:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdf: sdf1 sdf2 sdf3 < sdf5 sdf6 sdf7 sdf8 sdf9 sdf10 >
sd 3:4:0:0: [sdf] Attached SCSI disk
sd 3:4:0:0: Attached scsi generic sg6 type 0
scsi 3:5:0:0: Direct-Access     ATA      Config  Disk     PLS1 PQ: 0 ANSI: 5
sd 3:5:0:0: [sdg] 640 512-byte hardware sectors (0 MB)
sd 3:5:0:0: [sdg] Write Protect is off
sd 3:5:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 3:5:0:0: [sdg] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
sd 3:5:0:0: [sdg] 640 512-byte hardware sectors (0 MB)
sd 3:5:0:0: [sdg] Write Protect is off
sd 3:5:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 3:5:0:0: [sdg] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
 sdg: unknown partition table
sd 3:5:0:0: [sdg] Attached SCSI disk
sd 3:5:0:0: Attached scsi generic sg7 type 0
