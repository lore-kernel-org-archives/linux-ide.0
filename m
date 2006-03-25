From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/2] libata: add @disable_on_err argument to ata_set_mode()
Date: Sat, 25 Mar 2006 10:14:32 +0900
Message-ID: <20060325011432.GE5288@htj.dyndns.org>
References: <11431815313764-git-send-email-htejun@gmail.com> <44240A67.7030001@pobox.com> <1143215493.18986.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.192]:65240 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751352AbWCYBOj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Mar 2006 20:14:39 -0500
Received: by zproxy.gmail.com with SMTP id o37so976731nzf
        for <linux-ide@vger.kernel.org>; Fri, 24 Mar 2006 17:14:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1143215493.18986.11.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

ata_set_mode() used to disable whole port on failure.  This patch adds
@disable_on_err which makes ata_set_mode() disable failing devices
when non-zero, and simply return when zero.  Due to the port-wide
characteristic of ATA xfer mode configuration, ata_mode_set() is the
final place to determine device offlining; thus, the @disable_on_err
mechanism to tell it which action to take on failure.

With this patch, only failing devices are disabled not the whole port.
Transfer mode configuration must consider all devices on the port
regardless of failure status; otherwise, device selection timing can
be violoated resulting in malfunction.  This patch makes
ata_dev_xfermask() consider disabled but present devices such that
device timing selection timing is honored.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

As said in the above comment, this patch makes sure that present but
disabled devices are taken into account when determining transfer
mode.  If IDENTIFY data is present, it is used; otherwise, PIO0 is
forced.  I think this should be enough.

Thanks.

 libata-core.c |   79 ++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 50 insertions(+), 29 deletions(-)

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 3e0c4b1..121c201 100644
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
@@ -1394,7 +1394,7 @@ static int ata_bus_probe(struct ata_port
 
 		WARN_ON(dev->id != NULL);
 		if (ata_dev_read_id(ap, dev, &dev->class, 1, &dev->id)) {
-			dev->class = ATA_DEV_NONE;
+			ata_dev_disable(ap, dev);
 			continue;
 		}
 
@@ -1406,16 +1406,16 @@ static int ata_bus_probe(struct ata_port
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
@@ -1762,7 +1762,7 @@ static int ata_dev_set_mode(struct ata_p
 	return 0;
 }
 
-static int ata_host_set_pio(struct ata_port *ap)
+static int ata_host_set_pio(struct ata_port *ap, int disable_on_err)
 {
 	int i;
 
@@ -1773,8 +1773,13 @@ static int ata_host_set_pio(struct ata_p
 			continue;
 
 		if (!dev->pio_mode) {
-			printk(KERN_WARNING "ata%u: no PIO support for device %d.\n", ap->id, i);
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
@@ -1806,13 +1811,19 @@ static void ata_host_set_dma(struct ata_
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
 
@@ -1835,9 +1846,9 @@ static void ata_set_mode(struct ata_port
 	}
 
 	/* step 2: always set host PIO timings */
-	rc = ata_host_set_pio(ap);
+	rc = ata_host_set_pio(ap, disable_on_err);
 	if (rc)
-		goto err_out;
+		return rc;
 
 	/* step 3: set host DMA timings */
 	ata_host_set_dma(ap);
@@ -1849,17 +1860,19 @@ static void ata_set_mode(struct ata_port
 		if (!ata_dev_enabled(dev))
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
@@ -2647,13 +2660,21 @@ static void ata_dev_xfermask(struct ata_
 	/* use port-wide xfermask for now */
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		struct ata_device *d = &ap->device[i];
-		if (!ata_dev_enabled(d))
+		if (!ata_dev_present(d))
 			continue;
 		xfer_mask &= ata_pack_xfermask(d->pio_mask, d->mwdma_mask,
 					       d->udma_mask);
-		xfer_mask &= ata_id_xfermask(d->id);
-		if (ata_dma_blacklisted(d))
-			xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
+		if (d->id) {
+			xfer_mask &= ata_id_xfermask(d->id);
+			if (ata_dma_blacklisted(d))
+				xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
+		} else {
+			/* We have no idea what this device is capable
+			 * of.  Force PIO0 to avoid violating address
+			 * setup timing.
+			 */
+			xfer_mask &= ata_pack_xfermask(1, UINT_MAX, UINT_MAX);
+		}
 	}
 
 	if (ata_dma_blacklisted(dev))
@@ -4254,7 +4275,7 @@ int ata_device_resume(struct ata_port *a
 {
 	if (ap->flags & ATA_FLAG_SUSPENDED) {
 		ap->flags &= ~ATA_FLAG_SUSPENDED;
-		ata_set_mode(ap);
+		ata_set_mode(ap, 1);
 	}
 	if (!ata_dev_enabled(dev))
 		return 0;
