From: Benjamin LaHaise <bcrl@kvack.org>
Subject: bug: AHCI: Serial ATA to CompactFlash adapter loops endlessly
Date: Fri, 17 Nov 2006 16:11:35 -0500
Message-ID: <20061117211135.GO7299@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kanga.kvack.org ([66.96.29.28]:33712 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1755918AbWKQVLp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Nov 2006 16:11:45 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hello Jeff,

While trying out a CompactFlash card on Serial ATA to CF adapter, I'm 
running into a machine that loops endlessly after attempting to disable 
DMA due to blacklisting.  The adapter itself works with a different CF 
card that isn't blacklisted and uses DMA.  Note that most CompactFlash 
should not be blacklisted, rather the adapters that don't wire up the DMA 
line should be worked around by the system owner with ideX=nodma (which 
is definately the case with some of the WRAP boards, which could perhaps 
be worked around by detecting their BIOS).  Anyway, I'm game for testing 
any patches/ideas that folks have.  Thanks,

		-ben

... snip ...
[  153.723251] lp0: using parport0 (interrupt-driven).
[  153.738041] Floppy drive(s): fd0 is 1.44M
[  153.766938] FDC 0 is a post-1991 82077
[  153.779190] RAMDISK driver initialized: 1 RAM disks of 4096K size 4096 blocksize
[  153.801538] loop: loaded (max 8 devices)
[  153.813256] Intel(R) PRO/1000 Network Driver - version 7.2.9-k4-NAPI
[  153.832238] Copyright (c) 1999-2006 Intel Corporation.
[  153.847638] ACPI: PCI Interrupt 0000:06:00.0[A] -> GSI 18 (level, low) -> IRQ 18
[  153.905321] e1000: 0000:06:00.0: e1000_probe: (PCI Express:2.5Gb/s:32-bit) 00:30:48:31:97:6c
[  153.979188] e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
[  153.999729] ACPI: PCI Interrupt 0000:06:00.1[B] -> GSI 19 (level, low) -> IRQ 19
[  154.054932] e1000: 0000:06:00.1: e1000_probe: (PCI Express:2.5Gb/s:32-bit) 00:30:48:31:97:6d
[  154.126983] e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
[  154.147526] pcnet32.c:v1.33-NAPI 27.Jun.2006 tsbogend@alpha.franken.de
[  154.167064] e100: Intel(R) PRO/100 Network Driver, 3.5.17-k2-NAPI
[  154.185255] e100: Copyright(c) 1999-2006 Intel Corporation
[  154.201785] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[  154.220757] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[  154.244698] ESB2: IDE controller at PCI slot 0000:00:1f.1
[  154.260823] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
[  154.282968] ESB2: chipset revision 9
[  154.293652] ESB2: not 100% native mode: will probe irqs later
[  154.310823]     ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:pio, hdb:pio
[  156.496086] Loading iSCSI transport class v2.0-685.<7>libata version 2.00 loaded.
[  156.518758] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
[  157.543356] ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 6 ports ? Gbps 0x3f impl SATA mode
[  157.567786] ahci 0000:00:1f.2: flags: 64bit stag led pmp 
[  157.584039] ata1: SATA max UDMA/133 cmd 0xFFFFC2000001E500 ctl 0x0 bmdma 0x0 irq 19
[  157.606958] ata2: SATA max UDMA/133 cmd 0xFFFFC2000001E580 ctl 0x0 bmdma 0x0 irq 19
[  157.629878] ata3: SATA max UDMA/133 cmd 0xFFFFC2000001E600 ctl 0x0 bmdma 0x0 irq 19
[  157.652816] ata4: SATA max UDMA/133 cmd 0xFFFFC2000001E680 ctl 0x0 bmdma 0x0 irq 19
[  157.675753] ata5: SATA max UDMA/133 cmd 0xFFFFC2000001E700 ctl 0x0 bmdma 0x0 irq 19
[  157.698677] ata6: SATA max UDMA/133 cmd 0xFFFFC2000001E780 ctl 0x0 bmdma 0x0 irq 19
[  157.721548] scsi0 : ahci
[  158.251502] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  158.270424] ata1.00: ATA-7, max UDMA/133, 234441648 sectors: LBA48 
[  158.289143] ata1.00: ata1: dev 0 multi count 0
[  158.302960] ata1.00: configured for UDMA/133
[  158.315705] scsi1 : ahci
[  158.849948] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  158.870017] ata2.00: ATA-0, max PIO4, 2030112 sectors: LBA 
[  158.886648] ata2.00: ata2: dev 0 multi count 0
[  158.899927] ata2.00: applying bridge limits
[  158.912426] ata2.00: device is on DMA blacklist, disabling DMA
[  158.930665] ata2.00: configured for PIO4
[  158.942382] scsi2 : ahci
[  159.278827] ata3: SATA link down (SStatus 0 SControl 300)
[  159.294961] scsi3 : ahci
[  159.627922] ata4: SATA link down (SStatus 0 SControl 300)
[  159.644060] scsi4 : ahci
[  159.977017] ata5: SATA link down (SStatus 0 SControl 300)
[  159.993135] scsi5 : ahci
[  160.326113] ata6: SATA link down (SStatus 0 SControl 300)
[  160.342312] scsi 0:0:0:0: Direct-Access     ATA      WDC WD1200JS-00M 02.0 PQ: 0 ANSI: 5
[  160.366571] SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
[  160.386580] sda: Write Protect is off
[  160.397526] SCSI device sda: drive cache: write back
[  160.412384] SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
[  160.432399] sda: Write Protect is off
[  160.443347] SCSI device sda: drive cache: write back
[  160.458183]  sda: sda1 sda2 sda3
[  160.472859] sd 0:0:0:0: Attached scsi disk sda
[  160.486202] sd 0:0:0:0: Attached scsi generic sg0 type 0
[  160.502147] scsi 1:0:0:0: Direct-Access     ATA                       2006 PQ: 0 ANSI: 5
[  160.526376] SCSI device sdb: 2030112 512-byte hdwr sectors (1039 MB)
[  160.545373] sdb: Write Protect is off
[  160.556310] SCSI device sdb: drive cache: write through
[  160.571942] SCSI device sdb: 2030112 512-byte hdwr sectors (1039 MB)
[  160.590924] sdb: Write Protect is off
[  160.601872] SCSI device sdb: drive cache: write through
[  160.617473]  sdb:<3>ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
[  190.555795] ata2.00: tag 0 cmd 0x20 Emask 0x4 stat 0x40 err 0x0 (timeout)
[  190.896902] ata2: soft resetting port
[  190.907845] ata2: softreset failed (port busy but CLO unavailable)
[  190.926306] ata2: softreset failed, retrying in 5 secs
[  195.933851] ata2: hard resetting port
[  203.294811] ata2: port is slow to respond, please be patient (Status 0x80)
[  226.235343] ata2: port failed to respond (30 secs, Status 0x80)
[  226.253011] ata2: COMRESET failed (device not ready)
[  226.267845] ata2: hardreset failed, retrying in 5 secs
[  231.272293] ata2: hard resetting port
[  231.691222] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  231.711328] ata2.00: device is on DMA blacklist, disabling DMA
[  231.729558] ata2.00: configured for PIO4
[  231.741284] ata2: EH complete
[  261.663560] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
[  261.684614] ata2.00: tag 0 cmd 0x20 Emask 0x4 stat 0x40 err 0x0 (timeout)
[  262.032598] ata2: soft resetting port
[  262.043546] ata2: softreset failed (port busy but CLO unavailable)
[  262.062006] ata2: softreset failed, retrying in 5 secs
[  267.069547] ata2: hard resetting port
[  274.430507] ata2: port is slow to respond, please be patient (Status 0x80)
[  297.371039] ata2: port failed to respond (30 secs, Status 0x80)
[  297.388710] ata2: COMRESET failed (device not ready)
[  297.403544] ata2: hardreset failed, retrying in 5 secs
[  302.407989] ata2: hard resetting port
[  302.826919] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  302.847011] ata2.00: device is on DMA blacklist, disabling DMA
[  302.865229] ata2.00: configured for PIO4
[  302.876952] ata2: EH complete
