From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 12/16] libata: reorganize ata_bus_probe()
Date: Fri, 27 Jan 2006 00:39:11 +0900
Message-ID: <11382899511457-git-send-email-htejun@gmail.com>
References: <1138289951261-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.197]:61520 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964776AbWAZPj3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jan 2006 10:39:29 -0500
Received: by zproxy.gmail.com with SMTP id 34so372373nzf
        for <linux-ide@vger.kernel.org>; Thu, 26 Jan 2006 07:39:28 -0800 (PST)
In-Reply-To: <1138289951261-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk
Cc: Tejun Heo <htejun@gmail.com>

Now that reset and configure are converted such that they don't modify
or disable libata core data structures, reorganize ata_bus_probe() to
reflect this change.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   39 +++++++++++++++++++++------------------
 1 files changed, 21 insertions(+), 18 deletions(-)

20afcd17a5a534cf8ca54b381822368d8eb69ba2
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 7bc3a59..ab6b38c 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1587,32 +1587,36 @@ err_out_nosup:
 
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
-			for (i = 0; i < ATA_MAX_DEVICES; i++)
-				ap->device[i].class = classes[i];
-		} else {
-			printk(KERN_ERR "ata%u: probe reset failed, "
-			       "disabling port\n", ap->id);
-			ata_port_disable(ap);
+		if (rc) {
+			printk("ata%u: reset failed (errno=%d)\n", ap->id, rc);
+			return rc;
 		}
-	} else
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
 
@@ -1629,7 +1633,7 @@ static int ata_bus_probe(struct ata_port
 		found = 1;
 	}
 
-	if ((!found) || (ap->flags & ATA_FLAG_PORT_DISABLED))
+	if (!found)
 		goto err_out_disable;
 
 	ata_set_mode(ap);
@@ -1640,7 +1644,6 @@ static int ata_bus_probe(struct ata_port
 
 err_out_disable:
 	ap->ops->port_disable(ap);
-err_out:
 	return -1;
 }
 
-- 
1.1.3


