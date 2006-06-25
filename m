From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: cosmetic updates
Date: Sun, 25 Jun 2006 20:00:35 +0900
Message-ID: <20060625110035.GA29064@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:62453 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932349AbWFYLAX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 25 Jun 2006 07:00:23 -0400
Received: by py-out-1112.google.com with SMTP id i49so1273259pyi
        for <linux-ide@vger.kernel.org>; Sun, 25 Jun 2006 04:00:23 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, bbpetkov@yahoo.de

Cosmetic updates in libata-core.c.

* trim trailing whitespaces
* break lines which are over 80 column
* kill unnecessary braces
* make indentation consistent

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   61 +++++++++++++++++++++++---------------------
 1 files changed, 32 insertions(+), 29 deletions(-)

72d73923dc8b7bf9f952d3be8ad03fce3f48d857
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 6c66877..d6f849c 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -777,11 +777,9 @@ void ata_std_dev_select (struct ata_port
 void ata_dev_select(struct ata_port *ap, unsigned int device,
 			   unsigned int wait, unsigned int can_sleep)
 {
-	if (ata_msg_probe(ap)) {
+	if (ata_msg_probe(ap))
 		ata_port_printk(ap, KERN_INFO, "ata_dev_select: ENTER, ata%u: "
-				"device %u, wait %u\n",
-				ap->id, device, wait);
-	}
+				"device %u, wait %u\n", ap->id, device, wait);
 
 	if (wait)
 		ata_wait_idle(ap);
@@ -950,7 +948,8 @@ void ata_port_flush_task(struct ata_port
 	 */
 	if (!cancel_delayed_work(&ap->port_task)) {
 		if (ata_msg_ctl(ap))
-			ata_port_printk(ap, KERN_DEBUG, "%s: flush #2\n", __FUNCTION__);
+			ata_port_printk(ap, KERN_DEBUG, "%s: flush #2\n",
+					__FUNCTION__);
 		flush_workqueue(ata_wq);
 	}
 
@@ -1081,7 +1080,7 @@ unsigned ata_exec_internal(struct ata_de
 
 			if (ata_msg_warn(ap))
 				ata_dev_printk(dev, KERN_WARNING,
-				       "qc timeout (cmd 0x%x)\n", command);
+					"qc timeout (cmd 0x%x)\n", command);
 		}
 
 		spin_unlock_irqrestore(ap->lock, flags);
@@ -1093,9 +1092,9 @@ unsigned ata_exec_internal(struct ata_de
 
 	if (qc->flags & ATA_QCFLAG_FAILED && !qc->err_mask) {
 		if (ata_msg_warn(ap))
-			ata_dev_printk(dev, KERN_WARNING, 
+			ata_dev_printk(dev, KERN_WARNING,
 				"zero err_mask for failed "
-			       "internal command, assuming AC_ERR_OTHER\n");
+				"internal command, assuming AC_ERR_OTHER\n");
 		qc->err_mask |= AC_ERR_OTHER;
 	}
 
@@ -1193,8 +1192,8 @@ int ata_dev_read_id(struct ata_device *d
 	int rc;
 
 	if (ata_msg_ctl(ap))
-		ata_dev_printk(dev, KERN_DEBUG, "%s: ENTER, host %u, dev %u\n", 
-				__FUNCTION__, ap->id, dev->devno);
+		ata_dev_printk(dev, KERN_DEBUG, "%s: ENTER, host %u, dev %u\n",
+			       __FUNCTION__, ap->id, dev->devno);
 
 	ata_dev_select(ap, dev->devno, 1, 1); /* select device 0/1 */
 
@@ -1263,9 +1262,9 @@ int ata_dev_read_id(struct ata_device *d
 	return 0;
 
  err_out:
-	if (ata_msg_warn(ap)) 
+	if (ata_msg_warn(ap))
 		ata_dev_printk(dev, KERN_WARNING, "failed to IDENTIFY "
-		       "(%s, err_mask=0x%x)\n", reason, err_mask);
+			       "(%s, err_mask=0x%x)\n", reason, err_mask);
 	return rc;
 }
 
@@ -1318,19 +1317,21 @@ int ata_dev_configure(struct ata_device 
 	int i, rc;
 
 	if (!ata_dev_enabled(dev) && ata_msg_info(ap)) {
-		ata_dev_printk(dev, KERN_INFO, "%s: ENTER/EXIT (host %u, dev %u) -- nodev\n",
-			__FUNCTION__, ap->id, dev->devno);
+		ata_dev_printk(dev, KERN_INFO,
+			       "%s: ENTER/EXIT (host %u, dev %u) -- nodev\n",
+			       __FUNCTION__, ap->id, dev->devno);
 		return 0;
 	}
 
 	if (ata_msg_probe(ap))
-		ata_dev_printk(dev, KERN_DEBUG, "%s: ENTER, host %u, dev %u\n", 
-			__FUNCTION__, ap->id, dev->devno);
+		ata_dev_printk(dev, KERN_DEBUG, "%s: ENTER, host %u, dev %u\n",
+			       __FUNCTION__, ap->id, dev->devno);
 
 	/* print device capabilities */
 	if (ata_msg_probe(ap))
-		ata_dev_printk(dev, KERN_DEBUG, "%s: cfg 49:%04x 82:%04x 83:%04x "
-			       "84:%04x 85:%04x 86:%04x 87:%04x 88:%04x\n",
+		ata_dev_printk(dev, KERN_DEBUG,
+			       "%s: cfg 49:%04x 82:%04x 83:%04x 84:%04x "
+			       "85:%04x 86:%04x 87:%04x 88:%04x\n",
 			       __FUNCTION__,
 			       id[49], id[82], id[83], id[84],
 			       id[85], id[86], id[87], id[88]);
@@ -1402,14 +1403,16 @@ int ata_dev_configure(struct ata_device 
 					ata_id_major_version(id),
 					ata_mode_string(xfer_mask),
 					(unsigned long long)dev->n_sectors,
-					dev->cylinders, dev->heads, dev->sectors);
+					dev->cylinders, dev->heads,
+					dev->sectors);
 		}
 
 		if (dev->id[59] & 0x100) {
 			dev->multi_count = dev->id[59] & 0xff;
 			if (ata_msg_info(ap))
-				ata_dev_printk(dev, KERN_INFO, "ata%u: dev %u multi count %u\n",
-				ap->id, dev->devno, dev->multi_count);
+				ata_dev_printk(dev, KERN_INFO,
+					"ata%u: dev %u multi count %u\n",
+					ap->id, dev->devno, dev->multi_count);
 		}
 
 		dev->cdb_len = 16;
@@ -1422,8 +1425,8 @@ int ata_dev_configure(struct ata_device 
 		rc = atapi_cdb_len(id);
 		if ((rc < 12) || (rc > ATAPI_CDB_LEN)) {
 			if (ata_msg_warn(ap))
-				ata_dev_printk(dev, KERN_WARNING, 
-					"unsupported CDB len\n");
+				ata_dev_printk(dev, KERN_WARNING,
+					       "unsupported CDB len\n");
 			rc = -EINVAL;
 			goto err_out_nosup;
 		}
@@ -1466,8 +1469,8 @@ int ata_dev_configure(struct ata_device 
 
 err_out_nosup:
 	if (ata_msg_probe(ap))
-		ata_dev_printk(dev, KERN_DEBUG, 
-				"%s: EXIT, err\n", __FUNCTION__);
+		ata_dev_printk(dev, KERN_DEBUG,
+			       "%s: EXIT, err\n", __FUNCTION__);
 	return rc;
 }
 
@@ -3527,7 +3530,7 @@ #endif /* __BIG_ENDIAN */
  *	Inherited from caller.
  */
 
-void ata_mmio_data_xfer(struct ata_device *adev, unsigned char *buf, 
+void ata_mmio_data_xfer(struct ata_device *adev, unsigned char *buf,
 			unsigned int buflen, int write_data)
 {
 	struct ata_port *ap = adev->ap;
@@ -3573,7 +3576,7 @@ void ata_mmio_data_xfer(struct ata_devic
  *	Inherited from caller.
  */
 
-void ata_pio_data_xfer(struct ata_device *adev, unsigned char *buf, 
+void ata_pio_data_xfer(struct ata_device *adev, unsigned char *buf,
 		       unsigned int buflen, int write_data)
 {
 	struct ata_port *ap = adev->ap;
@@ -3607,7 +3610,7 @@ void ata_pio_data_xfer(struct ata_device
  *	@buflen: buffer length
  *	@write_data: read/write
  *
- *	Transfer data from/to the device data register by PIO. Do the 
+ *	Transfer data from/to the device data register by PIO. Do the
  *	transfer with interrupts disabled.
  *
  *	LOCKING:
@@ -5212,7 +5215,7 @@ #if defined(ATA_VERBOSE_DEBUG)
 	ap->msg_enable = 0x00FF;
 #elif defined(ATA_DEBUG)
 	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_INFO | ATA_MSG_CTL | ATA_MSG_WARN | ATA_MSG_ERR;
-#else 
+#else
 	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_ERR | ATA_MSG_WARN;
 #endif
 
-- 
1.3.2

