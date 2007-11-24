From: jozwicki <jozwicki@aster.pl>
Subject: spurious completions during NCQ on rt kernel
Date: Sun, 25 Nov 2007 00:14:34 +0100 (CET)
Message-ID: <1A9B2DB3B3ED841DFF005BAC23AE96A51195946069AEEFCB86C1DAE1638E@webmail.aster.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail0.aster.pl ([212.76.33.39]:26411 "EHLO mail0.aster.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752367AbXKXXlE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 24 Nov 2007 18:41:04 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, mingo@elte.hu

Hello,
On Linux localhost 2.6.24-rc2-rt1 #5 SMP PREEMPT RT Sat Nov 24 13:39:15
CET 2007 i686 AMD Athlon(tm) 64 X2 Dual Core Processor 4400+
AuthenticAMD GNU/Linux
under heavy load I get this kind of error:

[27442.074715] ata3.00: exception Emask 0x2 SAct 0xd SErr 0x0 action
0x2 frozen
[27442.074722] ata3.00: spurious completions during NCQ issue=0x1
SAct=0xd FIS=004040a1:00000002
[27442.074735] ata3.00: cmd 61/01:00:55:69:43/00:00:00:00:00/40 tag 0
cdb 0x0 data 512 out
[27442.074736]          res 40/00:18:03:77:af/00:00:05:00:00/40 Emask
0x2 (HSM violation)
[27442.074741] ata3.00: status: { DRDY }
[27442.074746] ata3.00: cmd 61/08:10:73:d1:e4/00:00:03:00:00/40 tag 2
cdb 0x0 data 4096 out
[27442.074748]          res 40/00:00:55:69:43/00:00:00:00:00/40 Emask
0x2 (HSM violation)
[27442.074752] ata3.00: status: { DRDY }
[27442.074757] ata3.00: cmd 61/08:18:03:77:af/00:00:05:00:00/40 tag 3
cdb 0x0 data 4096 out
[27442.074758]          res 40/00:00:55:69:43/00:00:00:00:00/40 Emask
0x2 (HSM violation)
[27442.074762] ata3.00: status: { DRDY }
[27442.377525] ata3: soft resetting link
[27442.530488] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[27442.845995] ata3.00: configured for UDMA/133
[27442.846019] ata3: EH complete
[27442.849003] sd 2:0:0:0: [sda] 488395055 512-byte hardware sectors
(250058 MB)
[27442.849054] sd 2:0:0:0: [sda] Write Protect is off
[27442.849057] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
[27442.849097] sd 2:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA


It doesn't happen with vanilla kernel.
Is it problem with RT patch? Error comes from ahci_port_intr.


[   29.975568] scsi0 : pata_atiixp
[   29.975702] scsi1 : pata_atiixp
[   29.974885] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xf900
irq 14
[   29.974888] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xf908
irq 15
[   30.280976] ata1.00: ATAPI: LITE-ON DVDRW SOHW-832S, VS0B, max
UDMA/33
[   30.437898] ata1.00: configured for UDMA/33
[   31.252252] scsi 0:0:0:0: CD-ROM            LITE-ON  DVDRW SOHW-832S
 VS0B PQ: 0 ANSI: 5
[   31.258278] sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda
tray
[   31.258282] Uniform CD-ROM driver Revision: 3.20
[   31.258402] sr 0:0:0:0: Attached scsi CD-ROM sr0
[   31.258516] sr 0:0:0:0: Attached scsi generic sg0 type 5
[   32.964056] ahci 0000:00:12.0: version 3.0
[   32.964083] ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 22 (level,
low) -> IRQ 16
[   32.964105] ahci 0000:00:12.0: controller can't do 64bit DMA,
forcing 32bit
[   32.964107] ahci 0000:00:12.0: controller can't do PMP, turning off
CAP_PMP
[   33.964321] ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4 ports 3
Gbps 0xf impl SATA mode
[   33.964324] ahci 0000:00:12.0: flags: ncq sntf ilck pm led clo pio
slum part
[   33.965715] scsi2 : ahci
[   33.965848] scsi3 : ahci
[   33.965940] scsi4 : ahci
[   33.966027] scsi5 : ahci
[   33.965136] ata3: SATA max UDMA/133 abar m1024@0xfe02f000 port
0xfe02f100 irq 16
[   33.965140] ata4: SATA max UDMA/133 abar m1024@0xfe02f000 port
0xfe02f180 irq 16
[   33.965144] ata5: SATA max UDMA/133 abar m1024@0xfe02f000 port
0xfe02f200 irq 16
[   33.965148] ata6: SATA max UDMA/133 abar m1024@0xfe02f000 port
0xfe02f280 irq 16
[   34.421241] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   34.467810] ata3.00: HPA detected: current 488395055, native
488397168
[   34.467814] ata3.00: ATA-7: ST3250820AS, 3.AAC, max UDMA/133
[   34.467817] ata3.00: 488395055 sectors, multi 16: LBA48 NCQ (depth
31/32)
[   34.526081] ata3.00: configured for UDMA/133
[   34.983061] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   35.023125] ata4.00: HPA detected: current 488395055, native
488397168
[   35.023129] ata4.00: ATA-7: ST3250820AS, 3.AAE, max UDMA/133
[   35.023131] ata4.00: 488395055 sectors, multi 16: LBA48 NCQ (depth
31/32)
[   35.081404] ata4.00: configured for UDMA/133
[   35.384933] ata5: SATA link down (SStatus 0 SControl 300)
[   35.687837] ata6: SATA link down (SStatus 0 SControl 300)
[   35.687928] scsi 2:0:0:0: Direct-Access     ATA      ST3250820AS    
 3.AA PQ: 0 ANSI: 5
