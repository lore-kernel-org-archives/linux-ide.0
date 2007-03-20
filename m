From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: problem detecting ATAPI device with ahci on 2.6.21-rcx
Date: Tue, 20 Mar 2007 16:49:20 -0700
Message-ID: <20070320164920.0bad5c42.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:36368 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751187AbXCTXvq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Mar 2007 19:51:46 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi, I upgrade a machine from 2.6.20->2.6.21-rc4 and am now having problems
with my ATAPI device getting detected properly.  Back tracking to 2.6.21-rc1,
I find the problem existed there too, but not in 2.6.20.

ahci 0000:00:1f.2: version 2.0
ACPI: PCI Interrupt 0000:00:1f.2[C] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 3 ports 3 Gbps 0x7 impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part 
ata1: SATA max UDMA/133 cmd 0xffffc20000028100 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 4346
ata2: SATA max UDMA/133 cmd 0xffffc20000028180 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 4346
ata3: SATA max UDMA/133 cmd 0xffffc20000028200 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 4346
scsi0 : ahci
ata1: SATA link down (SStatus 0 SControl 300)
scsi1 : ahci
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: ATA-7: HTS721080G9SA00, MC4OC10H, max UDMA/100
ata2.00: 156301488 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata2.00: configured for UDMA/100
scsi2 : ahci
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata3.00: ATAPI, max UDMA/100
ata3.00: qc timeout (cmd 0xa1)
ata3.00: failed to IDENTIFY (I/O error, err_mask=0x104)
ata3.00: revalidation failed (errno=-5)
ata3.00: limiting speed to UDMA/66
ata3: failed to recover some devices, retrying in 5 secs
ata3: port is slow to respond, please be patient (Status 0x80)
ata3: port failed to respond (30 secs, Status 0x80)
ata3: COMRESET failed (device not ready)
ata3: hardreset failed, retrying in 5 secs
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata3.00: qc timeout (cmd 0xa1)
ata3.00: failed to IDENTIFY (I/O error, err_mask=0x104)
ata3.00: revalidation failed (errno=-5)
ata3.00: limiting speed to PIO0
ata3: failed to recover some devices, retrying in 5 secs
ata3: port is slow to respond, please be patient (Status 0x80)
ata3: port failed to respond (30 secs, Status 0x80)
ata3: COMRESET failed (device not ready)
ata3: hardreset failed, retrying in 5 secs
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata3.00: qc timeout (cmd 0xa1)
ata3.00: failed to IDENTIFY (I/O error, err_mask=0x104)
ata3.00: revalidation failed (errno=-5)
ata3.00: disabled
