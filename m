From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: [PATCH 1/n] libata-core.c conversion to new dbg scheme, v0.2 - part 1 (25% done)
Date: Mon, 12 Jun 2006 20:13:33 +0200
Message-ID: <20060612181333.GA20964@zmei.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp102.plus.mail.mud.yahoo.com ([68.142.206.235]:51047 "HELO
	smtp102.plus.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932875AbWFMEit (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Jun 2006 00:38:49 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com

This one is a rediff of the previous version + including Jeff's requests.
The first 25% of libata-core.c converted to the new debugging scheme.

Signed-off-by: <petkov@math.uni-muenster.de>


--- libata-dev/drivers/scsi/libata-core.c.orig	2006-06-12 19:40:14.000000000 +0200
+++ libata-dev/drivers/scsi/libata-core.c	2006-06-12 20:08:00.000000000 +0200
@@ -418,7 +418,7 @@ static const char *sata_spd_string(unsig
 
 void ata_dev_disable(struct ata_device *dev)
 {
-	if (ata_dev_enabled(dev)) {
+	if (ata_dev_enabled(dev) && ata_msg_drv(dev->ap)) {
 		ata_dev_printk(dev, KERN_WARNING, "disabled\n");
 		dev->class++;
 	}
@@ -777,8 +777,11 @@ void ata_std_dev_select (struct ata_port
 void ata_dev_select(struct ata_port *ap, unsigned int device,
 			   unsigned int wait, unsigned int can_sleep)
 {
-	VPRINTK("ENTER, ata%u: device %u, wait %u\n",
-		ap->id, device, wait);
+	if (ata_msg_probe(ap)) {
+		ata_port_printk(ap, KERN_INFO, "ata_dev_select: ENTER, ata%u: "
+				"device %u, wait %u\n",
+				ap->id, device, wait);
+	}
 
 	if (wait)
 		ata_wait_idle(ap);
@@ -931,13 +934,15 @@ void ata_port_flush_task(struct ata_port
 {
 	unsigned long flags;
 
-	DPRINTK("ENTER\n");
+	if (ata_msg_ctl(ap))
+		ata_port_printk(ap, KERN_DEBUG, "%s: ENTER\n", __FUNCTION__);
 
 	spin_lock_irqsave(&ap->host_set->lock, flags);
 	ap->flags |= ATA_FLAG_FLUSH_PORT_TASK;
 	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 
-	DPRINTK("flush #1\n");
+	if (ata_msg_ctl(ap))
+		ata_port_printk(ap, KERN_DEBUG, "%s: flush #1\n", __FUNCTION__);
 	flush_workqueue(ata_wq);
 
 	/*
@@ -946,7 +951,8 @@ void ata_port_flush_task(struct ata_port
 	 * Cancel and flush.
 	 */
 	if (!cancel_delayed_work(&ap->port_task)) {
-		DPRINTK("flush #2\n");
+		if (ata_msg_ctl(ap))
+			ata_port_printk(ap, KERN_DEBUG, "%s: flush #2\n", __FUNCTION__);
 		flush_workqueue(ata_wq);
 	}
 
@@ -954,7 +960,8 @@ void ata_port_flush_task(struct ata_port
 	ap->flags &= ~ATA_FLAG_FLUSH_PORT_TASK;
 	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 
-	DPRINTK("EXIT\n");
+	if (ata_msg_ctl(ap))
+		ata_port_printk(ap, KERN_DEBUG, "%s: EXIT\n", __FUNCTION__);
 }
 
 void ata_qc_complete_internal(struct ata_queued_cmd *qc)
@@ -1074,7 +1081,8 @@ unsigned ata_exec_internal(struct ata_de
 			else
 				ata_qc_complete(qc);
 
-			ata_dev_printk(dev, KERN_WARNING,
+			if (ata_msg_warn(ap))
+				ata_dev_printk(dev, KERN_WARNING,
 				       "qc timeout (cmd 0x%x)\n", command);
 		}
 
@@ -1086,7 +1094,9 @@ unsigned ata_exec_internal(struct ata_de
 		ap->ops->post_internal_cmd(qc);
 
 	if (qc->flags & ATA_QCFLAG_FAILED && !qc->err_mask) {
-		ata_dev_printk(dev, KERN_WARNING, "zero err_mask for failed "
+		if (ata_msg_warn(ap))
+			ata_dev_printk(dev, KERN_WARNING, 
+				"zero err_mask for failed "
 			       "internal command, assuming AC_ERR_OTHER\n");
 		qc->err_mask |= AC_ERR_OTHER;
 	}
@@ -1184,7 +1194,9 @@ int ata_dev_read_id(struct ata_device *d
 	const char *reason;
 	int rc;
 
-	DPRINTK("ENTER, host %u, dev %u\n", ap->id, dev->devno);
+	if (ata_msg_ctl(ap))
+		ata_dev_printk(dev, KERN_DEBUG, "%s: ENTER, host %u, dev %u\n", 
+				__FUNCTION__, ap->id, dev->devno);
 
 	ata_dev_select(ap, dev->devno, 1, 1); /* select device 0/1 */
 
@@ -1253,7 +1265,8 @@ int ata_dev_read_id(struct ata_device *d
 	return 0;
 
  err_out:
-	ata_dev_printk(dev, KERN_WARNING, "failed to IDENTIFY "
+	if (ata_msg_warn(ap)) 
+		ata_dev_printk(dev, KERN_WARNING, "failed to IDENTIFY "
 		       "(%s, err_mask=0x%x)\n", reason, err_mask);
 	return rc;
 }
@@ -1306,18 +1319,21 @@ int ata_dev_configure(struct ata_device 
 	unsigned int xfer_mask;
 	int i, rc;
 
-	if (!ata_dev_enabled(dev)) {
-		DPRINTK("ENTER/EXIT (host %u, dev %u) -- nodev\n",
-			ap->id, dev->devno);
+	if (!ata_dev_enabled(dev) && ata_msg_info(ap)) {
+		ata_dev_printk(dev, KERN_INFO, "%s: ENTER/EXIT (host %u, dev %u) -- nodev\n",
+			__FUNCTION__, ap->id, dev->devno);
 		return 0;
 	}
 
-	DPRINTK("ENTER, host %u, dev %u\n", ap->id, dev->devno);
+	if (ata_msg_probe(ap))
+		ata_dev_printk(dev, KERN_DEBUG, "%s: ENTER, host %u, dev %u\n", 
+			__FUNCTION__, ap->id, dev->devno);
 
 	/* print device capabilities */
-	if (print_info)
-		ata_dev_printk(dev, KERN_DEBUG, "cfg 49:%04x 82:%04x 83:%04x "
+	if (ata_msg_probe(ap))
+		ata_dev_printk(dev, KERN_DEBUG, "%s: cfg 49:%04x 82:%04x 83:%04x "
 			       "84:%04x 85:%04x 86:%04x 87:%04x 88:%04x\n",
+			       __FUNCTION__,
 			       id[49], id[82], id[83], id[84],
 			       id[85], id[86], id[87], id[88]);
 
@@ -1337,7 +1353,8 @@ int ata_dev_configure(struct ata_device 
 	/* find max transfer mode; for printk only */
 	xfer_mask = ata_id_xfermask(id);
 
-	ata_dump_id(id);
+	if (ata_msg_probe(ap))
+		ata_dump_id(id);
 
 	/* ATA-specific feature tests */
 	if (dev->class == ATA_DEV_ATA) {
@@ -1358,7 +1375,7 @@ int ata_dev_configure(struct ata_device 
 			ata_dev_config_ncq(dev, ncq_desc, sizeof(ncq_desc));
 
 			/* print device info to dmesg */
-			if (print_info)
+			if (ata_msg_info(ap))
 				ata_dev_printk(dev, KERN_INFO, "ATA-%d, "
 					"max %s, %Lu sectors: %s %s\n",
 					ata_id_major_version(id),
@@ -1381,7 +1398,7 @@ int ata_dev_configure(struct ata_device 
 			}
 
 			/* print device info to dmesg */
-			if (print_info)
+			if (ata_msg_info(ap))
 				ata_dev_printk(dev, KERN_INFO, "ATA-%d, "
 					"max %s, %Lu sectors: CHS %u/%u/%u\n",
 					ata_id_major_version(id),
@@ -1392,7 +1409,8 @@ int ata_dev_configure(struct ata_device 
 
 		if (dev->id[59] & 0x100) {
 			dev->multi_count = dev->id[59] & 0xff;
-			DPRINTK("ata%u: dev %u multi count %u\n",
+			if (ata_msg_info(ap))
+				ata_dev_printk(dev, KERN_INFO, "ata%u: dev %u multi count %u\n",
 				ap->id, dev->devno, dev->multi_count);
 		}
 
@@ -1405,8 +1423,9 @@ int ata_dev_configure(struct ata_device 
 
 		rc = atapi_cdb_len(id);
 		if ((rc < 12) || (rc > ATAPI_CDB_LEN)) {
-			ata_dev_printk(dev, KERN_WARNING,
-				       "unsupported CDB len\n");
+			if (ata_msg_warn(ap))
+				ata_dev_printk(dev, KERN_WARNING, 
+					"unsupported CDB len\n");
 			rc = -EINVAL;
 			goto err_out_nosup;
 		}
@@ -1418,7 +1437,7 @@ int ata_dev_configure(struct ata_device 
 		}
 
 		/* print device info to dmesg */
-		if (print_info)
+		if (ata_msg_info(ap))
 			ata_dev_printk(dev, KERN_INFO, "ATAPI, max %s%s\n",
 				       ata_mode_string(xfer_mask),
 				       cdb_intr_string);
@@ -1432,7 +1451,7 @@ int ata_dev_configure(struct ata_device 
 
 	/* limit bridge transfers to udma5, 200 sectors */
 	if (ata_dev_knobble(dev)) {
-		if (print_info)
+		if (ata_msg_info(ap))
 			ata_dev_printk(dev, KERN_INFO,
 				       "applying bridge limits\n");
 		dev->udma_mask &= ATA_UDMA5;
@@ -1442,11 +1461,15 @@ int ata_dev_configure(struct ata_device 
 	if (ap->ops->dev_config)
 		ap->ops->dev_config(ap, dev);
 
-	DPRINTK("EXIT, drv_stat = 0x%x\n", ata_chk_status(ap));
+	if (ata_msg_probe(ap))
+		ata_dev_printk(dev, KERN_DEBUG, "%s: EXIT, drv_stat = 0x%x\n",
+			__FUNCTION__, ata_chk_status(ap));
 	return 0;
 
 err_out_nosup:
-	DPRINTK("EXIT, err\n");
+	if (ata_msg_probe(ap))
+		ata_dev_printk(dev, KERN_DEBUG, 
+				"%s: EXIT, err\n", __FUNCTION__);
 	return rc;
 }
 

		
___________________________________________________________ 
Telefonate ohne weitere Kosten vom PC zum PC: http://messenger.yahoo.de

