From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: reduce ATA command timeout to 7secs
Date: Fri, 2 Feb 2007 15:37:48 +0900
Message-ID: <20070202063748.GC1625@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.228]:57585 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423150AbXBBGiQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Feb 2007 01:38:16 -0500
Received: by nz-out-0506.google.com with SMTP id s1so779769nze
        for <linux-ide@vger.kernel.org>; Thu, 01 Feb 2007 22:38:15 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Both ATA and ATAPI devices used the default timeouts defined by SCSI
high level driver.  For both disks and ODDs, it was 30secs, which was
way too long for disks.  This patch makes most ATA commands time out
after 7secs - the de facto ATA command timeout, while leaving ATAPI
timeout at 30secs.

Note that both normal commands and EH commands timeouts are adjusted
to 7 secs, but cache flushses still have 30sec timeout.  This is a
side effect of the way sd makes use of sdev->timeout, but this is a
good side effect in that ATA spec requires cache flushes are given
longer timeout.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
I think we've waited enough.  Combined with EH updates which will soon
be posted, this should make life much easier (well, at least
responsive) when something goes wrong with ATA.

 drivers/ata/libata-core.c |    2 +-
 drivers/ata/libata-scsi.c |    6 ++++++
 include/linux/libata.h    |    4 ++--
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 582e44d..a441c75 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -89,7 +89,7 @@ int libata_fua = 0;
 module_param_named(fua, libata_fua, int, 0444);
 MODULE_PARM_DESC(fua, "FUA support (0=off, 1=on)");
 
-static int ata_probe_timeout = ATA_TMOUT_INTERNAL / HZ;
+static int ata_probe_timeout = ATA_TMOUT_CMD / HZ;
 module_param(ata_probe_timeout, int, 0444);
 MODULE_PARM_DESC(ata_probe_timeout, "Set ATA probing timeout (seconds)");
 
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 0009818..dc2157c 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -903,6 +903,12 @@ static void ata_scsi_dev_config(struct scsi_device *sdev,
 		depth = min(ATA_MAX_QUEUE - 1, depth);
 		scsi_adjust_queue_depth(sdev, MSG_SIMPLE_TAG, depth);
 	}
+
+	/* setup command timeout */
+	if (dev->class == ATA_DEV_ATA)
+		sdev->timeout = ATA_TMOUT_CMD;
+	else
+		sdev->timeout = ATAPI_TMOUT_CMD;
 }
 
 /**
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 305e95f..4c3ed59 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -214,8 +214,8 @@ enum {
 	/* various lengths of time */
 	ATA_TMOUT_BOOT		= 30 * HZ,	/* heuristic */
 	ATA_TMOUT_BOOT_QUICK	= 7 * HZ,	/* heuristic */
-	ATA_TMOUT_INTERNAL	= 30 * HZ,
-	ATA_TMOUT_INTERNAL_QUICK = 5 * HZ,
+	ATA_TMOUT_CMD		= 7 * HZ,	/* de facto ATA cmd timeout */
+	ATAPI_TMOUT_CMD		= 30 * HZ,
 
 	/* ATA bus states */
 	BUS_UNKNOWN		= 0,
-- 
1.4.4.4

