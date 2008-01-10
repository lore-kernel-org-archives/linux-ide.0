From: Tobias =?iso-8859-1?q?M=FCller?= <Tobias_Mueller@twam.info>
Subject: 40-wire cable detected when directly connected
Date: Thu, 10 Jan 2008 18:24:04 +0100
Message-ID: <200801101824.04863.Tobias_Mueller@twam.info>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ceres.twam.info ([84.16.224.131]:49488 "EHLO smtp.twam.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755848AbYAJRb6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Jan 2008 12:31:58 -0500
Received: from twam-pc.space.twam.info (p5B2EE401.dip.t-dialin.net [91.46.228.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.twam.info (Postfix) with ESMTP id E5ABF20817
	for <linux-ide@vger.kernel.org>; Thu, 10 Jan 2008 18:24:21 +0100 (CET)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello!

I'm running 2.6.24-rc7 with an Addonics AD4CFPRJ Quad-CF PCI Controller 
(http://www.addonics.com/products/flash_memory_reader/ad4cfprj.asp) using 
Silicon Image PCI0680 chipset which is connected direct (no cables) with 2 
Compact-Flash Cards.

In configured
CONFIG_ATA=y
CONFIG_PATA_SIL680=y

and the controller is correclty found, but it complains about 40-wire cables, 
but I'm not using any cables
at all.

Is there a solution to disable this check or to correct this?

Regards
  Tobias

dmesg reports
[   32.577206] pata_sil680 0000:03:04.0: version 0.4.8
[   32.577230] sil680: 133MHz clock.
[   32.577302] ACPI: PCI Interrupt 0000:03:04.0[A] -> GSI 16 (level, low) -> 
IRQ 16
[   32.577986] PCI: Setting latency timer of device 0000:03:04.0 to 64
[   32.578062] scsi4 : pata_sil680
[   32.578232] scsi5 : pata_sil680
[   32.578337] ata5: PATA max UDMA/133 irq 16
[   32.578399] ata6: PATA max UDMA/133 irq 16
[   32.732289] ata5.00: ATA-4: SanDisk SDCFX4-8192, HDX 4.20, max UDMA/66
[   32.732353] ata5.00: 16007040 sectors, multi 0: LBA
[   32.732422] ata5.00: limited to UDMA/33 due to 40-wire cable
[   32.733155] ata5.00: configured for UDMA/33
[   32.892034] ata6.00: ATA-4: SanDisk SDCFX3-2048, HDX 4.08, max MWDMA2
[   32.892099] ata6.00: 4001760 sectors, multi 0: LBA
[   32.911705] ata6.00: configured for MWDMA2
[   32.911856] scsi 4:0:0:0: Direct-Access     ATA      SanDisk SDCFX4-8 HDX  
PQ: 0 ANSI: 5
[   32.912062] sd 4:0:0:0: [sdc] 16007040 512-byte hardware sectors (8196 MB)
[   32.912135] sd 4:0:0:0: [sdc] Write Protect is off
[   32.912198] sd 4:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[   32.912215] sd 4:0:0:0: [sdc] Write cache: disabled, read cache: enabled, 
doesn't support DPO or FUA
[   32.912357] sd 4:0:0:0: [sdc] 16007040 512-byte hardware sectors (8196 MB)
[   32.912429] sd 4:0:0:0: [sdc] Write Protect is off
[   32.912492] sd 4:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[   32.912508] sd 4:0:0:0: [sdc] Write cache: disabled, read cache: enabled, 
doesn't support DPO or FUA
[   32.912604]  sdc: sdc1 sdc2
[   32.913353] sd 4:0:0:0: [sdc] Attached SCSI disk
[   32.913554] scsi 5:0:0:0: Direct-Access     ATA      SanDisk SDCFX3-2 HDX  
PQ: 0 ANSI: 5
[   32.913746] sd 5:0:0:0: [sdd] 4001760 512-byte hardware sectors (2049 MB)
[   32.913819] sd 5:0:0:0: [sdd] Write Protect is off
[   32.913882] sd 5:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[   32.913898] sd 5:0:0:0: [sdd] Write cache: disabled, read cache: enabled, 
doesn't support DPO or FUA
[   32.914026] sd 5:0:0:0: [sdd] 4001760 512-byte hardware sectors (2049 MB)
[   32.914099] sd 5:0:0:0: [sdd] Write Protect is off
[   32.914161] sd 5:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[   32.914176] sd 5:0:0:0: [sdd] Write cache: disabled, read cache: enabled, 
doesn't support DPO or FUA
[   32.914273]  sdd: sdd1
[   32.915200] sd 5:0:0:0: [sdd] Attached SCSI dis

lspci -v
03:04.0 RAID bus controller: Silicon Image, Inc. PCI0680 Ultra ATA-133 Host 
Controller (rev 02)
        Subsystem: Silicon Image, Inc. Winic W-680 (Silicon Image 680 based)
        Flags: bus master, medium devsel, latency 64, IRQ 16
        I/O ports at df00 [size=8]
        I/O ports at de00 [size=4]
        I/O ports at dd00 [size=8]
        I/O ports at dc00 [size=4]
        I/O ports at db00 [size=16]
        Memory at fdcff000 (32-bit, non-prefetchable) [size=256]
        [virtual] Expansion ROM at fdb00000 [disabled] [size=512K]
        Capabilities: [60] Power Management version 2
        Kernel driver in use: pata_sil680
