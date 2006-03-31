From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 08/15] libata: don't disable devices from ata_set_mode()
Date: Sat, 1 Apr 2006 01:38:18 +0900
Message-ID: <11438230982787-git-send-email-htejun@gmail.com>
References: <1143823097579-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.193]:11491 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751412AbWCaQi2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 Mar 2006 11:38:28 -0500
Received: by zproxy.gmail.com with SMTP id o37so955009nzf
        for <linux-ide@vger.kernel.org>; Fri, 31 Mar 2006 08:38:28 -0800 (PST)
In-Reply-To: <1143823097579-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

When ata_set_mode() fails on a device, make ata_set_mode() return
error code and pointer to the device instead of disabling it directly.
This gives more control to higher level driving logic.

This patch does not change the end result (configured transfer mode)
although it may make libata repeat mode configuration to the peer of a
failing device.  Later ata_bus_probe() rewrite will make full use of
this change.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   66 +++++++++++++++++++++++++++-----------------
 1 files changed, 40 insertions(+), 26 deletions(-)

0a8249272a7bb4114c8c535ad9c09f6c98fbccf2
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index f04561a..061b0b6 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -65,7 +65,7 @@ static unsigned int ata_dev_init_params(
 					struct ata_device *dev,
 					u16 heads,
 					u16 sectors);
-static void ata_set_mode(struct ata_port *ap);
+static int ata_set_mode(struct ata_port *ap, struct ata_device **r_failed_dev);
 static unsigned int ata_dev_set_xfermode(struct ata_port *ap,
 					 struct ata_device *dev);
 static void ata_dev_xfermask(struct ata_port *ap, struct ata_device *dev);
@@ -1368,6 +1368,7 @@ static int ata_bus_probe(struct ata_port
 {
 	unsigned int classes[ATA_MAX_DEVICES];
 	int i, rc, found = 0;
+	struct ata_device *dev;
 
 	ata_port_probe(ap);
 
@@ -1397,8 +1398,7 @@ static int ata_bus_probe(struct ata_port
 
 	/* read IDENTIFY page and configure devices */
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		struct ata_device *dev = &ap->device[i];
-
+		dev = &ap->device[i];
 		dev->class = classes[i];
 
 		if (!ata_dev_enabled(dev))
@@ -1418,20 +1418,26 @@ static int ata_bus_probe(struct ata_port
 		found = 1;
 	}
 
-	if (!found)
-		goto err_out_disable;
-
-	if (ap->ops->set_mode)
-		ap->ops->set_mode(ap);
-	else
-		ata_set_mode(ap);
-
-	if (ap->flags & ATA_FLAG_PORT_DISABLED)
-		goto err_out_disable;
+	/* configure transfer mode */
+	if (ap->ops->set_mode) {
+		/* FIXME: make ->set_mode handle no device case and
+		 * return error code and failing device on failure as
+		 * ata_set_mode() does.
+		 */
+		if (found)
+			ap->ops->set_mode(ap);
+		rc = 0;
+	} else {
+		while (ata_set_mode(ap, &dev))
+			ata_dev_disable(ap, dev);
+	}
 
-	return 0;
+	for (i = 0; i < ATA_MAX_DEVICES; i++)
+		if (ata_dev_enabled(&ap->device[i]))
+			return 0;
 
-err_out_disable:
+	/* no device present, disable port */
+	ata_port_disable(ap);
 	ap->ops->port_disable(ap);
 	return -ENODEV;
 }
@@ -1774,16 +1780,22 @@ static int ata_dev_set_mode(struct ata_p
 /**
  *	ata_set_mode - Program timings and issue SET FEATURES - XFER
  *	@ap: port on which timings will be programmed
+ *	@r_failed_dev: out paramter for failed device
  *
- *	Set ATA device disk transfer mode (PIO3, UDMA6, etc.).
+ *	Set ATA device disk transfer mode (PIO3, UDMA6, etc.).  If
+ *	ata_set_mode() fails, pointer to the failing device is
+ *	returned in @r_failed_dev.
  *
  *	LOCKING:
  *	PCI/etc. bus probe sem.
+ *
+ *	RETURNS:
+ *	0 on success, negative errno otherwise
  */
-static void ata_set_mode(struct ata_port *ap)
+static int ata_set_mode(struct ata_port *ap, struct ata_device **r_failed_dev)
 {
 	struct ata_device *dev;
-	int i, rc, used_dma = 0, found = 0;
+	int i, rc = 0, used_dma = 0, found = 0;
 
 	/* step 1: calculate xfer_mask */
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
@@ -1806,7 +1818,7 @@ static void ata_set_mode(struct ata_port
 			used_dma = 1;
 	}
 	if (!found)
-		return;
+		goto out;
 
 	/* step 2: always set host PIO timings */
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
@@ -1818,7 +1830,7 @@ static void ata_set_mode(struct ata_port
 			printk(KERN_WARNING "ata%u: dev %u no PIO support\n",
 			       ap->id, dev->devno);
 			rc = -EINVAL;
-			goto err_out;
+			goto out;
 		}
 
 		dev->xfer_mode = dev->pio_mode;
@@ -1849,7 +1861,7 @@ static void ata_set_mode(struct ata_port
 
 		rc = ata_dev_set_mode(ap, dev);
 		if (rc)
-			goto err_out;
+			goto out;
 	}
 
 	/* Record simplex status. If we selected DMA then the other
@@ -1862,10 +1874,10 @@ static void ata_set_mode(struct ata_port
 	if (ap->ops->post_set_mode)
 		ap->ops->post_set_mode(ap);
 
-	return;
-
-err_out:
-	ata_port_disable(ap);
+ out:
+	if (rc)
+		*r_failed_dev = dev;
+	return rc;
 }
 
 /**
@@ -4278,8 +4290,10 @@ static int ata_start_drive(struct ata_po
 int ata_device_resume(struct ata_port *ap, struct ata_device *dev)
 {
 	if (ap->flags & ATA_FLAG_SUSPENDED) {
+		struct ata_device *failed_dev;
 		ap->flags &= ~ATA_FLAG_SUSPENDED;
-		ata_set_mode(ap);
+		while (ata_set_mode(ap, &failed_dev))
+			ata_dev_disable(ap, failed_dev);
 	}
 	if (!ata_dev_enabled(dev))
 		return 0;
-- 
1.2.4


