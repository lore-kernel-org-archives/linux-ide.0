From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: fix ATA_EH_REVALIDATE clearing
Date: Mon, 12 Jun 2006 14:11:01 +0900
Message-ID: <20060612051101.GB9166@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.197]:55505 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751330AbWFLFLV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jun 2006 01:11:21 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1552477nze
        for <linux-ide@vger.kernel.org>; Sun, 11 Jun 2006 22:11:20 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

ATA_EH_REVALIDATE should be cleared after all devices on the target
port have been revalidated.  Fix ata_eh_revalidate_and_attach()
accordingly.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-eh.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

1e3e586afea4afc1ef58fe8b21388017e9a4da57
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index f82799e..782dfba 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -1556,8 +1556,6 @@ static int ata_eh_revalidate_and_attach(
 
 			/* schedule the scsi_rescan_device() here */
 			queue_work(ata_aux_wq, &(ap->scsi_rescan_task));
-
-			ehc->i.action &= ~ATA_EH_REVALIDATE;
 		} else if (dev->class == ATA_DEV_UNKNOWN &&
 			   ehc->tries[dev->devno] &&
 			   ata_class_enabled(ehc->classes[dev->devno])) {
@@ -1578,7 +1576,9 @@ static int ata_eh_revalidate_and_attach(
 		}
 	}
 
-	if (rc)
+	if (rc == 0)
+		ehc->i.action &= ~ATA_EH_REVALIDATE;
+	else
 		*r_failed_dev = dev;
 
 	DPRINTK("EXIT\n");
-- 
1.3.2
