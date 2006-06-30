From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: [PATCH 4/9] libata-core.c conversion
Date: Fri, 30 Jun 2006 08:46:30 +0200
Message-ID: <20060630064630.GA17376@zmei.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp104.plus.mail.re2.yahoo.com ([206.190.53.29]:28342 "HELO
	smtp104.plus.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751208AbWF3Gqg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Jun 2006 02:46:36 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide <linux-ide@vger.kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>

Convert the libata-core.c to the new scheme.

Signed-off-by: <petkov@math.uni-muenster.de>

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 47fff7b..0c9712c 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -74,7 +74,18 @@ static void ata_dev_xfermask(struct ata_
 static unsigned int ata_unique_id = 1;
 static struct workqueue_struct *ata_wq;
 
-struct workqueue_struct *ata_aux_wq;
+struct workqueue_struct *ata_aux_wq; 
+
+const char *__ata_msg_lvs[] = {
+	[ATA_MSG_ERR]	 = KERN_ERR,
+	[ATA_MSG_WARN]	 = KERN_WARNING,
+	[ATA_MSG_INFO]	 = KERN_INFO,
+	[ATA_MSG_DEBUG]	 = KERN_INFO,
+	[ATA_MSG_VDEBUG] = KERN_DEBUG,
+	[ATA_MSG_CMD]	 = KERN_DEBUG,
+	[ATA_MSG_SG]	 = KERN_DEBUG,
+	[ATA_MSG_TRACE]	 = KERN_DEBUG
+};
 
 int atapi_enabled = 1;
 module_param(atapi_enabled, int, 0444);
@@ -422,8 +433,8 @@ static const char *sata_spd_string(unsig
 
 void ata_dev_disable(struct ata_device *dev)
 {
-	if (ata_dev_enabled(dev) && ata_msg_drv(dev->ap)) {
-		ata_dev_printk(dev, KERN_WARNING, "disabled\n");
+	if (ata_dev_enabled(dev)) {
+		ata_dev_printk(dev, ATA_MSG_WARN, "disabled\n");
 		dev->class++;
 	}
 }
@@ -781,9 +792,9 @@ void ata_std_dev_select (struct ata_port
 void ata_dev_select(struct ata_port *ap, unsigned int device,
 			   unsigned int wait, unsigned int can_sleep)
 {
-	if (ata_msg_probe(ap))
-		ata_port_printk(ap, KERN_INFO, "ata_dev_select: ENTER, ata%u: "
-				"device %u, wait %u\n", ap->id, device, wait);
+	ata_port_printk(ap, ATA_MSG_TRACE, "%s: ENTER, ata%u: "
+			"device %u, wait %u\n", __FUNCTION__, 
+			ap->id, device, wait);
 
 	if (wait)
 		ata_wait_idle(ap);
@@ -936,13 +947,13 @@ void ata_port_flush_task(struct ata_port
 {
 	unsigned long flags;
 
-	DPRINTK("ENTER\n");
+	ata_port_printk(ap, ATA_MSG_TRACE, "%s: ENTER\n", __FUNCTION__);
 
 	spin_lock_irqsave(ap->lock, flags);
 	ap->flags |= ATA_FLAG_FLUSH_PORT_TASK;
 	spin_unlock_irqrestore(ap->lock, flags);
 
-	DPRINTK("flush #1\n");
+	ata_port_printk(ap, ATA_MSG_CMD, "%s: flush #1\n", __FUNCTION__);
 	flush_workqueue(ata_wq);
 
 	/*
@@ -951,8 +962,7 @@ void ata_port_flush_task(struct ata_port
 	 * Cancel and flush.
 	 */
 	if (!cancel_delayed_work(&ap->port_task)) {
-		if (ata_msg_ctl(ap))
-			ata_port_printk(ap, KERN_DEBUG, "%s: flush #2\n",
+		ata_port_printk(ap, ATA_MSG_CMD, "%s: flush #2\n",
 					__FUNCTION__);
 		flush_workqueue(ata_wq);
 	}
@@ -961,8 +971,7 @@ void ata_port_flush_task(struct ata_port
 	ap->flags &= ~ATA_FLAG_FLUSH_PORT_TASK;
 	spin_unlock_irqrestore(ap->lock, flags);
 
-	if (ata_msg_ctl(ap))
-		ata_port_printk(ap, KERN_DEBUG, "%s: EXIT\n", __FUNCTION__);
+	ata_port_printk(ap, ATA_MSG_TRACE, "%s: EXIT\n", __FUNCTION__);
 }
 
 void ata_qc_complete_internal(struct ata_queued_cmd *qc)
@@ -1082,8 +1091,7 @@ unsigned ata_exec_internal(struct ata_de
 			else
 				ata_qc_complete(qc);
 
-			if (ata_msg_warn(ap))
-				ata_dev_printk(dev, KERN_WARNING,
+			ata_dev_printk(dev, ATA_MSG_WARN,
 					"qc timeout (cmd 0x%x)\n", command);
 		}
 
@@ -1095,8 +1103,7 @@ unsigned ata_exec_internal(struct ata_de
 		ap->ops->post_internal_cmd(qc);
 
 	if (qc->flags & ATA_QCFLAG_FAILED && !qc->err_mask) {
-		if (ata_msg_warn(ap))
-			ata_dev_printk(dev, KERN_WARNING,
+		ata_dev_printk(dev, ATA_MSG_WARN,
 				"zero err_mask for failed "
 				"internal command, assuming AC_ERR_OTHER\n");
 		qc->err_mask |= AC_ERR_OTHER;
@@ -1222,8 +1229,7 @@ int ata_dev_read_id(struct ata_device *d
 	const char *reason;
 	int rc;
 
-	if (ata_msg_ctl(ap))
-		ata_dev_printk(dev, KERN_DEBUG, "%s: ENTER, host %u, dev %u\n",
+	ata_dev_printk(dev, ATA_MSG_TRACE, "%s: ENTER, host %u, dev %u\n",
 			       __FUNCTION__, ap->id, dev->devno);
 
 	ata_dev_select(ap, dev->devno, 1, 1); /* select device 0/1 */
@@ -1293,9 +1299,8 @@ int ata_dev_read_id(struct ata_device *d
 	return 0;
 
  err_out:
-	if (ata_msg_warn(ap))
-		ata_dev_printk(dev, KERN_WARNING, "failed to IDENTIFY "
-			       "(%s, err_mask=0x%x)\n", reason, err_mask);
+	ata_dev_printk(dev, ATA_MSG_WARN, "failed to IDENTIFY "
+			"(%s, err_mask=0x%x)\n", reason, err_mask);
 	return rc;
 }
 
@@ -1347,20 +1352,18 @@ int ata_dev_configure(struct ata_device 
 	unsigned int xfer_mask;
 	int i, rc;
 
-	if (!ata_dev_enabled(dev) && ata_msg_info(ap)) {
-		ata_dev_printk(dev, KERN_INFO,
+	if (!ata_dev_enabled(dev)) {
+		ata_dev_printk(dev, ATA_MSG_TRACE,
 			       "%s: ENTER/EXIT (host %u, dev %u) -- nodev\n",
 			       __FUNCTION__, ap->id, dev->devno);
 		return 0;
 	}
 
-	if (ata_msg_probe(ap))
-		ata_dev_printk(dev, KERN_DEBUG, "%s: ENTER, host %u, dev %u\n",
+	ata_dev_printk(dev, ATA_MSG_TRACE, "%s: ENTER, host %u, dev %u\n",
 			       __FUNCTION__, ap->id, dev->devno);
 
 	/* print device capabilities */
-	if (ata_msg_probe(ap))
-		ata_dev_printk(dev, KERN_DEBUG,
+	ata_dev_printk(dev, ATA_MSG_DEBUG,
 			       "%s: cfg 49:%04x 82:%04x 83:%04x 84:%04x "
 			       "85:%04x 86:%04x 87:%04x 88:%04x\n",
 			       __FUNCTION__,
@@ -1383,8 +1386,7 @@ int ata_dev_configure(struct ata_device 
 	/* find max transfer mode; for printk only */
 	xfer_mask = ata_id_xfermask(id);
 
-	if (ata_msg_probe(ap))
-		ata_dump_id(id);
+	ata_dump_id(id);
 
 	/* ATA-specific feature tests */
 	if (dev->class == ATA_DEV_ATA) {
@@ -1405,8 +1407,8 @@ int ata_dev_configure(struct ata_device 
 			ata_dev_config_ncq(dev, ncq_desc, sizeof(ncq_desc));
 
 			/* print device info to dmesg */
-			if (ata_msg_info(ap))
-				ata_dev_printk(dev, KERN_INFO, "ATA-%d, "
+			if (print_info)
+				ata_dev_printk(dev, ATA_MSG_INFO, "ATA-%d, "
 					"max %s, %Lu sectors: %s %s\n",
 					ata_id_major_version(id),
 					ata_mode_string(xfer_mask),
@@ -1428,8 +1430,8 @@ int ata_dev_configure(struct ata_device 
 			}
 
 			/* print device info to dmesg */
-			if (ata_msg_info(ap))
-				ata_dev_printk(dev, KERN_INFO, "ATA-%d, "
+			if (print_info)
+				ata_dev_printk(dev, ATA_MSG_INFO, "ATA-%d, "
 					"max %s, %Lu sectors: CHS %u/%u/%u\n",
 					ata_id_major_version(id),
 					ata_mode_string(xfer_mask),
@@ -1440,8 +1442,8 @@ int ata_dev_configure(struct ata_device 
 
 		if (dev->id[59] & 0x100) {
 			dev->multi_count = dev->id[59] & 0xff;
-			if (ata_msg_info(ap))
-				ata_dev_printk(dev, KERN_INFO,
+			if (print_info)
+				ata_dev_printk(dev, ATA_MSG_INFO,
 					"ata%u: dev %u multi count %u\n",
 					ap->id, dev->devno, dev->multi_count);
 		}
@@ -1455,9 +1457,8 @@ int ata_dev_configure(struct ata_device 
 
 		rc = atapi_cdb_len(id);
 		if ((rc < 12) || (rc > ATAPI_CDB_LEN)) {
-			if (ata_msg_warn(ap))
-				ata_dev_printk(dev, KERN_WARNING,
-					       "unsupported CDB len\n");
+			ata_dev_printk(dev, ATA_MSG_WARN, 
+					"unsupported CDB len\n");
 			rc = -EINVAL;
 			goto err_out_nosup;
 		}
@@ -1469,8 +1470,8 @@ int ata_dev_configure(struct ata_device 
 		}
 
 		/* print device info to dmesg */
-		if (ata_msg_info(ap))
-			ata_dev_printk(dev, KERN_INFO, "ATAPI, max %s%s\n",
+		if (print_info)
+			ata_dev_printk(dev, ATA_MSG_INFO, "ATAPI, max %s%s\n",
 				       ata_mode_string(xfer_mask),
 				       cdb_intr_string);
 	}
@@ -1483,8 +1484,8 @@ int ata_dev_configure(struct ata_device 
 
 	/* limit bridge transfers to udma5, 200 sectors */
 	if (ata_dev_knobble(dev)) {
-		if (ata_msg_info(ap))
-			ata_dev_printk(dev, KERN_INFO,
+		if (print_info)
+			ata_dev_printk(dev, ATA_MSG_INFO,
 				       "applying bridge limits\n");
 		dev->udma_mask &= ATA_UDMA5;
 		dev->max_sectors = ATA_MAX_SECTORS;
@@ -1493,15 +1494,12 @@ int ata_dev_configure(struct ata_device 
 	if (ap->ops->dev_config)
 		ap->ops->dev_config(ap, dev);
 
-	if (ata_msg_probe(ap))
-		ata_dev_printk(dev, KERN_DEBUG, "%s: EXIT, drv_stat = 0x%x\n",
+	ata_dev_printk(dev, ATA_MSG_TRACE, "%s: EXIT, drv_stat = 0x%x\n",
 			__FUNCTION__, ata_chk_status(ap));
 	return 0;
 
 err_out_nosup:
-	if (ata_msg_probe(ap))
-		ata_dev_printk(dev, KERN_DEBUG,
-			       "%s: EXIT, err\n", __FUNCTION__);
+	ata_dev_printk(dev, ATA_MSG_TRACE, "%s: EXIT, err\n", __FUNCTION__);
 	return rc;
 }
 
@@ -1652,11 +1650,11 @@ static void sata_print_link_status(struc
 
 	if (ata_port_online(ap)) {
 		tmp = (sstatus >> 4) & 0xf;
-		ata_port_printk(ap, KERN_INFO,
+		ata_port_printk(ap, ATA_MSG_INFO,
 				"SATA link up %s (SStatus %X SControl %X)\n",
 				sata_spd_string(tmp), sstatus, scontrol);
 	} else {
-		ata_port_printk(ap, KERN_INFO,
+		ata_port_printk(ap, ATA_MSG_INFO,
 				"SATA link down (SStatus %X SControl %X)\n",
 				sstatus, scontrol);
 	}
@@ -1812,7 +1810,7 @@ int sata_down_spd_limit(struct ata_port 
 
 	ap->sata_spd_limit = mask;
 
-	ata_port_printk(ap, KERN_WARNING, "limiting SATA link speed to %s\n",
+	ata_port_printk(ap, ATA_MSG_WARN, "limiting SATA link speed to %s\n",
 			sata_spd_string(fls(mask)));
 
 	return 0;
@@ -2075,7 +2073,7 @@ int ata_down_xfermask_limit(struct ata_d
 	ata_unpack_xfermask(xfer_mask, &dev->pio_mask, &dev->mwdma_mask,
 			    &dev->udma_mask);
 
-	ata_dev_printk(dev, KERN_WARNING, "limiting speed to %s\n",
+	ata_dev_printk(dev, ATA_MSG_WARN, "limiting speed to %s\n",
 		       ata_mode_string(xfer_mask));
 
 	return 0;
@@ -2095,7 +2093,7 @@ static int ata_dev_set_mode(struct ata_d
 
 	err_mask = ata_dev_set_xfermode(dev);
 	if (err_mask) {
-		ata_dev_printk(dev, KERN_ERR, "failed to set xfermode "
+		ata_dev_printk(dev, ATA_MSG_ERR, "failed to set xfermode "
 			       "(err_mask=0x%x)\n", err_mask);
 		return -EIO;
 	}
@@ -2104,10 +2102,10 @@ static int ata_dev_set_mode(struct ata_d
 	if (rc)
 		return rc;
 
-	DPRINTK("xfer_shift=%u, xfer_mode=0x%x\n",
+	ata_dev_printk(dev, ATA_MSG_DEBUG, "xfer_shift=%u, xfer_mode=0x%x\n",
 		dev->xfer_shift, (int)dev->xfer_mode);
 
-	ata_dev_printk(dev, KERN_INFO, "configured for %s\n",
+	ata_dev_printk(dev, ATA_MSG_INFO, "configured for %s\n",
 		       ata_mode_string(ata_xfer_mode2mask(dev->xfer_mode)));
 	return 0;
 }
@@ -2176,7 +2174,7 @@ int ata_set_mode(struct ata_port *ap, st
 			continue;
 
 		if (!dev->pio_mode) {
-			ata_dev_printk(dev, KERN_WARNING, "no PIO support\n");
+			ata_dev_printk(dev, ATA_MSG_WARN, "no PIO support\n");
 			rc = -EINVAL;
 			goto out;
 		}
@@ -2260,7 +2258,7 @@ static inline void ata_tf_to_host(struct
  *	LOCKING: None.
  */
 
-unsigned int ata_busy_sleep (struct ata_port *ap,
+unsigned int ata_busy_sleep(struct ata_port *ap,
 			     unsigned long tmout_pat, unsigned long tmout)
 {
 	unsigned long timer_start, timeout;
@@ -2275,7 +2273,7 @@ unsigned int ata_busy_sleep (struct ata_
 	}
 
 	if (status & ATA_BUSY)
-		ata_port_printk(ap, KERN_WARNING,
+		ata_port_printk(ap, ATA_MSG_WARN,
 				"port is slow to respond, please be patient\n");
 
 	timeout = timer_start + tmout;
@@ -2285,7 +2283,7 @@ unsigned int ata_busy_sleep (struct ata_
 	}
 
 	if (status & ATA_BUSY) {
-		ata_port_printk(ap, KERN_ERR, "port failed to respond "
+		ata_port_printk(ap, ATA_MSG_ERR, "port failed to respond "
 				"(%lu secs)\n", tmout / HZ);
 		return 1;
 	}
@@ -2345,7 +2343,7 @@ static unsigned int ata_bus_softreset(st
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 
-	DPRINTK("ata%u: bus reset via SRST\n", ap->id);
+	ata_port_printk(ap, ATA_MSG_DEBUG, "ata%u: bus reset via SRST\n", ap->id);
 
 	/* software reset.  causes dev0 to be selected */
 	if (ap->flags & ATA_FLAG_MMIO) {
@@ -2379,7 +2377,7 @@ static unsigned int ata_bus_softreset(st
 	 * pulldown resistor.
 	 */
 	if (ata_check_status(ap) == 0xFF) {
-		ata_port_printk(ap, KERN_ERR, "SRST failed (status 0xFF)\n");
+		ata_port_printk(ap, ATA_MSG_ERR, "SRST failed (status 0xFF)\n");
 		return AC_ERR_OTHER;
 	}
 
@@ -2415,7 +2413,8 @@ void ata_bus_reset(struct ata_port *ap)
 	u8 err;
 	unsigned int dev0, dev1 = 0, devmask = 0;
 
-	DPRINTK("ENTER, host %u, port %u\n", ap->id, ap->port_no);
+	ata_port_printk(ap, ATA_MSG_TRACE, "%s_ ENTER, host %u, port %u\n", 
+			__FUNCTION__, ap->id, ap->port_no);
 
 	/* determine if device 0/1 are present */
 	if (ap->flags & ATA_FLAG_SATA_RESET)
@@ -2469,14 +2468,14 @@ void ata_bus_reset(struct ata_port *ap)
 			outb(ap->ctl, ioaddr->ctl_addr);
 	}
 
-	DPRINTK("EXIT\n");
+	ata_port_printk(ap, ATA_MSG_TRACE, "%s: EXIT\n", __FUNCTION__);
 	return;
 
 err_out:
-	ata_port_printk(ap, KERN_ERR, "disabling port\n");
+	ata_port_printk(ap, ATA_MSG_ERR, "disabling port\n");
 	ap->ops->port_disable(ap);
 
-	DPRINTK("EXIT\n");
+	ata_port_printk(ap, ATA_MSG_TRACE, "%s: EXIT\n", __FUNCTION__);
 }
 
 /**
@@ -2595,7 +2594,7 @@ static void ata_wait_spinup(struct ata_p
 		return;
 
 	if (secs > 5)
-		ata_port_printk(ap, KERN_INFO, "waiting for device to spin up "
+		ata_port_printk(ap, ATA_MSG_INFO, "waiting for device to spin up "
 				"(%lu secs)\n", secs);
 
 	schedule_timeout_uninterruptible(end - jiffies);
@@ -2641,7 +2640,7 @@ int ata_std_prereset(struct ata_port *ap
 		rc = sata_phy_resume(ap, timing);
 		if (rc && rc != -EOPNOTSUPP) {
 			/* phy resume failed */
-			ata_port_printk(ap, KERN_WARNING, "failed to resume "
+			ata_port_printk(ap, ATA_MSG_WARN, "failed to resume "
 					"link for reset (errno=%d)\n", rc);
 			return rc;
 		}
@@ -2675,7 +2674,7 @@ int ata_std_softreset(struct ata_port *a
 	unsigned int devmask = 0, err_mask;
 	u8 err;
 
-	DPRINTK("ENTER\n");
+	ata_port_printk(ap, ATA_MSG_TRACE, "%s: ENTER\n", __FUNCTION__);
 
 	if (ata_port_offline(ap)) {
 		classes[0] = ATA_DEV_NONE;
@@ -2692,10 +2691,11 @@ int ata_std_softreset(struct ata_port *a
 	ap->ops->dev_select(ap, 0);
 
 	/* issue bus reset */
-	DPRINTK("about to softreset, devmask=%x\n", devmask);
+	ata_port_printk(ap, ATA_MSG_DEBUG, "%s: about to softreset, devmask=%x\n",
+			__FUNCTION__, devmask);
 	err_mask = ata_bus_softreset(ap, devmask);
 	if (err_mask) {
-		ata_port_printk(ap, KERN_ERR, "SRST failed (err_mask=0x%x)\n",
+		ata_port_printk(ap, ATA_MSG_ERR, "SRST failed (err_mask=0x%x)\n",
 				err_mask);
 		return -EIO;
 	}
@@ -2706,7 +2706,8 @@ int ata_std_softreset(struct ata_port *a
 		classes[1] = ata_dev_try_classify(ap, 1, &err);
 
  out:
-	DPRINTK("EXIT, classes[0]=%u [1]=%u\n", classes[0], classes[1]);
+	ata_port_printk(ap, ATA_MSG_TRACE, "%s: EXIT, classes[0]=%u [1]=%u\n",
+			__FUNCTION__, classes[0], classes[1]);
 	return 0;
 }
 
@@ -2728,7 +2729,7 @@ int sata_std_hardreset(struct ata_port *
 	u32 scontrol;
 	int rc;
 
-	DPRINTK("ENTER\n");
+	ata_port_printk(ap, ATA_MSG_TRACE, "%s: ENTER\n", __FUNCTION__);
 
 	if (sata_set_spd_needed(ap)) {
 		/* SATA spec says nothing about how to reconfigure
@@ -2767,12 +2768,13 @@ int sata_std_hardreset(struct ata_port *
 	/* TODO: phy layer with polling, timeouts, etc. */
 	if (ata_port_offline(ap)) {
 		*class = ATA_DEV_NONE;
-		DPRINTK("EXIT, link offline\n");
+		ata_port_printk(ap, ATA_MSG_TRACE, "%s: EXIT, link offline\n",
+				__FUNCTION__);
 		return 0;
 	}
 
 	if (ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT)) {
-		ata_port_printk(ap, KERN_ERR,
+		ata_port_printk(ap, ATA_MSG_ERR,
 				"COMRESET failed (device not ready)\n");
 		return -EIO;
 	}
@@ -2781,7 +2783,8 @@ int sata_std_hardreset(struct ata_port *
 
 	*class = ata_dev_try_classify(ap, 0, NULL);
 
-	DPRINTK("EXIT, class=%u\n", *class);
+	ata_port_printk(ap, ATA_MSG_TRACE, "%s: EXIT, class=%u\n", 
+			__FUNCTION__, *class);
 	return 0;
 }
 
@@ -2801,7 +2804,7 @@ void ata_std_postreset(struct ata_port *
 {
 	u32 serror;
 
-	DPRINTK("ENTER\n");
+	ata_port_printk(ap, ATA_MSG_TRACE, "%s: ENTER\n", __FUNCTION__);
 
 	/* print link status */
 	sata_print_link_status(ap);
@@ -2825,7 +2828,8 @@ void ata_std_postreset(struct ata_port *
 
 	/* bail out if no device is present */
 	if (classes[0] == ATA_DEV_NONE && classes[1] == ATA_DEV_NONE) {
-		DPRINTK("EXIT, no device\n");
+		ata_port_printk(ap, ATA_MSG_TRACE, "%s: EXIT, no device\n",
+				__FUNCTION__);
 		return;
 	}
 
@@ -2837,7 +2841,7 @@ void ata_std_postreset(struct ata_port *
 			outb(ap->ctl, ap->ioaddr.ctl_addr);
 	}
 
-	DPRINTK("EXIT\n");
+	ata_port_printk(ap, ATA_MSG_TRACE, "%s: EXIT\n", __FUNCTION__);
 }
 
 /**
@@ -2864,7 +2868,7 @@ static int ata_dev_same_device(struct at
 	u64 new_n_sectors;
 
 	if (dev->class != new_class) {
-		ata_dev_printk(dev, KERN_INFO, "class mismatch %d != %d\n",
+		ata_dev_printk(dev, ATA_MSG_INFO, "class mismatch %d != %d\n",
 			       dev->class, new_class);
 		return 0;
 	}
@@ -2876,19 +2880,19 @@ static int ata_dev_same_device(struct at
 	new_n_sectors = ata_id_n_sectors(new_id);
 
 	if (strcmp(model[0], model[1])) {
-		ata_dev_printk(dev, KERN_INFO, "model number mismatch "
+		ata_dev_printk(dev, ATA_MSG_INFO, "model number mismatch "
 			       "'%s' != '%s'\n", model[0], model[1]);
 		return 0;
 	}
 
 	if (strcmp(serial[0], serial[1])) {
-		ata_dev_printk(dev, KERN_INFO, "serial number mismatch "
+		ata_dev_printk(dev, ATA_MSG_INFO, "serial number mismatch "
 			       "'%s' != '%s'\n", serial[0], serial[1]);
 		return 0;
 	}
 
 	if (dev->class == ATA_DEV_ATA && dev->n_sectors != new_n_sectors) {
-		ata_dev_printk(dev, KERN_INFO, "n_sectors mismatch "
+		ata_dev_printk(dev, ATA_MSG_INFO, "n_sectors mismatch "
 			       "%llu != %llu\n",
 			       (unsigned long long)dev->n_sectors,
 			       (unsigned long long)new_n_sectors);
@@ -2942,7 +2946,7 @@ int ata_dev_revalidate(struct ata_device
 		return 0;
 
  fail:
-	ata_dev_printk(dev, KERN_ERR, "revalidation failed (errno=%d)\n", rc);
+	ata_dev_printk(dev, ATA_MSG_ERR, "revalidation failed (errno=%d)\n", rc);
 	return rc;
 }
 
@@ -3078,7 +3082,7 @@ static void ata_dev_xfermask(struct ata_
 	}
 
 	if (ata_dma_blacklisted(dev))
-		ata_dev_printk(dev, KERN_WARNING,
+		ata_dev_printk(dev, ATA_MSG_WARN,
 			       "device is on DMA blacklist, disabling DMA\n");
 
 	if (hs->flags & ATA_HOST_SIMPLEX) {
@@ -3113,7 +3117,8 @@ static unsigned int ata_dev_set_xfermode
 	unsigned int err_mask;
 
 	/* set up set-features taskfile */
-	DPRINTK("set features - xfer mode\n");
+	ata_dev_printk(dev, ATA_MSG_DEBUG, "%s: set features - xfer mode\n", 
+			__FUNCTION__);
 
 	ata_tf_init(dev, &tf);
 	tf.command = ATA_CMD_SET_FEATURES;
@@ -3124,7 +3129,8 @@ static unsigned int ata_dev_set_xfermode
 
 	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0);
 
-	DPRINTK("EXIT, err_mask=%x\n", err_mask);
+	ata_dev_printk(dev, ATA_MSG_TRACE, "%s: EXIT, err_mask=%x\n", 
+			__FUNCTION__, err_mask);
 	return err_mask;
 }
 
@@ -3151,7 +3157,8 @@ static unsigned int ata_dev_init_params(
 		return AC_ERR_INVALID;
 
 	/* set up init dev params taskfile */
-	DPRINTK("init dev params \n");
+	ata_dev_printk(dev, ATA_MSG_VDEBUG, "%s: init dev params \n", 
+			__FUNCTION__);
 
 	ata_tf_init(dev, &tf);
 	tf.command = ATA_CMD_INIT_DEV_PARAMS;
@@ -3162,7 +3169,8 @@ static unsigned int ata_dev_init_params(
 
 	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0);
 
-	DPRINTK("EXIT, err_mask=%x\n", err_mask);
+	ata_dev_printk(dev, ATA_MSG_TRACE, "%s: EXIT, err_mask=%x\n", 
+			__FUNCTION__, err_mask);
 	return err_mask;
 }
 
@@ -3189,7 +3197,8 @@ static void ata_sg_clean(struct ata_queu
 	if (qc->flags & ATA_QCFLAG_SINGLE)
 		WARN_ON(qc->n_elem > 1);
 
-	VPRINTK("unmapping %u sg elements\n", qc->n_elem);
+	ata_port_printk(ap, ATA_MSG_SG, "%s: unmapping %u sg elements\n", 
+			__FUNCTION__, qc->n_elem);
 
 	/* if we padded the buffer out to 32-bit bound, and data
 	 * xfer direction is from-device, we must copy from the
@@ -3265,7 +3274,9 @@ static void ata_fill_sg(struct ata_queue
 
 			ap->prd[idx].addr = cpu_to_le32(addr);
 			ap->prd[idx].flags_len = cpu_to_le32(len & 0xffff);
-			VPRINTK("PRD[%u] = (0x%X, 0x%X)\n", idx, addr, len);
+			ata_port_printk(ap, ATA_MSG_SG, 
+					"%s: PRD[%u] = (0x%X, 0x%X)\n",
+					__FUNCTION__, idx, addr, len);
 
 			idx++;
 			sg_len -= len;
@@ -3414,8 +3425,10 @@ static int ata_sg_setup_one(struct ata_q
 		if (sg->length == 0)
 			trim_sg = 1;
 
-		DPRINTK("padding done, sg->length=%u pad_len=%u\n",
-			sg->length, qc->pad_len);
+		ata_port_printk(ap, ATA_MSG_SG, 
+				"%s: padding done, sg->length=%u pad_len=%u\n",
+				__FUNCTION__, 
+				sg->length, qc->pad_len);
 	}
 
 	if (trim_sg) {
@@ -3435,7 +3448,9 @@ static int ata_sg_setup_one(struct ata_q
 	sg_dma_len(sg) = sg->length;
 
 skip_map:
-	DPRINTK("mapped buffer of %d bytes for %s\n", sg_dma_len(sg),
+	ata_port_printk(ap, ATA_MSG_SG, 
+			"%s: mapped buffer of %d bytes for %s\n",
+			__FUNCTION__, sg_dma_len(sg),
 		qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
 
 	return 0;
@@ -3462,7 +3477,8 @@ static int ata_sg_setup(struct ata_queue
 	struct scatterlist *lsg = &sg[qc->n_elem - 1];
 	int n_elem, pre_n_elem, dir, trim_sg = 0;
 
-	VPRINTK("ENTER, ata%u\n", ap->id);
+	ata_port_printk(ap, ATA_MSG_TRACE, "%s: ENTER, ata%u\n", 
+			__FUNCTION__, ap->id);
 	WARN_ON(!(qc->flags & ATA_QCFLAG_SG));
 
 	/* we must lengthen transfers to end on a 32-bit boundary */
@@ -3497,8 +3513,10 @@ static int ata_sg_setup(struct ata_queue
 		if (lsg->length == 0)
 			trim_sg = 1;
 
-		DPRINTK("padding done, sg[%d].length=%u pad_len=%u\n",
-			qc->n_elem - 1, lsg->length, qc->pad_len);
+		ata_port_printk(ap, ATA_MSG_SG, 
+				"%s: padding done, sg[%d].length=%u" 
+				"pad_len=%u\n", __FUNCTION__, 
+				qc->n_elem - 1, lsg->length, qc->pad_len);
 	}
 
 	pre_n_elem = qc->n_elem;
@@ -3518,7 +3536,8 @@ static int ata_sg_setup(struct ata_queue
 		return -1;
 	}
 
-	DPRINTK("%d sg elements mapped\n", n_elem);
+	ata_port_printk(ap, ATA_MSG_SG, "%s: %d sg elements mapped\n", 
+			__FUNCTION__, n_elem);
 
 skip_map:
 	qc->n_elem = n_elem;
@@ -3687,7 +3706,9 @@ static void ata_pio_sector(struct ata_qu
 	page = nth_page(page, (offset >> PAGE_SHIFT));
 	offset %= PAGE_SIZE;
 
-	DPRINTK("data %s\n", qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
+	ata_port_printk(ap, ATA_MSG_CMD, "%s: data %s\n", 
+			__FUNCTION__,
+			qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
 
 	if (PageHighMem(page)) {
 		unsigned long flags;
@@ -3756,7 +3777,7 @@ static void ata_pio_sectors(struct ata_q
 static void atapi_send_cdb(struct ata_port *ap, struct ata_queued_cmd *qc)
 {
 	/* send SCSI cdb */
-	DPRINTK("send cdb\n");
+	ata_port_printk(ap, ATA_MSG_CMD, "%s: send cdb\n", __FUNCTION__);
 	WARN_ON(qc->dev->cdb_len < 12);
 
 	ap->ops->data_xfer(qc->dev, qc->cdb, qc->dev->cdb_len, 1);
@@ -3815,7 +3836,7 @@ next_sg:
 		unsigned int i;
 
 		if (words) /* warning if bytes > 1 */
-			ata_dev_printk(qc->dev, KERN_WARNING,
+			ata_dev_printk(qc->dev, ATA_MSG_WARN,
 				       "%u bytes trailing data\n", bytes);
 
 		for (i = 0; i < words; i++)
@@ -3840,7 +3861,9 @@ next_sg:
 	/* don't cross page boundaries */
 	count = min(count, (unsigned int)PAGE_SIZE - offset);
 
-	DPRINTK("data %s\n", qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
+	ata_port_printk(ap, ATA_MSG_CMD, "%s: data %s\n", 
+			__FUNCTION__,
+			qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
 
 	if (PageHighMem(page)) {
 		unsigned long flags;
@@ -3910,14 +3933,15 @@ static void atapi_pio_bytes(struct ata_q
 	if (do_write != i_write)
 		goto err_out;
 
-	VPRINTK("ata%u: xfering %d bytes\n", ap->id, bytes);
+	ata_port_printk(ap, ATA_MSG_CMD, "%s: ata%u: xfering %d bytes\n", 
+			__FUNCTION__, ap->id, bytes);
 
 	__atapi_pio_bytes(qc, bytes);
 
 	return;
 
 err_out:
-	ata_dev_printk(dev, KERN_INFO, "ATAPI check failed\n");
+	ata_dev_printk(dev, ATA_MSG_INFO, "ATAPI check failed\n");
 	qc->err_mask |= AC_ERR_HSM;
 	ap->hsm_task_state = HSM_ST_ERR;
 }
@@ -4026,8 +4050,9 @@ int ata_hsm_move(struct ata_port *ap, st
 	WARN_ON(in_wq != ata_hsm_ok_in_wq(ap, qc));
 
 fsm_start:
-	DPRINTK("ata%u: protocol %d task_state %d (dev_stat 0x%X)\n",
-		ap->id, qc->tf.protocol, ap->hsm_task_state, status);
+	ata_port_printk(ap, ATA_MSG_CMD, "%s: ata%u: protocol %d task_state %d" 
+			"(dev_stat 0x%X)\n", __FUNCTION__, 
+			ap->id, qc->tf.protocol, ap->hsm_task_state, status);
 
 	switch (ap->hsm_task_state) {
 	case HSM_ST_FIRST:
@@ -4060,8 +4085,9 @@ fsm_start:
 		 * let the EH abort the command or reset the device.
 		 */
 		if (unlikely(status & (ATA_ERR | ATA_DF))) {
-			printk(KERN_WARNING "ata%d: DRQ=1 with device error, dev_stat 0x%X\n",
-			       ap->id, status);
+			ata_port_printk(ap, ATA_MSG_WARN, 
+					"ata%d: DRQ=1 with device error, dev_stat 0x%X\n",
+					 ap->id, status);
 			qc->err_mask |= AC_ERR_HSM;
 			ap->hsm_task_state = HSM_ST_ERR;
 			goto fsm_start;
@@ -4118,8 +4144,10 @@ fsm_start:
 			 * let the EH abort the command or reset the device.
 			 */
 			if (unlikely(status & (ATA_ERR | ATA_DF))) {
-				printk(KERN_WARNING "ata%d: DRQ=1 with device error, dev_stat 0x%X\n",
-				       ap->id, status);
+				ata_port_printk(ap, ATA_MSG_WARN, 
+						"ata%d: DRQ=1 with device error,"
+						"dev_stat 0x%X\n",
+						 ap->id, status);
 				qc->err_mask |= AC_ERR_HSM;
 				ap->hsm_task_state = HSM_ST_ERR;
 				goto fsm_start;
@@ -4200,8 +4228,10 @@ fsm_start:
 		}
 
 		/* no more data to transfer */
-		DPRINTK("ata%u: dev %u command complete, drv_stat 0x%x\n",
-			ap->id, qc->dev->devno, status);
+		ata_port_printk(ap, ATA_MSG_CMD, 
+				"%s: ata%u: dev %u command complete, drv_stat 0x%x\n",
+				__FUNCTION__, 
+				ap->id, qc->dev->devno, status);
 
 		WARN_ON(qc->err_mask);
 
@@ -4466,7 +4496,7 @@ int ata_qc_complete_multiple(struct ata_
 	done_mask = ap->qc_active ^ qc_active;
 
 	if (unlikely(done_mask & qc_active)) {
-		ata_port_printk(ap, KERN_ERR, "illegal qc_active transition "
+		ata_port_printk(ap, ATA_MSG_ERR, "illegal qc_active transition "
 				"(%08x->%08x)\n", ap->qc_active, qc_active);
 		return -EINVAL;
 	}
@@ -4718,13 +4748,15 @@ unsigned int ata_qc_issue_prot(struct at
  *	One if interrupt was handled, zero if not (shared irq).
  */
 
-inline unsigned int ata_host_intr (struct ata_port *ap,
+inline unsigned int ata_host_intr(struct ata_port *ap,
 				   struct ata_queued_cmd *qc)
 {
 	u8 status, host_stat = 0;
 
-	VPRINTK("ata%u: protocol %d task_state %d\n",
-		ap->id, qc->tf.protocol, ap->hsm_task_state);
+	ata_port_printk(ap, ATA_MSG_VDEBUG, 
+			"%s: ata%u: protocol %d task_state %d\n",
+			__FUNCTION__, 
+			ap->id, qc->tf.protocol, ap->hsm_task_state);
 
 	/* Check whether we are expecting interrupt in this state */
 	switch (ap->hsm_task_state) {
@@ -4745,7 +4777,10 @@ inline unsigned int ata_host_intr (struc
 		    qc->tf.protocol == ATA_PROT_ATAPI_DMA) {
 			/* check status of DMA engine */
 			host_stat = ap->ops->bmdma_status(ap);
-			VPRINTK("ata%u: host_stat 0x%X\n", ap->id, host_stat);
+			ata_port_printk(ap, ATA_MSG_VDEBUG, 
+					"%s: ata%u: host_stat 0x%X\n", 
+					__FUNCTION__,
+					ap->id, host_stat);
 
 			/* if it's not our irq... */
 			if (!(host_stat & ATA_DMA_INTR))
@@ -4789,7 +4824,7 @@ idle_irq:
 #ifdef ATA_IRQ_TRAP
 	if ((ap->stats.idle_irq % 1000) == 0) {
 		ata_irq_ack(ap, 0); /* debug trap */
-		ata_port_printk(ap, KERN_WARNING, "irq trap\n");
+		ata_port_printk(ap, ATA_MSG_WARN, "irq trap\n");
 		return 1;
 	}
 #endif
@@ -4995,7 +5030,7 @@ int ata_flush_cache(struct ata_device *d
 
 	err_mask = ata_do_simple_cmd(dev, cmd);
 	if (err_mask) {
-		ata_dev_printk(dev, KERN_ERR, "failed to flush cache\n");
+		ata_dev_printk(dev, ATA_MSG_ERR, "failed to flush cache\n");
 		return -EIO;
 	}
 
@@ -5008,7 +5043,7 @@ static int ata_standby_drive(struct ata_
 
 	err_mask = ata_do_simple_cmd(dev, ATA_CMD_STANDBYNOW1);
 	if (err_mask) {
-		ata_dev_printk(dev, KERN_ERR, "failed to standby drive "
+		ata_dev_printk(dev, ATA_MSG_ERR, "failed to standby drive "
 			       "(err_mask=0x%x)\n", err_mask);
 		return -EIO;
 	}
@@ -5022,7 +5057,7 @@ static int ata_start_drive(struct ata_de
 
 	err_mask = ata_do_simple_cmd(dev, ATA_CMD_IDLEIMMEDIATE);
 	if (err_mask) {
-		ata_dev_printk(dev, KERN_ERR, "failed to start drive "
+		ata_dev_printk(dev, ATA_MSG_ERR, "failed to start drive "
 			       "(err_mask=0x%x)\n", err_mask);
 		return -EIO;
 	}
@@ -5112,7 +5147,8 @@ int ata_port_start (struct ata_port *ap)
 		return rc;
 	}
 
-	DPRINTK("prd alloc, virt %p, dma %llx\n", ap->prd, (unsigned long long) ap->prd_dma);
+	ata_port_printk(ap, ATA_MSG_DEBUG, "%s: prd alloc, virt %p, dma %llx\n",
+			__FUNCTION__, ap->prd, (unsigned long long) ap->prd_dma);
 
 	return 0;
 }
@@ -5158,7 +5194,7 @@ static void ata_host_remove(struct ata_p
 {
 	struct Scsi_Host *sh = ap->host;
 
-	DPRINTK("ENTER\n");
+	ata_port_printk(ap, ATA_MSG_TRACE, "%s: ENTER\n", __FUNCTION__);
 
 	if (do_unregister)
 		scsi_remove_host(sh);
@@ -5244,12 +5280,15 @@ static void ata_host_init(struct ata_por
 	ap->last_ctl = 0xFF;
 
 #if defined(ATA_VERBOSE_DEBUG)
-	/* turn on all debugging levels */
+	/* turn on all debugging levels; 0xFF is not exact but works in all the
+	 * cases */
 	ap->msg_enable = 0x00FF;
 #elif defined(ATA_DEBUG)
-	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_INFO | ATA_MSG_CTL | ATA_MSG_WARN | ATA_MSG_ERR;
+	ap->msg_enable = (1 << ATA_MSG_DEBUG) | (1 << ATA_MSG_INFO) | 
+		(1 << ATA_MSG_WARN) | (1 << ATA_MSG_ERR);
 #else
-	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_ERR | ATA_MSG_WARN;
+	ap->msg_enable = (1 << ATA_MSG_INFO) | (1 << ATA_MSG_WARN) | 
+		(1 << ATA_MSG_ERR);
 #endif
 
 	INIT_WORK(&ap->port_task, NULL, NULL);
@@ -5354,6 +5393,7 @@ int ata_device_add(const struct ata_prob
 	unsigned int count = 0, i;
 	struct device *dev = ent->dev;
 	struct ata_host_set *host_set;
+	struct ata_port *ap;
 	int rc;
 
 	DPRINTK("ENTER\n");
@@ -5374,7 +5414,6 @@ int ata_device_add(const struct ata_prob
 
 	/* register each port bound to this device */
 	for (i = 0; i < ent->n_ports; i++) {
-		struct ata_port *ap;
 		unsigned long xfer_mode_mask;
 
 		ap = ata_host_add(ent, host_set, i);
@@ -5387,7 +5426,7 @@ int ata_device_add(const struct ata_prob
 				(ap->pio_mask << ATA_SHIFT_PIO);
 
 		/* print per-port info to dmesg */
-		ata_port_printk(ap, KERN_INFO, "%cATA max %s cmd 0x%lX "
+		ata_port_printk(ap, ATA_MSG_INFO, "%cATA max %s cmd 0x%lX "
 				"ctl 0x%lX bmdma 0x%lX irq %lu\n",
 				ap->flags & ATA_FLAG_SATA ? 'S' : 'P',
 				ata_mode_string(xfer_mode_mask),
@@ -5409,13 +5448,13 @@ int ata_device_add(const struct ata_prob
 	rc = request_irq(ent->irq, ent->port_ops->irq_handler, ent->irq_flags,
 			 DRV_NAME, host_set);
 	if (rc) {
-		dev_printk(KERN_ERR, dev, "irq %lu request failed: %d\n",
+		ata_port_printk(ap, ATA_MSG_ERR, "irq %lu request failed: %d\n",
 			   ent->irq, rc);
 		goto err_out;
 	}
 
 	/* perform each probe synchronously */
-	DPRINTK("probe begin\n");
+	ata_port_printk(ap, ATA_MSG_DEBUG, "%s: probe begin\n", __FUNCTION__);
 	for (i = 0; i < count; i++) {
 		struct ata_port *ap;
 		u32 scontrol;
@@ -5432,7 +5471,7 @@ int ata_device_add(const struct ata_prob
 
 		rc = scsi_add_host(ap->host, dev);
 		if (rc) {
-			ata_port_printk(ap, KERN_ERR, "scsi_add_host failed\n");
+			ata_port_printk(ap, ATA_MSG_ERR, "scsi_add_host failed\n");
 			/* FIXME: do something useful here */
 			/* FIXME: handle unconditional calls to
 			 * scsi_scan_host and ata_host_remove, below,
@@ -5459,9 +5498,15 @@ int ata_device_add(const struct ata_prob
 			/* wait for EH to finish */
 			ata_port_wait_eh(ap);
 		} else {
-			DPRINTK("ata%u: bus probe begin\n", ap->id);
+			ata_port_printk(ap, ATA_MSG_DEBUG, 
+					"%s: ata%u: bus probe begin\n", 
+					__FUNCTION__, ap->id);
+
 			rc = ata_bus_probe(ap);
-			DPRINTK("ata%u: bus probe end\n", ap->id);
+
+			ata_port_printk(ap, ATA_MSG_DEBUG, 
+					"%s: ata%u: bus probe end\n", 
+					__FUNCTION__, ap->id);
 
 			if (rc) {
 				/* FIXME: do something useful here?
@@ -5475,7 +5520,8 @@ int ata_device_add(const struct ata_prob
 	}
 
 	/* probes are done, now scan each port's disk(s) */
-	DPRINTK("host probe begin\n");
+	ata_port_printk(ap, ATA_MSG_DEBUG, "%s: host probe begin\n",
+			__FUNCTION__);
 	for (i = 0; i < count; i++) {
 		struct ata_port *ap = host_set->ports[i];
 
@@ -5616,12 +5662,12 @@ int ata_scsi_release(struct Scsi_Host *h
 {
 	struct ata_port *ap = ata_shost_to_port(host);
 
-	DPRINTK("ENTER\n");
+	ata_port_printk(ap, ATA_MSG_TRACE, "%s: ENTER\n", __FUNCTION__);
 
 	ap->ops->port_disable(ap);
 	ata_host_remove(ap, 0);
 
-	DPRINTK("EXIT\n");
+	ata_port_printk(ap, ATA_MSG_TRACE, "%s: EXIT\n", __FUNCTION__);
 	return 1;
 }
 

		
___________________________________________________________ 
Telefonate ohne weitere Kosten vom PC zum PC: http://messenger.yahoo.de

