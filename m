From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/4] libata: add @disable_on_err argument to ata_set_mode()
Date: Mon, 13 Mar 2006 17:12:33 +0900
Message-ID: <11422375531192-git-send-email-htejun@gmail.com>
References: <11422373402858-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.192]:23539 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932348AbWCMIMk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Mar 2006 03:12:40 -0500
Received: by wproxy.gmail.com with SMTP id 69so1342043wri
        for <linux-ide@vger.kernel.org>; Mon, 13 Mar 2006 00:12:39 -0800 (PST)
In-Reply-To: <11422373402858-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

ata_set_mode() used to disable whole port on failure.  This patch adds
@disable_on_err which makes ata_set_mode() disable failing devices
when non-zero, and simply return when zero.  Due to the port-wide
characteristic of ATA xfer mode configuration, ata_mode_set() is the
final place to determine device offlining; thus, the @disable_on_err
mechanism to tell it which action to take on failure.

Now port is disabled only if all devices on the port is disabled.
This behavior change is intentional.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   61 +++++++++++++++++++++++++++-----------------
 1 files changed, 37 insertions(+), 24 deletions(-)

4eb4d225ccfc6b5401b338c92c142f30b761db2e
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 6826181..f620595 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -63,7 +63,7 @@
 
 static unsigned int ata_dev_init_params(struct ata_port *ap,
 					struct ata_device *dev);
-static void ata_set_mode(struct ata_port *ap);
+static int ata_set_mode(struct ata_port *ap, int disable_on_err);
 static unsigned int ata_dev_set_xfermode(struct ata_port *ap,
 					 struct ata_device *dev);
 static void ata_dev_xfermask(struct ata_port *ap, struct ata_device *dev);
@@ -1449,16 +1449,16 @@ static int ata_bus_probe(struct ata_port
 		found = 1;
 	}
 
-	if (!found)
-		goto err_out_disable;
-
-	ata_set_mode(ap);
-	if (ap->flags & ATA_FLAG_PORT_DISABLED)
-		goto err_out_disable;
-
-	return 0;
+	/* configure transfer mode */
+	if (found) {
+		ata_set_mode(ap, 1);
+		for (i = 0; i < ATA_MAX_DEVICES; i++)
+			if (ata_dev_present(&ap->device[i]))
+				return 0;
+	}
 
-err_out_disable:
+	/* no device present, disable port */
+	ata_port_disable(ap);
 	ap->ops->port_disable(ap);
 	return -1;
 }
@@ -1788,7 +1788,7 @@ static int ata_dev_set_mode(struct ata_p
 	return 0;
 }
 
-static int ata_host_set_pio(struct ata_port *ap)
+static int ata_host_set_pio(struct ata_port *ap, int disable_on_err)
 {
 	int i;
 
@@ -1799,8 +1799,13 @@ static int ata_host_set_pio(struct ata_p
 			continue;
 
 		if (!dev->pio_mode) {
-			printk(KERN_WARNING "ata%u: no PIO support\n", ap->id);
-			return -1;
+			printk(KERN_WARNING "ata%u: dev %u no PIO support\n",
+			       ap->id, dev->devno);
+			if (disable_on_err) {
+				ata_dev_disable(ap, dev);
+				continue;
+			} else
+				return -EINVAL;
 		}
 
 		dev->xfer_mode = dev->pio_mode;
@@ -1832,13 +1837,19 @@ static void ata_host_set_dma(struct ata_
 /**
  *	ata_set_mode - Program timings and issue SET FEATURES - XFER
  *	@ap: port on which timings will be programmed
+ *	@disable_on_err: disable device on error
  *
- *	Set ATA device disk transfer mode (PIO3, UDMA6, etc.).
+ *	Set ATA device disk transfer mode (PIO3, UDMA6, etc.).  If
+ *	@disable_on_err is non-zero, devices which fail to configure
+ *	are taken offline and this function always succeeds.
  *
  *	LOCKING:
  *	PCI/etc. bus probe sem.
+ *
+ *	RETURNS:
+ *	0 on success, negative errno otherwise
  */
-static void ata_set_mode(struct ata_port *ap)
+static int ata_set_mode(struct ata_port *ap, int disable_on_err)
 {
 	int i, rc;
 
@@ -1861,9 +1872,9 @@ static void ata_set_mode(struct ata_port
 	}
 
 	/* step 2: always set host PIO timings */
-	rc = ata_host_set_pio(ap);
+	rc = ata_host_set_pio(ap, disable_on_err);
 	if (rc)
-		goto err_out;
+		return rc;
 
 	/* step 3: set host DMA timings */
 	ata_host_set_dma(ap);
@@ -1875,17 +1886,19 @@ static void ata_set_mode(struct ata_port
 		if (!ata_dev_present(dev))
 			continue;
 
-		if (ata_dev_set_mode(ap, dev))
-			goto err_out;
+		rc = ata_dev_set_mode(ap, dev);
+		if (rc) {
+			if (disable_on_err)
+				ata_dev_disable(ap, dev);
+			else
+				return rc;
+		}
 	}
 
 	if (ap->ops->post_set_mode)
 		ap->ops->post_set_mode(ap);
 
-	return;
-
-err_out:
-	ata_port_disable(ap);
+	return 0;
 }
 
 /**
@@ -4526,7 +4539,7 @@ int ata_device_resume(struct ata_port *a
 {
 	if (ap->flags & ATA_FLAG_SUSPENDED) {
 		ap->flags &= ~ATA_FLAG_SUSPENDED;
-		ata_set_mode(ap);
+		ata_set_mode(ap, 1);
 	}
 	if (!ata_dev_present(dev))
 		return 0;
-- 
1.2.4


