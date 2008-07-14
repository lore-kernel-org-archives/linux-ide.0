From: "Janos Haar" <djani22@netcenter.hu>
Subject: possible data corruption on ICH8 or WD raptor
Date: Mon, 14 Jul 2008 23:48:44 +0200
Message-ID: <0b8b01c8e5fb$65ed9480$0400a8c0@dcccs>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-2";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.netcenter.hu ([195.228.254.57]:35839 "EHLO netcenter.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756220AbYGNWah (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 14 Jul 2008 18:30:37 -0400
Received: from dcccs (92-249-178-166.pool.digikabel.hu [92.249.178.166])
	by netcenter.hu (8.13.4/8.13.4) with SMTP id m6ELiITk019834
	for <linux-ide@vger.kernel.org>; Mon, 14 Jul 2008 23:44:18 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello list,

I have one (planned) production ready server with DP35DP Intel motherboard, 
and 6 drive.

2x 500GB WD SATA (not interesting)
4x 300GB WD Velociraptor, SATA2

When i have tested the server i see one error report on the dmesg:

ata3.00: exception Emask 0x10 SAct 0x0 SErr 0x4010000 action 0xa frozen
ata3.00: irq_stat 0x00400040, connection status changed
ata3: SError: { PHYRdyChg DevExch }
ata3.00: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 0
         res 40/00:20:40:de:90/00:00:07:00:00/40 Emask 0x10 (ATA bus error)
ata3.00: status: { DRDY }
ata3: hard resetting link
ata3: softreset failed (device not ready)
ata3: hard resetting link
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.00: configured for UDMA/133
ata3: EH complete
sd 2:0:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
sd 2:0:0:0: [sdc] Write Protect is off
sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support 
DPO or FUA

I have done some test again, and see, this only happens sometimes, and only 
on raptors.

I have tested copy 80GB file from my raid10 array to another raid10 array 
inside the 4 raptor, and i can see data corruption on one time. (using cmp)

I can reproduce this issue, about 1-2 hour testing.

[root@gl-bh2k8 host2]# uname -a
Linux gl-bh2k8 2.6.25.9 #1 SMP Thu Jul 10 17:31:31 CEST 2008 x86_64 x86_64 
x86_64 GNU/Linux

Can i help to fix it if it is fixable by sw?

Thanks,
Janos Haar

dmesg cut:

ahci 0000:00:1f.2: version 3.0
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 21 (level, low) -> IRQ 21
ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 6 ports 3 Gbps 0x3f impl SATA 
mode
ahci 0000:00:1f.2: flags: 64bit ncq sntf led clo pmp pio slum part
PCI: Setting latency timer of device 0000:00:1f.2 to 64
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
scsi3 : ahci
scsi4 : ahci
scsi5 : ahci
ata1: SATA max UDMA/133 abar m2048@0xe2121000 port 0xe2121100 irq 21
ata2: SATA max UDMA/133 abar m2048@0xe2121000 port 0xe2121180 irq 21
ata3: SATA max UDMA/133 abar m2048@0xe2121000 port 0xe2121200 irq 21
ata4: SATA max UDMA/133 abar m2048@0xe2121000 port 0xe2121280 irq 21
ata5: SATA max UDMA/133 abar m2048@0xe2121000 port 0xe2121300 irq 21
ata6: SATA max UDMA/133 abar m2048@0xe2121000 port 0xe2121380 irq 21
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: ATA-8: WDC WD5000AAKS-00A7B0, 01.03B01, max UDMA/133
ata1.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata1.00: configured for UDMA/133
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: ATA-8: WDC WD5000AAKS-00A7B0, 01.03B01, max UDMA/133
ata2.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata2.00: configured for UDMA/133
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.00: ATA-8: WDC WD3000GLFS-01F8U0, 03.03V01, max UDMA/133
ata3.00: 586072368 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata3.00: configured for UDMA/133
ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata4.00: ATA-8: WDC WD3000GLFS-01F8U0, 03.03V01, max UDMA/133
ata4.00: 586072368 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata4.00: configured for UDMA/133
ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata5.00: ATA-8: WDC WD3000GLFS-01F8U0, 03.03V01, max UDMA/133
ata5.00: 586072368 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata5.00: configured for UDMA/133
ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.00: ATA-8: WDC WD3000GLFS-01F8U0, 03.03V01, max UDMA/133
ata6.00: 586072368 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata6.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 01.0 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support 
DPO or FUA
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support 
DPO or FUA
 sda: sda1 sda2 sda3 sda4
sd 0:0:0:0: [sda] Attached SCSI disk
sd 0:0:0:0: Attached scsi generic sg0 type 0
scsi 1:0:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 01.0 PQ: 0 ANSI: 5
sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support 
DPO or FUA
sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support 
DPO or FUA
 sdb: sdb1 sdb2 sdb3 sdb4
sd 1:0:0:0: [sdb] Attached SCSI disk
sd 1:0:0:0: Attached scsi generic sg1 type 0
scsi 2:0:0:0: Direct-Access     ATA      WDC WD3000GLFS-0 03.0 PQ: 0 ANSI: 5
sd 2:0:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
sd 2:0:0:0: [sdc] Write Protect is off
sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support 
DPO or FUA
sd 2:0:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
sd 2:0:0:0: [sdc] Write Protect is off
sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support 
DPO or FUA
 sdc: sdc1 sdc2 sdc3
sd 2:0:0:0: [sdc] Attached SCSI disk
sd 2:0:0:0: Attached scsi generic sg2 type 0
scsi 3:0:0:0: Direct-Access     ATA      WDC WD3000GLFS-0 03.0 PQ: 0 ANSI: 5
sd 3:0:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
sd 3:0:0:0: [sdd] Write Protect is off
sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support 
DPO or FUA
sd 3:0:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
sd 3:0:0:0: [sdd] Write Protect is off
sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support 
DPO or FUA
 sdd: sdd1 sdd2 sdd3
sd 3:0:0:0: [sdd] Attached SCSI disk
sd 3:0:0:0: Attached scsi generic sg3 type 0
scsi 4:0:0:0: Direct-Access     ATA      WDC WD3000GLFS-0 03.0 PQ: 0 ANSI: 5
sd 4:0:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
sd 4:0:0:0: [sde] Write Protect is off
sd 4:0:0:0: [sde] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support 
DPO or FUA
sd 4:0:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
sd 4:0:0:0: [sde] Write Protect is off
sd 4:0:0:0: [sde] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support 
DPO or FUA
 sde: sde1 sde2 sde3
sd 4:0:0:0: [sde] Attached SCSI disk
sd 4:0:0:0: Attached scsi generic sg4 type 0
scsi 5:0:0:0: Direct-Access     ATA      WDC WD3000GLFS-0 03.0 PQ: 0 ANSI: 5
sd 5:0:0:0: [sdf] 586072368 512-byte hardware sectors (300069 MB)
sd 5:0:0:0: [sdf] Write Protect is off
sd 5:0:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 5:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support 
DPO or FUA
sd 5:0:0:0: [sdf] 586072368 512-byte hardware sectors (300069 MB)
sd 5:0:0:0: [sdf] Write Protect is off
sd 5:0:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 5:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support 
DPO or FUA
 sdf: sdf1 sdf2 sdf3
sd 5:0:0:0: [sdf] Attached SCSI disk
sd 5:0:0:0: Attached scsi generic sg5 type 0



