From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 6/6] libata: reorganize ata_bus_probe()
Date: Tue, 21 Feb 2006 02:12:11 +0900
Message-ID: <11404555311603-git-send-email-htejun@gmail.com>
References: <11404555312141-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.183]:38801 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161053AbWBTRMS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Feb 2006 12:12:18 -0500
Received: by pproxy.gmail.com with SMTP id x31so1152266pye
        for <linux-ide@vger.kernel.org>; Mon, 20 Feb 2006 09:12:17 -0800 (PST)
In-Reply-To: <11404555312141-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Now that reset and configure are converted such that they don't modify
or disable libata core data structures, reorganize ata_bus_probe() to
reflect this change.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   46 ++++++++++++++++++++++++--------------------
 1 files changed, 25 insertions(+), 21 deletions(-)

d695a2e18b85bf07ceb47bb200bea3461f6e02ea
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 5405463..1bd7ead 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1207,35 +1207,40 @@ err_out_nosup:
 
 static int ata_bus_probe(struct ata_port *ap)
 {
-	unsigned int i, found = 0;
+	unsigned int classes[ATA_MAX_DEVICES];
+	unsigned int i, rc, found = 0;
 
-	if (ap->ops->probe_reset) {
-		unsigned int classes[ATA_MAX_DEVICES];
-		int rc;
-
-		ata_port_probe(ap);
+	ata_port_probe(ap);
 
+	/* reset */
+	if (ap->ops->probe_reset) {
 		rc = ap->ops->probe_reset(ap, classes);
-		if (rc == 0) {
-			for (i = 0; i < ATA_MAX_DEVICES; i++) {
-				if (classes[i] == ATA_DEV_UNKNOWN)
-					classes[i] = ATA_DEV_NONE;
-				ap->device[i].class = classes[i];
-			}
-		} else {
-			printk(KERN_ERR "ata%u: probe reset failed, "
-			       "disabling port\n", ap->id);
-			ata_port_disable(ap);
+		if (rc) {
+			printk("ata%u: reset failed (errno=%d)\n", ap->id, rc);
+			return rc;
 		}
-	} else
+
+		for (i = 0; i < ATA_MAX_DEVICES; i++)
+			if (classes[i] == ATA_DEV_UNKNOWN)
+				classes[i] = ATA_DEV_NONE;
+	} else {
 		ap->ops->phy_reset(ap);
 
-	if (ap->flags & ATA_FLAG_PORT_DISABLED)
-		goto err_out;
+		for (i = 0; i < ATA_MAX_DEVICES; i++) {
+			if (!(ap->flags & ATA_FLAG_PORT_DISABLED))
+				classes[i] = ap->device[i].class;
+			else
+				ap->device[i].class = ATA_DEV_UNKNOWN;
+		}
+		ata_port_probe(ap);
+	}
 
+	/* read IDENTIFY page and configure devices */
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		struct ata_device *dev = &ap->device[i];
 
+		dev->class = classes[i];
+
 		if (!ata_dev_present(dev))
 			continue;
 
@@ -1253,7 +1258,7 @@ static int ata_bus_probe(struct ata_port
 		found = 1;
 	}
 
-	if ((!found) || (ap->flags & ATA_FLAG_PORT_DISABLED))
+	if (!found)
 		goto err_out_disable;
 
 	ata_set_mode(ap);
@@ -1264,7 +1269,6 @@ static int ata_bus_probe(struct ata_port
 
 err_out_disable:
 	ap->ops->port_disable(ap);
-err_out:
 	return -1;
 }
 
-- 
1.1.5


