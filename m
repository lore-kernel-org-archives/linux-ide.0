From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/3] libata: separate out ata_ncq_enabled()
Date: Tue, 20 Feb 2007 23:20:27 +0900
Message-ID: <20070220142027.GP1625@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.225]:35099 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964930AbXBTOUb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Feb 2007 09:20:31 -0500
Received: by wx-out-0506.google.com with SMTP id h31so2029601wxd
        for <linux-ide@vger.kernel.org>; Tue, 20 Feb 2007 06:20:30 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org
Cc: haebler@gmail.com, lkml@fliagreco.com.ar

Separate out ata_ncq_enabled().

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    4 +---
 include/linux/libata.h    |   15 +++++++++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c
+++ work/drivers/ata/libata-core.c
@@ -311,9 +311,7 @@ int ata_build_rw_tf(struct ata_taskfile 
 	tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	tf->flags |= tf_flags;
 
-	if ((dev->flags & (ATA_DFLAG_PIO | ATA_DFLAG_NCQ_OFF |
-			   ATA_DFLAG_NCQ)) == ATA_DFLAG_NCQ &&
-	    likely(tag != ATA_TAG_INTERNAL)) {
+	if (ata_ncq_enabled(dev) && likely(tag != ATA_TAG_INTERNAL)) {
 		/* yay, NCQ */
 		if (!lba_48_ok(block, n_block))
 			return -ERANGE;
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h
+++ work/include/linux/libata.h
@@ -1026,6 +1026,21 @@ static inline u8 ata_chk_status(struct a
 	return ap->ops->check_status(ap);
 }
 
+/**
+ *	ata_ncq_enabled - Test whether NCQ is enabled
+ *	@dev: ATA device to test for
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host lock)
+ *
+ *	RETURNS:
+ *	1 if NCQ is enabled for @dev, 0 otherwise.
+ */
+static inline int ata_ncq_enabled(struct ata_device *dev)
+{
+	return (dev->flags & (ATA_DFLAG_PIO | ATA_DFLAG_NCQ_OFF |
+			      ATA_DFLAG_NCQ)) == ATA_DFLAG_NCQ;
+}
 
 /**
  *	ata_pause - Flush writes and pause 400 nanoseconds.
