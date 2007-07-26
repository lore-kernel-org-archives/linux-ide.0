From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH] pata_cmd64x: Correct the speed ranges
Date: Thu, 26 Jul 2007 23:01:18 +0200 (MEST)
Message-ID: <200707262101.l6QL1Iqk029149@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:58656 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763152AbXGZVB0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 26 Jul 2007 17:01:26 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: alan@lxorguk.ukuu.org.uk
Cc: linux-ide@vger.kernel.org

On Thu, 26 Jul 2007 18:43:01 +0100, Alan Cox wrote:
> I must have been half asleep when doing the original code
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
[patch to fix .udma_mask in pata_cmd64x omitted]

This fix inspired me to finally try to convert my Sun Ultra5
(sparc64) with a CMD646 [1095:0646 rev 03] to libata.

With pata_cmd64x the machine has so far survived a usual
boot/mrproper/reconfig/make/install/reboot kernel update
cycle without any issues, and performance seems to be the
same as with the old IDE driver.

/Mikael

scsi0 : pata_cmd64x
scsi1 : pata_cmd64x
ata1: PATA max MWDMA2 cmd 0x000001fe02c00000 ctl 0x000001fe02c0000a bmdma 0x000001fe02c00020 irq 14
ata2: PATA max MWDMA2 cmd 0x000001fe02c00010 ctl 0x000001fe02c0001a bmdma 0x000001fe02c00028 irq 14
ata1.00: ATA-4: ST320420A, 3.21, max UDMA/66
ata1.00: 39851760 sectors, multi 0: LBA 
pata_cmd64x: active 3 recovery 1 setup 1.
ata1.00: configured for MWDMA2
ata2.00: ATAPI: CRD-8483B, 1.00, max UDMA/33
pata_cmd64x: active 3 recovery 1 setup 1.
ata2.00: configured for MWDMA2
scsi 0:0:0:0: Direct-Access     ATA      ST320420A        3.21 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 39851760 512-byte hardware sectors (20404 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 39851760 512-byte hardware sectors (20404 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3 sda4 sda5
sd 0:0:0:0: [sda] Attached SCSI disk
scsi 1:0:0:0: CD-ROM            LG       CD-ROM CRD-8483B 1.00 PQ: 0 ANSI: 5
