From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] libata: set device class to NONE if phys_offline
Date: Wed, 22 Oct 2008 00:31:34 +0900
Message-ID: <48FDF5D6.20707@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49187 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751843AbYJUPbq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Oct 2008 11:31:46 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Reset methods don't have access to phys link status for slave links
and may incorrectly indicate device presence causing unnecessary probe
failures for unoccupied links.  This patch clears device class to NONE
during post-reset processing if phys link is offline.

As on/offliness semantics is strictly defined and used in multiple
places by the core layer, this won't change behavior for drivers which
don't use slave links.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
vt8251 incorrectly reports the same signature for unoccupied device if
the other device on the channel is present.  This patch fixes the
problem.

I integrated this patch into separate-sff-bmdma git tree.

 drivers/ata/libata-eh.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

Index: work/drivers/ata/libata-eh.c
===================================================================
--- work.orig/drivers/ata/libata-eh.c
+++ work/drivers/ata/libata-eh.c
@@ -2455,14 +2455,14 @@ int ata_eh_reset(struct ata_link *link,
 		dev->pio_mode = XFER_PIO_0;
 		dev->flags &= ~ATA_DFLAG_SLEEPING;
 
-		if (ata_phys_link_offline(ata_dev_phys_link(dev)))
-			continue;
-
-		/* apply class override */
-		if (lflags & ATA_LFLAG_ASSUME_ATA)
-			classes[dev->devno] = ATA_DEV_ATA;
-		else if (lflags & ATA_LFLAG_ASSUME_SEMB)
-			classes[dev->devno] = ATA_DEV_SEMB_UNSUP; /* not yet */
+		if (!ata_phys_link_offline(ata_dev_phys_link(dev))) {
+			/* apply class override */
+			if (lflags & ATA_LFLAG_ASSUME_ATA)
+				classes[dev->devno] = ATA_DEV_ATA;
+			else if (lflags & ATA_LFLAG_ASSUME_SEMB)
+				classes[dev->devno] = ATA_DEV_SEMB_UNSUP;
+		} else
+			classes[dev->devno] = ATA_DEV_NONE;
 	}
 
 	/* record current link speed */
