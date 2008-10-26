From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] libata: clear saved xfer_mode and ncq_enabled
 on device detach
Date: Sun, 26 Oct 2008 15:43:03 +0900
Message-ID: <49041177.40008@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56835 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752736AbYJZGnO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 26 Oct 2008 02:43:14 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik l <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

libata EH saves xfer_mode and ncq_enabled at start to later set
DUBIOUS_XFER flag if it has changed.  These values need to be cleared
on device detach such that hot device swap doesn't accidentally miss
DUBIOUS_XFER.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libata-eh.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Index: work/drivers/ata/libata-eh.c
===================================================================
--- work.orig/drivers/ata/libata-eh.c
+++ work/drivers/ata/libata-eh.c
@@ -1161,6 +1161,7 @@ void ata_eh_detach_dev(struct ata_device
 {
 	struct ata_link *link = dev->link;
 	struct ata_port *ap = link->ap;
+	struct ata_eh_context *ehc = &link->eh_context;
 	unsigned long flags;
 
 	ata_dev_disable(dev);
@@ -1174,9 +1175,11 @@ void ata_eh_detach_dev(struct ata_device
 		ap->pflags |= ATA_PFLAG_SCSI_HOTPLUG;
 	}
 
-	/* clear per-dev EH actions */
+	/* clear per-dev EH info */
 	ata_eh_clear_action(link, dev, &link->eh_info, ATA_EH_PERDEV_MASK);
 	ata_eh_clear_action(link, dev, &link->eh_context.i, ATA_EH_PERDEV_MASK);
+	ehc->saved_xfer_mode[dev->devno] = 0;
+	ehc->saved_ncq_enabled &= ~(1 << dev->devno);
 
 	spin_unlock_irqrestore(ap->lock, flags);
 }
