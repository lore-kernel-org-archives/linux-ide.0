From: Alexey Lobanov <A.Lobanov@gctrials.com>
Subject: sata_via.c next-20100125 unsuccess report
Date: Tue, 26 Jan 2010 15:13:21 +0300
Message-ID: <4B5EDC61.4050004@gctrials.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.cro-rct.ru ([83.136.242.126]:50344 "EHLO rct.gctrials.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752088Ab0AZMUx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Jan 2010 07:20:53 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello Jeff,
hello all.

I just report that the fresh change in vt6421_set_dma_mode does not 
solve (for me) the stable problem described at 
http://lkml.org/lkml/2009/10/11/36 "Lots of 6421 setups do not work". 
Relaxed reading still works, intensive reading still fails. NB: the 
patch had been applied to 2.6.32-rc5 instead of Linux-next.

=======

root@test:~# modinfo sata_via
filename:       /lib/modules/2.6.32-rc5/kernel/drivers/ata/sata_via.ko
author:         Jeff Garzik
description:    SCSI low-level driver for VIA SATA controllers
license:        GPL
version:        2.5
vermagic:       2.6.32-rc5 mod_unload PENTIUMII

======

root@test:~# lspci
00:00.0 Host bridge: Intel Corporation 82815 815 Chipset Host Bridge and 
Memory Controller Hub (rev 04)
00:01.0 PCI bridge: Intel Corporation 82815 815 Chipset AGP Bridge (rev 04)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 02)
00:1f.0 ISA bridge: Intel Corporation 82801BA ISA Bridge (LPC) (rev 02)
00:1f.1 IDE interface: Intel Corporation 82801BA IDE U100 Controller 
(rev 02)
00:1f.2 USB Controller: Intel Corporation 82801BA/BAM USB Controller #1 
(rev 02)
00:1f.3 SMBus: Intel Corporation 82801BA/BAM SMBus Controller (rev 02)
00:1f.4 USB Controller: Intel Corporation 82801BA/BAM USB Controller #1 
(rev 02)
01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 
MX/MX 400] (rev b2)
02:03.0 RAID bus controller: VIA Technologies, Inc. VT6421 IDE RAID 
Controller (rev 50)
02:04.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
02:09.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)

========
dmesg ...

sata_via 0000:02:03.0: version 2.5
ACPI: PCI Interrupt Link [LNK0] enabled at IRQ 11
sata_via 0000:02:03.0: PCI INT A -> Link[LNK0] -> GSI 11 (level, low) -> 
IRQ 11
sata_via 0000:02:03.0: routed to hard irq line 11
scsi0 : sata_via
scsi1 : sata_via
scsi2 : sata_via
ata1: SATA max UDMA/133 port i16@0x9000 bmdma 0xa000 irq 11
ata2: SATA max UDMA/133 port i16@0x9400 bmdma 0xa008 irq 11
ata3: PATA max UDMA/133 port i16@0x9800 bmdma 0xa010 irq 11
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: ATA-7: Hitachi HDT725032VLA360, V54OA7EA, max UDMA/133
ata1.00: 625142448 sectors, multi 16: LBA48 NCQ (depth 0/32)
ata1.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      Hitachi HDT72503 V54O PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 625142448 512-byte logical blocks: (320 GB/298 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA sda: sda1
sd 0:0:0:0: [sda] Attached SCSI disk

====

root@test:~# hdparm -t /dev/sda

ata1.00: exception Emask 0x12 SAct 0x0 SErr 0x1380500 action 0x6
ata1.00: BMDMA stat 0x5
ata1: SError: { UnrecovData Proto 10B8B Dispar BadCRC TrStaTrns }
ata1.00: failed command: READ DMA EXT
ata1.00: cmd 25/00:00:00:30:00/00:02:00:00:00/e0 tag 0 dma 262144 in
          res 51/84:b0:4f:31:00/84:00:00:00:00/e0 Emask 0x12 (ATA bus error)
ata1.00: status: { DRDY ERR }
ata1.00: error: { ICRC ABRT }
ata1: soft resetting link
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x12 SAct 0x0 SErr 0x1280500 action 0x6
ata1.00: BMDMA stat 0x5
ata1: SError: { UnrecovData Proto 10B8B BadCRC TrStaTrns }
ata1.00: failed command: READ DMA EXT
ata1.00: cmd 25/00:00:00:30:00/00:02:00:00:00/e0 tag 0 dma 262144 in
          res 51/84:30:cf:30:00/84:01:00:00:00/e0 Emask 0x12 (ATA bus error)
ata1.00: status: { DRDY ERR }
ata1.00: error: { ICRC ABRT }
ata1: soft resetting link

============

There are rumors that same vt6421 chips work fine in VIA motherboards; I 
haven't any alive one for tests.

Alexey
