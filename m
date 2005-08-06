From: Kyle McMartin <kyle@parisc-linux.org>
Subject: Why toggle_bounce only for disks?
Date: Sat, 6 Aug 2005 19:56:15 -0400
Message-ID: <20050806235615.GK3505@roadwarrior.mcmartin.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fattire.cabal.ca ([134.117.69.58]:57014 "EHLO fattire.cabal.ca")
	by vger.kernel.org with ESMTP id S261362AbVHFX5j (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 6 Aug 2005 19:57:39 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: parisc-linux@lists.parisc-linux.org

Ahoi,

The following patch fixes a crash caused by attempting to bounce buffer
when an IDE CD-ROM is used on a machine with an IO-MMU. [At least, this
patch fixes things so I can use my IDE CD-ROM behind an ns87415 on a 
HP PA-RISC workstation.]

Why was this only allowed for disks?

--- a/drivers/ide/ide-lib.c   18 Jul 2005 18:46:30 -0000
+++ b/drivers/ide/ide-lib.c   6 Aug 2005 20:28:04 -0000
@@ -410,7 +410,7 @@ void ide_toggle_bounce(ide_drive_t *driv
 {
        u64 addr = BLK_BOUNCE_HIGH;     /* dma64_addr_t */
 
-       if (on && drive->media == ide_disk) {
+       if (on) {
                if (!PCI_DMA_BUS_IS_PHYS)
                        addr = BLK_BOUNCE_ANY;
                else if (HWIF(drive)->pci_dev)

Cheers,
-- 
Kyle McMartin
