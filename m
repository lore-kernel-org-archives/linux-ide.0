From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: fix class handling in ata_bus_probe()
Date: Mon, 13 Mar 2006 01:57:01 +0900
Message-ID: <20060312165701.GA9051@htj.dyndns.org>
References: <44144172.9040304@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.197]:13763 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751507AbWCLQ5H (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Mar 2006 11:57:07 -0500
Received: by wproxy.gmail.com with SMTP id 57so454572wri
        for <linux-ide@vger.kernel.org>; Sun, 12 Mar 2006 08:57:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <44144172.9040304@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

ata_bus_probe() didn't set classes[] properly for port disabled case
of ->phy_reset() compatibility path.  This patch moves classes[]
initialization and normalization out of ->probe_reset block such that
it applies to both ->probe_reset and ->phy_reset paths.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

Jeff, the sata_nv case is similar bug as what Jiri reported, except
that this one is affecting ->phy_reset path.

This patch should fix sata_nv.  For sata_mv, I have no idea at all.

 libata-core.c |   24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 42d43b5..c17df3f 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1344,32 +1344,30 @@ static int ata_bus_probe(struct ata_port
 
 	ata_port_probe(ap);
 
-	/* reset */
-	if (ap->ops->probe_reset) {
-		for (i = 0; i < ATA_MAX_DEVICES; i++)
-			classes[i] = ATA_DEV_UNKNOWN;
+	/* reset and determine device classes */
+	for (i = 0; i < ATA_MAX_DEVICES; i++)
+		classes[i] = ATA_DEV_UNKNOWN;
 
+	if (ap->ops->probe_reset) {
 		rc = ap->ops->probe_reset(ap, classes);
 		if (rc) {
 			printk("ata%u: reset failed (errno=%d)\n", ap->id, rc);
 			return rc;
 		}
-
-		for (i = 0; i < ATA_MAX_DEVICES; i++)
-			if (classes[i] == ATA_DEV_UNKNOWN)
-				classes[i] = ATA_DEV_NONE;
 	} else {
 		ap->ops->phy_reset(ap);
 
-		for (i = 0; i < ATA_MAX_DEVICES; i++) {
-			if (!(ap->flags & ATA_FLAG_PORT_DISABLED))
+		if (!(ap->flags & ATA_FLAG_PORT_DISABLED))
+			for (i = 0; i < ATA_MAX_DEVICES; i++)
 				classes[i] = ap->device[i].class;
-			else
-				ap->device[i].class = ATA_DEV_UNKNOWN;
-		}
+
 		ata_port_probe(ap);
 	}
 
+	for (i = 0; i < ATA_MAX_DEVICES; i++)
+		if (classes[i] == ATA_DEV_UNKNOWN)
+			classes[i] = ATA_DEV_NONE;
+
 	/* read IDENTIFY page and configure devices */
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		struct ata_device *dev = &ap->device[i];
