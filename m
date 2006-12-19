From: Joakim Crafack <joakim@crafack.dk>
Subject: ata_piix: Quick question
Date: Tue, 19 Dec 2006 13:37:28 +0100
Message-ID: <4587DD08.70404@crafack.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout.surf-town.net ([212.97.132.199]:44343 "EHLO
	mailout.surf-town.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932819AbWLSMnt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Dec 2006 07:43:49 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailout.surf-town.net (Postfix) with ESMTP id 75647E005CB3
	for <linux-ide@vger.kernel.org>; Tue, 19 Dec 2006 13:10:14 +0100 (CET)
Received: from mail1.surf-town.net (mail1.surf-town.net [212.97.132.41])
	by mailout.surf-town.net (Postfix) with SMTP id 18FADE0029C8
	for <linux-ide@vger.kernel.org>; Tue, 19 Dec 2006 12:44:19 +0100 (CET)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi all.

Some time ago, I reported bug# 7170, as my ICH6 controller failed to 
detect my disks after kernel upgrade.

I tested the 2.6.20-rc1 kernel yesterday, and now the controller reports:

[   21.506369] ICH6: IDE controller at PCI slot 0000:00:1f.1
[   21.506420] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, 
low) -> IRQ 18
[   21.506518] ICH6: chipset revision 3
[   21.506565] ICH6: not 100% native mode: will probe irqs later
[   21.506622]     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: 
hda:DMA, hdb:pio
[   22.177871] hda: LITE-ON DVDRW SOHW-1633S, ATAPI CD/DVD-ROM drive
[   22.789485] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   23.302937] hda: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache
[   23.303232] Uniform CD-ROM driver Revision: 3.20
[   23.305545] ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
[   23.305787] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, 
low) -> IRQ 19
[   23.305927] ata1: SATA max UDMA/133 cmd 0xB400 ctl 0xB082 bmdma 
0xA880 irq 19
[   23.306001] ata2: SATA max UDMA/133 cmd 0xB000 ctl 0xAC02 bmdma 
0xA888 irq 19
[   23.306056] scsi0 : ata_piix
[   23.466877] ATA: abnormal status 0xD0 on port 0xB407
[   23.466932] scsi1 : ata_piix
[   23.627759] ATA: abnormal status 0x7F on port 0xB007
[...]
[   23.990751] VFS: Cannot open root device "sda3" or unknown-block(0,0)
[   23.990798] Please append a correct "root=" boot option
[   23.990848] Kernel panic - not syncing: VFS: Unable to mount root fs 
on unknown-block(0,0)


The disk is attatched to ata1, ata2 is not connected.

Is there something wrong here, or has the disk "just" been renamed ???

Regards
Joakim Crafack




