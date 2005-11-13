From: Kyle McMartin <kyle@parisc-linux.org>
Subject: Fix ide_toggle_bounce to not try to bounce if we have an IOMMU
Date: Sun, 13 Nov 2005 15:24:28 -0500
Message-ID: <20051113202428.GA3825@tachyon.int.mcmartin.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fattire.cabal.ca ([134.117.69.58]:37254 "EHLO fattire.cabal.ca")
	by vger.kernel.org with ESMTP id S1750811AbVKMUYd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 Nov 2005 15:24:33 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by fattire.cabal.ca (Postfix) with ESMTP id 8FC4F17083
	for <linux-ide@vger.kernel.org>; Sun, 13 Nov 2005 15:24:32 -0500 (EST)
Received: from fattire.cabal.ca ([127.0.0.1])
	by localhost (fattire [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 20690-10 for <linux-ide@vger.kernel.org>;
	Sun, 13 Nov 2005 15:24:32 -0500 (EST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

The following patch fixes a crash caused by attempting to bounce buffer
when an IDE CD-ROM is used on a machine with an IO-MMU. [At least, this
patch fixes things so I can use my IDE CD-ROM behind an ns87415 on a 
HP PA-RISC workstation.]

This is a followup to a previous patch. It would be nice to get it merged
as PA-RISC is heading towards being usable out of the mainline tree.

Signed-off-by: James Bottomley <jejb@parisc-linux.org>
Signed-off-by: Kyle McMartin <kyle@parisc-linux.org>

--- linus-2.6/drivers/ide/ide-lib.c	2005-11-11 21:14:59.000000000 -0700
+++ parisc-2.6/drivers/ide/ide-lib.c	2005-11-11 20:16:07.000000000 -0700
@@ -410,10 +410,10 @@ void ide_toggle_bounce(ide_drive_t *driv
 {
 	u64 addr = BLK_BOUNCE_HIGH;	/* dma64_addr_t */
 
-	if (on && drive->media == ide_disk) {
-		if (!PCI_DMA_BUS_IS_PHYS)
-			addr = BLK_BOUNCE_ANY;
-		else if (HWIF(drive)->pci_dev)
+	if (!PCI_DMA_BUS_IS_PHYS) {
+		addr = BLK_BOUNCE_ANY;
+	} else if (on && drive->media == ide_disk) {
+		if (HWIF(drive)->pci_dev)
 			addr = HWIF(drive)->pci_dev->dma_mask;
 	}
 
