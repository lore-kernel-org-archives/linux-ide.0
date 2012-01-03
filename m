From: "D. Stussy" <replies+newsgroups@kd6lvw.ampr.org>
Subject: Recurring error with SATA driver.
Date: Tue, 3 Jan 2012 19:33:21 +0000 (UTC)
Message-ID: <alpine.LNX.2.00.1201031929290.1620@snarked.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.snarked.org ([67.43.172.250]:2168 "EHLO mail.snarked.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754438Ab2ACTta (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Jan 2012 14:49:30 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

ata1: illegal qc_active transition (3fffffff->fffffffe)

I'm getting this about once every 3 days.  When this happens, the affected 
partition is remounted read-only (per my file system error options).

I am not certain if this is telling me I have a hardware error, 
incompatibility, or if there's a design problem with the driver.

Seen with kernels: 3.0.14, 3.1.4, 3.1.5, and  3.1.6

Motherboard:  Supermicro H8SCM-F
Disk Drives:  Seagate 1.8TB drives

Kernel log messages:
pci 0000:00:11.0: set SATA to AHCI mode
libata version 3.00 loaded.
ahci 0000:00:11.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
ata1: SATA max UDMA/133 abar m1024@0xfe9fa400 port 0xfe9fa500 irq 22
ata2: SATA max UDMA/133 abar m1024@0xfe9fa400 port 0xfe9fa580 irq 22
ata3: SATA max UDMA/133 abar m1024@0xfe9fa400 port 0xfe9fa600 irq 22
ata4: SATA max UDMA/133 abar m1024@0xfe9fa400 port 0xfe9fa680 irq 22
ata3: SATA link down (SStatus 0 SControl 300)
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-8: ST32000644NS, SN11, max UDMA/133
ata1.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata2.00: ATA-8: ST32000644NS, SN11, max UDMA/133
ata2.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata4.00: ATAPI: Optiarc DVD RW AD-7700S, 1.03, max UDMA/100
ata1.00: configured for UDMA/133
ata2.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      ST32000644NS     SN11 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
scsi 1:0:0:0: Direct-Access     ATA      ST32000644NS     SN11 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:0:0:0: [sdb] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
ata4.00: configured for UDMA/100
  sda: sda1
sd 0:0:0:0: [sda] Attached SCSI disk
  sdb: sdb1
sd 1:0:0:0: [sdb] Attached SCSI disk
scsi 3:0:0:0: CD-ROM            Optiarc  DVD RW AD-7700S  1.03 PQ: 0 ANSI: 5

Kernel options:
CONFIG_SCSI_SAS_ATA=y
CONFIG_ATA=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_ACPI=y
CONFIG_SATA_PMP=y
CONFIG_SATA_AHCI=y
CONFIG_ATA_SFF=y
CONFIG_ATA_BMDMA=y
CONFIG_PATA_AMD=y
CONFIG_ATA_GENERIC=y

