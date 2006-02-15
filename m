From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 7/7] libata: reorganize ata_bus_probe()
Date: Wed, 15 Feb 2006 18:24:09 +0900
Message-ID: <113999544950-git-send-email-htejun@gmail.com>
References: <11399954493467-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.177]:37558 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1945909AbWBOJYT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Feb 2006 04:24:19 -0500
Received: by pproxy.gmail.com with SMTP id f25so1427413pyf
        for <linux-ide@vger.kernel.org>; Wed, 15 Feb 2006 01:24:19 -0800 (PST)
In-Reply-To: <11399954493467-git-send-email-htejun@gmail.com>
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

04a9356ddbbfafba7ec9b6b71db30ccad2190e02
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 761186d..8c0d48f 100644
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
 
@@ -1252,7 +1257,7 @@ static int ata_bus_probe(struct ata_port
 		found = 1;
 	}
 
-	if ((!found) || (ap->flags & ATA_FLAG_PORT_DISABLED))
+	if (!found)
 		goto err_out_disable;
 
 	ata_set_mode(ap);
@@ -1263,7 +1268,6 @@ static int ata_bus_probe(struct ata_port
 
 err_out_disable:
 	ap->ops->port_disable(ap);
-err_out:
 	return -1;
 }
 
-- 
1.1.5


