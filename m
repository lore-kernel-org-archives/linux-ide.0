From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: fix eh_skip_recovery condition
Date: Mon, 10 Jul 2006 23:18:23 +0900
Message-ID: <20060710141823.GG2592@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.238]:26137 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030389AbWGJOR3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Jul 2006 10:17:29 -0400
Received: by wr-out-0506.google.com with SMTP id i23so1683395wra
        for <linux-ide@vger.kernel.org>; Mon, 10 Jul 2006 07:17:28 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

* (ata_dev_absent() || ata_dev_ready()) test doesn't indicate
  SUSPENDED state properly.  Fix it.

* Link resuming resets shouldn't be skipped.  Don't skip recovery on
  EHI_RESUME_LINK.  This doesn't matter for host ports as EHI_RESUME
  always coincides with EHI_HOTPLUGGED which makes attached disabled
  devices vacant.  However, PMP reset causes non-hotplug link-resuming
  resets which shouldn't be skipped.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-eh.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

f971658e0eb5636b7ef67cf0d769f6296e44e914
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 640a035..a9dea3d 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -1864,15 +1864,16 @@ static int ata_eh_skip_recovery(struct a
 	for (i = 0; i < ata_port_max_devices(ap); i++) {
 		struct ata_device *dev = &ap->device[i];
 
-		if (ata_dev_absent(dev) || ata_dev_ready(dev))
+		if (!(dev->flags & ATA_DFLAG_SUSPENDED))
 			break;
 	}
 
 	if (i == ata_port_max_devices(ap))
 		return 1;
 
-	/* always thaw frozen port and recover failed devices */
-	if (ap->pflags & ATA_PFLAG_FROZEN || ata_port_nr_enabled(ap))
+	/* thaw frozen port, resume link and recover failed devices */
+	if ((ap->pflags & ATA_PFLAG_FROZEN) ||
+	    (ehc->i.flags & ATA_EHI_RESUME_LINK) || ata_port_nr_enabled(ap))
 		return 0;
 
 	/* skip if class codes for all vacant slots are ATA_DEV_NONE */
-- 
1.3.2

