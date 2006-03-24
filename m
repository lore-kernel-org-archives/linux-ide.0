From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/5] libata: make ata_set_mode() responsible for failure handling
Date: Fri, 24 Mar 2006 15:25:31 +0900
Message-ID: <1143181531257-git-send-email-htejun@gmail.com>
References: <11431815303216-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.194]:35785 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1423180AbWCXGZg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Mar 2006 01:25:36 -0500
Received: by zproxy.gmail.com with SMTP id o37so734492nzf
        for <linux-ide@vger.kernel.org>; Thu, 23 Mar 2006 22:25:36 -0800 (PST)
In-Reply-To: <11431815303216-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Make ata_set_mode() responsible for determining whether to take port
or device offline on failure.  ata_dev_set_xfermode() and
ata_dev_set_mode() indicate error to the caller instead of disabling
port directly on failure.  Also, for consistency, ata_dev_present()
check is done in ata_set_mode() instead of ata_dev_set_mode().

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   56 ++++++++++++++++++++++++++++----------------
 1 files changed, 36 insertions(+), 20 deletions(-)

efdc8a26c53fce5e7ca529a0758e565679947366
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index b08e79f..6970f68 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -64,7 +64,8 @@
 static unsigned int ata_dev_init_params(struct ata_port *ap,
 					struct ata_device *dev);
 static void ata_set_mode(struct ata_port *ap);
-static void ata_dev_set_xfermode(struct ata_port *ap, struct ata_device *dev);
+static unsigned int ata_dev_set_xfermode(struct ata_port *ap,
+					 struct ata_device *dev);
 static void ata_dev_xfermask(struct ata_port *ap, struct ata_device *dev);
 
 static unsigned int ata_unique_id = 1;
@@ -1742,20 +1743,28 @@ int ata_timing_compute(struct ata_device
 	return 0;
 }
 
-static void ata_dev_set_mode(struct ata_port *ap, struct ata_device *dev)
+static int ata_dev_set_mode(struct ata_port *ap, struct ata_device *dev)
 {
-	if (!ata_dev_present(dev) || (ap->flags & ATA_FLAG_PORT_DISABLED))
-		return;
+	unsigned int err_mask;
+	int rc;
 
 	if (dev->xfer_shift == ATA_SHIFT_PIO)
 		dev->flags |= ATA_DFLAG_PIO;
 
-	ata_dev_set_xfermode(ap, dev);
+	err_mask = ata_dev_set_xfermode(ap, dev);
+	if (err_mask) {
+		printk(KERN_ERR
+		       "ata%u: failed to set xfermode (err_mask=0x%x)\n",
+		       ap->id, err_mask);
+		return -EIO;
+	}
 
-	if (ata_dev_revalidate(ap, dev, 0)) {
-		printk(KERN_ERR "ata%u: failed to revalidate after set "
-		       "xfermode, disabled\n", ap->id);
-		ata_port_disable(ap);
+	rc = ata_dev_revalidate(ap, dev, 0);
+	if (rc) {
+		printk(KERN_ERR
+		       "ata%u: failed to revalidate after set xfermode\n",
+		       ap->id);
+		return rc;
 	}
 
 	DPRINTK("xfer_shift=%u, xfer_mode=0x%x\n",
@@ -1764,6 +1773,7 @@ static void ata_dev_set_mode(struct ata_
 	printk(KERN_INFO "ata%u: dev %u configured for %s\n",
 	       ap->id, dev->devno,
 	       ata_mode_string(ata_xfer_mode2mask(dev->xfer_mode)));
+	return 0;
 }
 
 static int ata_host_set_pio(struct ata_port *ap)
@@ -1847,11 +1857,15 @@ static void ata_set_mode(struct ata_port
 	ata_host_set_dma(ap);
 
 	/* step 4: update devices' xfer mode */
-	for (i = 0; i < ATA_MAX_DEVICES; i++)
-		ata_dev_set_mode(ap, &ap->device[i]);
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		struct ata_device *dev = &ap->device[i];
 
-	if (ap->flags & ATA_FLAG_PORT_DISABLED)
-		return;
+		if (!ata_dev_present(dev))
+			continue;
+
+		if (ata_dev_set_mode(ap, dev))
+			goto err_out;
+	}
 
 	if (ap->ops->post_set_mode)
 		ap->ops->post_set_mode(ap);
@@ -2724,11 +2738,16 @@ static void ata_dev_xfermask(struct ata_
  *
  *	LOCKING:
  *	PCI/etc. bus probe sem.
+ *
+ *	RETURNS:
+ *	0 on success, AC_ERR_* mask otherwise.
  */
 
-static void ata_dev_set_xfermode(struct ata_port *ap, struct ata_device *dev)
+static unsigned int ata_dev_set_xfermode(struct ata_port *ap,
+					 struct ata_device *dev)
 {
 	struct ata_taskfile tf;
+	unsigned int err_mask;
 
 	/* set up set-features taskfile */
 	DPRINTK("set features - xfer mode\n");
@@ -2740,13 +2759,10 @@ static void ata_dev_set_xfermode(struct 
 	tf.protocol = ATA_PROT_NODATA;
 	tf.nsect = dev->xfer_mode;
 
-	if (ata_exec_internal(ap, dev, &tf, DMA_NONE, NULL, 0)) {
-		printk(KERN_ERR "ata%u: failed to set xfermode, disabled\n",
-		       ap->id);
-		ata_port_disable(ap);
-	}
+	err_mask = ata_exec_internal(ap, dev, &tf, DMA_NONE, NULL, 0);
 
-	DPRINTK("EXIT\n");
+	DPRINTK("EXIT, err_mask=%x\n", err_mask);
+	return err_mask;
 }
 
 /**
-- 
1.2.4


