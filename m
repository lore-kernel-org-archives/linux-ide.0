From: idurdanovic@comcast.net (Igor Durdanovic)
Subject: Re: sata_sil24 and sil-4726
Date: Thu, 4 Oct 2007 09:36:58 -0400
Message-ID: <18180.60538.163917.140295@kitty1.shrimp.net>
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
	<4704996E.4010601@gmail.com>
Reply-To: idurdanovic@comcast.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sccrmhc12.comcast.net ([204.127.200.82]:51514 "EHLO
	sccrmhc12.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754118AbXJDNhA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Oct 2007 09:37:00 -0400
In-Reply-To: <4704996E.4010601@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: idurdanovic@comcast.net, linux-ide@vger.kernel.org

Tejun Heo writes:
> > SRST failure puts the host port into non-responding state and the driver
> > resets the host port which in turn resets the PMP, so libata tries to
> > reinitialize everything.  Can you post boot log with printk timestamp
> > (CONFIG_PRINTK_TIME) turned on?
> > 
> 
> Also, does the attached patch change the behavior?

There are some problems because system keeps freezing, I have changed
the expresscard, but overall behavior is the same. 

The patch has not changed anything, here is the log with PRINTK_TIME.

Regards, Igor

[    5.507000] sata_sil24 0000:0d:00.0: version 1.0
[    5.507000] ACPI: PCI Interrupt 0000:0d:00.0[A] -> GSI 19 (level, low) -> IRQ 16
[    5.507000] PCI: Setting latency timer of device 0000:0d:00.0 to 64
[    5.507000] scsi2 : sata_sil24
[    5.507000] scsi3 : sata_sil24
[    5.507000] ata3: SATA max UDMA/100 cmd 0xf8d08000 ctl 0x00000000 bmdma 0x00000000 irq 16
[    5.507000] ata4: SATA max UDMA/100 cmd 0xf8d0a000 ctl 0x00000000 bmdma 0x00000000 irq 16
[    7.639000] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[    7.727000] ata3.15: Port Multiplier 1.1, 0x1095:0x4726 r31, 7 ports, feat 0x1/0x9
[    7.815000] ata3.00: hard resetting link
[    8.285000] ata3.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    8.296000] ata3.01: hard resetting link
[    8.822000] ata3.01: softreset failed (SRST command error)
[    8.822000] ata3.01: reset failed (errno=-5), retrying in 10 secs
[   18.296000] ata3.01: hard resetting link
[   19.877000] ata3.02: hard resetting link
[   20.383000] ata3.02: COMRESET failed (errno=-5)
[   20.636000] ata3.02: reset failed, giving up
[   20.636000] ata3.15: hard resetting link
[   20.636000] ata3: controller in dubious state, performing PORT_RST
[   22.790000] ata3.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[   22.878000] ata3.00: hard resetting link
[   23.348000] ata3.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   23.359000] ata3.01: hard resetting link
[   23.873000] ata3.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   23.884000] ata3.02: hard resetting link
[   24.409000] ata3.02: softreset failed (SRST command error)
[   24.409000] ata3.02: reset failed (errno=-5), retrying in 10 secs
[   33.884000] ata3.02: hard resetting link
[   35.465000] ata3.03: hard resetting link
[   35.971000] ata3.03: COMRESET failed (errno=-5)
[   36.224000] ata3.03: reset failed, giving up
[   36.224000] ata3.15: hard resetting link
[   36.224000] ata3: controller in dubious state, performing PORT_RST
[   38.378000] ata3.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[   38.466000] ata3.00: hard resetting link
[   38.936000] ata3.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   38.947000] ata3.01: hard resetting link
[   39.461000] ata3.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   39.472000] ata3.02: hard resetting link
[   39.986000] ata3.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   39.997000] ata3.03: hard resetting link
[   40.522000] ata3.03: softreset failed (SRST command error)
[   40.522000] ata3.03: reset failed (errno=-5), retrying in 10 secs
[   49.997000] ata3.03: hard resetting link
[   51.578000] ata3.04: hard resetting link
[   52.084000] ata3.04: COMRESET failed (errno=-5)
[   52.337000] ata3.04: reset failed, giving up
[   52.337000] ata3.15: hard resetting link
[   52.337000] ata3: controller in dubious state, performing PORT_RST
[   54.491000] ata3.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[   54.579000] ata3.00: hard resetting link
[   55.049000] ata3.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   55.060000] ata3.01: hard resetting link
[   55.574000] ata3.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   55.585000] ata3.02: hard resetting link
[   56.099000] ata3.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   56.110000] ata3.03: hard resetting link
[   56.624000] ata3.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   56.635000] ata3.04: hard resetting link
[   57.160000] ata3.04: softreset failed (SRST command error)
[   57.160000] ata3.04: reset failed (errno=-5), retrying in 10 secs
[   66.635000] ata3.04: hard resetting link
[   67.963000] ata3.05: hard resetting link
[   68.469000] ata3.05: COMRESET failed (errno=-5)
[   68.722000] ata3.05: reset failed, giving up
[   68.722000] ata3.15: hard resetting link
[   68.722000] ata3: controller in dubious state, performing PORT_RST
[   70.876000] ata3.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[   70.964000] ata3.00: hard resetting link
[   71.434000] ata3.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   71.445000] ata3.01: hard resetting link
[   71.959000] ata3.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   71.970000] ata3.02: hard resetting link
[   72.484000] ata3.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   72.495000] ata3.03: hard resetting link
[   73.009000] ata3.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   73.020000] ata3.04: hard resetting link
[   73.534000] ata3.04: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   73.534000] ata3.05: hard resetting link
[   74.004000] ata3.05: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[   74.004000] ata3.06: hard resetting link
[   74.474000] ata3.06: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   74.517000] ata3.00: ATA-7: ST3750640AS, 3.AAE, max UDMA/133
[   74.517000] ata3.00: 1465149168 sectors, multi 16: LBA48 NCQ (depth 31/32)
[   74.576000] ata3.00: configured for UDMA/100
[   74.619000] ata3.01: ATA-7: ST3750640AS, 3.AAD, max UDMA/133
[   74.619000] ata3.01: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[   74.677000] ata3.01: configured for UDMA/100
[   74.728000] ata3.02: ATA-7: ST3750640AS, 3.AAE, max UDMA/133
[   74.728000] ata3.02: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[   74.786000] ata3.02: configured for UDMA/100
[   74.833000] ata3.03: ATA-7: ST3750640AS, 3.AAD, max UDMA/133
[   74.833000] ata3.03: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[   74.891000] ata3.03: configured for UDMA/100
[   74.941000] ata3.04: ATA-7: ST3750640AS, 3.AAE, max UDMA/133
[   74.941000] ata3.04: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[   74.999000] ata3.04: configured for UDMA/100
[   74.999000] ata3.05: ATA-6: Config  Disk, PLS12052, max UDMA/133
[   74.999000] ata3.05: 640 sectors, multi 1: LBA 
[   74.999000] ata3.05: device is on DMA blacklist, disabling DMA
[   74.999000] ata3.05: configured for PIO4
[   75.022000] ata3: EH complete
[   77.042000] ata4: SATA link down (SStatus 0 SControl 0)
[   77.042000] scsi 2:0:0:0: Direct-Access     ATA      ST3750640AS      3.AA PQ: 0 ANSI: 5
[   77.042000] sd 2:0:0:0: [sdb] 1465149168 512-byte hardware sectors (750156 MB)
[   77.042000] sd 2:0:0:0: [sdb] Write Protect is off
[   77.042000] sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   77.042000] sd 2:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   77.042000] sd 2:0:0:0: [sdb] 1465149168 512-byte hardware sectors (750156 MB)
[   77.042000] sd 2:0:0:0: [sdb] Write Protect is off
[   77.042000] sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   77.042000] sd 2:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   77.042000]  sdb: sdb1 sdb2 sdb3 < sdb5 sdb6 sdb7 sdb8 sdb9 sdb10 >
[   77.126000] sd 2:0:0:0: [sdb] Attached SCSI disk
[   77.126000] sd 2:0:0:0: Attached scsi generic sg2 type 0
[   77.126000] scsi 2:1:0:0: Direct-Access     ATA      ST3750640AS      3.AA PQ: 0 ANSI: 5
[   77.127000] sd 2:1:0:0: [sdc] 1465149168 512-byte hardware sectors (750156 MB)
[   77.127000] sd 2:1:0:0: [sdc] Write Protect is off
[   77.127000] sd 2:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[   77.127000] sd 2:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   77.127000] sd 2:1:0:0: [sdc] 1465149168 512-byte hardware sectors (750156 MB)
[   77.127000] sd 2:1:0:0: [sdc] Write Protect is off
[   77.127000] sd 2:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[   77.127000] sd 2:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   77.127000]  sdc: sdc1 sdc2 sdc3 < sdc5 sdc6 sdc7 sdc8 sdc9 sdc10 >
[   77.210000] sd 2:1:0:0: [sdc] Attached SCSI disk
[   77.210000] sd 2:1:0:0: Attached scsi generic sg3 type 0
[   77.211000] scsi 2:2:0:0: Direct-Access     ATA      ST3750640AS      3.AA PQ: 0 ANSI: 5
[   77.211000] sd 2:2:0:0: [sdd] 1465149168 512-byte hardware sectors (750156 MB)
[   77.211000] sd 2:2:0:0: [sdd] Write Protect is off
[   77.211000] sd 2:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[   77.211000] sd 2:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   77.211000] sd 2:2:0:0: [sdd] 1465149168 512-byte hardware sectors (750156 MB)
[   77.211000] sd 2:2:0:0: [sdd] Write Protect is off
[   77.211000] sd 2:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[   77.211000] sd 2:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   77.211000]  sdd: sdd1 sdd2 sdd3 < sdd5 sdd6 sdd7 sdd8 sdd9 sdd10 >
[   77.297000] sd 2:2:0:0: [sdd] Attached SCSI disk
[   77.297000] sd 2:2:0:0: Attached scsi generic sg4 type 0
[   77.297000] scsi 2:3:0:0: Direct-Access     ATA      ST3750640AS      3.AA PQ: 0 ANSI: 5
[   77.298000] sd 2:3:0:0: [sde] 1465149168 512-byte hardware sectors (750156 MB)
[   77.298000] sd 2:3:0:0: [sde] Write Protect is off
[   77.298000] sd 2:3:0:0: [sde] Mode Sense: 00 3a 00 00
[   77.298000] sd 2:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   77.298000] sd 2:3:0:0: [sde] 1465149168 512-byte hardware sectors (750156 MB)
[   77.298000] sd 2:3:0:0: [sde] Write Protect is off
[   77.298000] sd 2:3:0:0: [sde] Mode Sense: 00 3a 00 00
[   77.298000] sd 2:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   77.298000]  sde: sde1 sde2 sde3 < sde5 sde6 sde7 sde8 sde9 sde10 >
[   77.363000] sd 2:3:0:0: [sde] Attached SCSI disk
[   77.363000] sd 2:3:0:0: Attached scsi generic sg5 type 0
[   77.363000] scsi 2:4:0:0: Direct-Access     ATA      ST3750640AS      3.AA PQ: 0 ANSI: 5
[   77.363000] sd 2:4:0:0: [sdf] 1465149168 512-byte hardware sectors (750156 MB)
[   77.363000] sd 2:4:0:0: [sdf] Write Protect is off
[   77.363000] sd 2:4:0:0: [sdf] Mode Sense: 00 3a 00 00
[   77.363000] sd 2:4:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   77.363000] sd 2:4:0:0: [sdf] 1465149168 512-byte hardware sectors (750156 MB)
[   77.363000] sd 2:4:0:0: [sdf] Write Protect is off
[   77.363000] sd 2:4:0:0: [sdf] Mode Sense: 00 3a 00 00
[   77.363000] sd 2:4:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   77.364000]  sdf: sdf1 sdf2 sdf3 < sdf5 sdf6 sdf7 sdf8 sdf9 sdf10 >
[   77.438000] sd 2:4:0:0: [sdf] Attached SCSI disk
[   77.438000] sd 2:4:0:0: Attached scsi generic sg6 type 0
[   77.438000] scsi 2:5:0:0: Direct-Access     ATA      Config  Disk     PLS1 PQ: 0 ANSI: 5
[   77.438000] sd 2:5:0:0: [sdg] 640 512-byte hardware sectors (0 MB)
[   77.438000] sd 2:5:0:0: [sdg] Write Protect is off
[   77.438000] sd 2:5:0:0: [sdg] Mode Sense: 00 3a 00 00
[   77.438000] sd 2:5:0:0: [sdg] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   77.438000] sd 2:5:0:0: [sdg] 640 512-byte hardware sectors (0 MB)
[   77.438000] sd 2:5:0:0: [sdg] Write Protect is off
[   77.438000] sd 2:5:0:0: [sdg] Mode Sense: 00 3a 00 00
[   77.439000] sd 2:5:0:0: [sdg] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   77.439000]  sdg: unknown partition table
[   77.439000] sd 2:5:0:0: [sdg] Attached SCSI disk
[   77.439000] sd 2:5:0:0: Attached scsi generic sg7 type 0