[   35.688070] sd 2:0:0:0: [sda] 488395055 512-byte hardware sectors
(250058 MB)
[   35.688083] sd 2:0:0:0: [sda] Write Protect is off
[   35.688086] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   35.688106] sd 2:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[   35.688153] sd 2:0:0:0: [sda] 488395055 512-byte hardware sectors
(250058 MB)
[   35.688164] sd 2:0:0:0: [sda] Write Protect is off
[   35.688166] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   35.688185] sd 2:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[   35.688188]  sda: sda1 sda2 sda3
[   35.707963] sd 2:0:0:0: [sda] Attached SCSI disk
[   35.708057] sd 2:0:0:0: Attached scsi generic sg1 type 0
[   35.708173] scsi 3:0:0:0: Direct-Access     ATA      ST3250820AS    
 3.AA PQ: 0 ANSI: 5
[   35.708296] sd 3:0:0:0: [sdb] 488395055 512-byte hardware sectors
(250058 MB)
[   35.708308] sd 3:0:0:0: [sdb] Write Protect is off
[   35.708311] sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   35.708331] sd 3:0:0:0: [sdb] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[   35.708370] sd 3:0:0:0: [sdb] 488395055 512-byte hardware sectors
(250058 MB)
[   35.708382] sd 3:0:0:0: [sdb] Write Protect is off
[   35.708384] sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   35.708405] sd 3:0:0:0: [sdb] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[   35.708408]  sdb: sdb1 sdb2 sdb3
[   35.730412] sd 3:0:0:0: [sdb] Attached SCSI disk

There are 2 Seagates with md RAID0 configured.

00:12.0 SATA controller: ATI Technologies Inc SB600 Non-Raid-5 SATA
(prog-if 01 [AHCI 1.0])
Subsystem: Giga-byte Technology Unknown device b005
Flags: bus master, 66MHz, medium devsel, latency 128, IRQ 16
I/O ports at ff00 [size=8]
I/O ports at fe00 [size=4]
I/O ports at fd00 [size=8]
I/O ports at fc00 [size=4]
I/O ports at fb00 [size=16]
Memory at fe02f000 (32-bit, non-prefetchable) [size=1K]
Capabilities: [60] Power Management version 2


Regards,
Jakub
