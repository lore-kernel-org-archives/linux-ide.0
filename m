From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: [PATCH 2/n] libata-core.c conversion to new debugging scheme, part 2 (50% done)
Date: Sat, 3 Jun 2006 08:45:36 +0200
Message-ID: <20060603064536.GA8111@zmei.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp105.plus.mail.re2.yahoo.com ([206.190.53.30]:34687 "HELO
	smtp105.plus.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751414AbWFDFum (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 4 Jun 2006 01:50:42 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com

This one converts the second quarter of libata-core.c to the new dbg scheme. It
also sets the initial debug levels according to predefined ATA_* macros.

Signed-off-by: <petkov@uni-muenster.de>


--- libata-dev/drivers/scsi/libata-core.c.orig1	2006-06-01 07:02:42.000000000 +0200
+++ libata-dev/drivers/scsi/libata-core.c	2006-06-03 08:34:36.000000000 +0200
@@ -1613,11 +1613,13 @@ static void sata_print_link_status(struc
 
 	if (ata_port_online(ap)) {
 		tmp = (sstatus >> 4) & 0xf;
-		ata_port_printk(ap, KERN_INFO,
+		if (ata_msg_info(ap))
+			ata_port_printk(ap, KERN_INFO,
 				"SATA link up %s (SStatus %X SControl %X)\n",
 				sata_spd_string(tmp), sstatus, scontrol);
 	} else {
-		ata_port_printk(ap, KERN_INFO,
+		if (ata_msg_info(ap))
+			ata_port_printk(ap, KERN_INFO,
 				"SATA link down (SStatus %X SControl %X)\n",
 				sstatus, scontrol);
 	}
@@ -1773,7 +1775,8 @@ int sata_down_spd_limit(struct ata_port 
 
 	ap->sata_spd_limit = mask;
 
-	ata_port_printk(ap, KERN_WARNING, "limiting SATA link speed to %s\n",
+	if (ata_msg_warn(ap))
+		ata_port_printk(ap, KERN_WARNING, "limiting SATA link speed to %s\n",
 			sata_spd_string(fls(mask)));
 
 	return 0;
@@ -2036,7 +2039,8 @@ int ata_down_xfermask_limit(struct ata_d
 	ata_unpack_xfermask(xfer_mask, &dev->pio_mask, &dev->mwdma_mask,
 			    &dev->udma_mask);
 
-	ata_dev_printk(dev, KERN_WARNING, "limiting speed to %s\n",
+	if (ata_msg_warn(dev->ap))
+		ata_dev_printk(dev, KERN_WARNING, "limiting speed to %s\n",
 		       ata_mode_string(xfer_mask));
 
 	return 0;
@@ -2056,7 +2060,8 @@ static int ata_dev_set_mode(struct ata_d
 
 	err_mask = ata_dev_set_xfermode(dev);
 	if (err_mask) {
-		ata_dev_printk(dev, KERN_ERR, "failed to set xfermode "
+		if (ata_msg_err(dev->ap))
+			ata_dev_printk(dev, KERN_ERR, "failed to set xfermode "
 			       "(err_mask=0x%x)\n", err_mask);
 		return -EIO;
 	}
@@ -2065,10 +2070,13 @@ static int ata_dev_set_mode(struct ata_d
 	if (rc)
 		return rc;
 
-	DPRINTK("xfer_shift=%u, xfer_mode=0x%x\n",
-		dev->xfer_shift, (int)dev->xfer_mode);
+	if (ata_msg_ctl(dev->ap))
+		ata_dev_printk(dev, KERN_DEBUG, 
+			"%s: xfer_shift=%u, xfer_mode=0x%x\n",
+			__FUNCTION__, dev->xfer_shift, (int)dev->xfer_mode);
 
-	ata_dev_printk(dev, KERN_INFO, "configured for %s\n",
+	if (ata_msg_info(dev->ap))
+		ata_dev_printk(dev, KERN_INFO, "configured for %s\n",
 		       ata_mode_string(ata_xfer_mode2mask(dev->xfer_mode)));
 	return 0;
 }
@@ -2137,7 +2145,8 @@ int ata_set_mode(struct ata_port *ap, st
 			continue;
 
 		if (!dev->pio_mode) {
-			ata_dev_printk(dev, KERN_WARNING, "no PIO support\n");
+			if (ata_msg_warn(ap))
+				ata_dev_printk(dev, KERN_WARNING, "no PIO support\n");
 			rc = -EINVAL;
 			goto out;
 		}
@@ -2236,7 +2245,8 @@ unsigned int ata_busy_sleep (struct ata_
 	}
 
 	if (status & ATA_BUSY)
-		ata_port_printk(ap, KERN_WARNING,
+		if (ata_msg_warn(ap))
+			ata_port_printk(ap, KERN_WARNING,
 				"port is slow to respond, please be patient\n");
 
 	timeout = timer_start + tmout;
@@ -2246,7 +2256,8 @@ unsigned int ata_busy_sleep (struct ata_
 	}
 
 	if (status & ATA_BUSY) {
-		ata_port_printk(ap, KERN_ERR, "port failed to respond "
+		if (ata_msg_err(ap))
+			ata_port_printk(ap, KERN_ERR, "port failed to respond "
 				"(%lu secs)\n", tmout / HZ);
 		return 1;
 	}
@@ -2306,7 +2317,10 @@ static unsigned int ata_bus_softreset(st
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 
-	DPRINTK("ata%u: bus reset via SRST\n", ap->id);
+	if (ata_msg_ctl(ap))
+		ata_port_printk(ap, KERN_DEBUG,	
+			"%s: ata%u: bus reset via SRST\n", 
+			__FUNCTION__, ap->id);
 
 	/* software reset.  causes dev0 to be selected */
 	if (ap->flags & ATA_FLAG_MMIO) {
@@ -2340,7 +2354,8 @@ static unsigned int ata_bus_softreset(st
 	 * pulldown resistor.
 	 */
 	if (ata_check_status(ap) == 0xFF) {
-		ata_port_printk(ap, KERN_ERR, "SRST failed (status 0xFF)\n");
+		if (ata_msg_err(ap))
+			ata_port_printk(ap, KERN_ERR, "SRST failed (status 0xFF)\n");
 		return AC_ERR_OTHER;
 	}
 
@@ -2376,7 +2391,10 @@ void ata_bus_reset(struct ata_port *ap)
 	u8 err;
 	unsigned int dev0, dev1 = 0, devmask = 0;
 
-	DPRINTK("ENTER, host %u, port %u\n", ap->id, ap->port_no);
+	if (ata_msg_ctl(ap))
+		ata_port_printk(ap, KERN_DEBUG, 
+			"%s: ENTER, host %u, port %u\n", 
+			__FUNCTION__, ap->id, ap->port_no);
 
 	/* determine if device 0/1 are present */
 	if (ap->flags & ATA_FLAG_SATA_RESET)
@@ -2430,14 +2448,18 @@ void ata_bus_reset(struct ata_port *ap)
 			outb(ap->ctl, ioaddr->ctl_addr);
 	}
 
-	DPRINTK("EXIT\n");
+	if (ata_msg_ctl(ap))
+		ata_port_printk(ap, KERN_DEBUG, "%s: EXIT\n", __FUNCTION__);
 	return;
 
 err_out:
-	ata_port_printk(ap, KERN_ERR, "disabling port\n");
+	if (ata_msg_err(ap))
+		ata_port_printk(ap, KERN_ERR, "disabling port\n");
 	ap->ops->port_disable(ap);
 
-	DPRINTK("EXIT\n");
+	if (ata_msg_ctl(ap))
+		ata_port_printk(ap, KERN_DEBUG, "%s: EXIT (err_out)\n",
+				__FUNCTION__);
 }
 
 static int sata_phy_resume(struct ata_port *ap)
@@ -2517,7 +2539,8 @@ int ata_std_softreset(struct ata_port *a
 	unsigned int devmask = 0, err_mask;
 	u8 err;
 
-	DPRINTK("ENTER\n");
+	if (ata_msg_ctl(ap))
+		ata_port_printk(ap, KERN_DEBUG, "%s: ENTER\n", __FUNCTION__);
 
 	if (ata_port_offline(ap)) {
 		classes[0] = ATA_DEV_NONE;
@@ -2534,11 +2557,16 @@ int ata_std_softreset(struct ata_port *a
 	ap->ops->dev_select(ap, 0);
 
 	/* issue bus reset */
-	DPRINTK("about to softreset, devmask=%x\n", devmask);
+	if (ata_msg_ctl(ap))
+		ata_port_printk(ap, KERN_DEBUG, 
+			"%s: about to softreset, devmask=%x\n", 
+			__FUNCTION__, devmask);
+
 	err_mask = ata_bus_softreset(ap, devmask);
 	if (err_mask) {
-		ata_port_printk(ap, KERN_ERR, "SRST failed (err_mask=0x%x)\n",
-				err_mask);
+		if (ata_msg_err(ap))
+			ata_port_printk(ap, KERN_ERR, 
+				"SRST failed (err_mask=0x%x)\n", err_mask);
 		return -EIO;
 	}
 
@@ -2548,7 +2576,10 @@ int ata_std_softreset(struct ata_port *a
 		classes[1] = ata_dev_try_classify(ap, 1, &err);
 
  out:
-	DPRINTK("EXIT, classes[0]=%u [1]=%u\n", classes[0], classes[1]);
+	if (ata_msg_ctl(ap))
+		ata_port_printk(ap, KERN_DEBUG, 
+			"%s: EXIT, classes[0]=%u [1]=%u\n", 
+			__FUNCTION__, classes[0], classes[1]);
 	return 0;
 }
 
@@ -2572,7 +2603,9 @@ int sata_std_hardreset(struct ata_port *
 	u32 scontrol;
 	int rc;
 
-	DPRINTK("ENTER\n");
+	if (ata_msg_ctl(ap))
+		ata_port_printk(ap, KERN_DEBUG, 
+			"%s: ENTER\n", __FUNCTION__);
 
 	if (sata_set_spd_needed(ap)) {
 		/* SATA spec says nothing about how to reconfigure
@@ -2611,12 +2644,15 @@ int sata_std_hardreset(struct ata_port *
 	/* TODO: phy layer with polling, timeouts, etc. */
 	if (ata_port_offline(ap)) {
 		*class = ATA_DEV_NONE;
-		DPRINTK("EXIT, link offline\n");
+		if (ata_msg_ctl(ap))
+			ata_port_printk(ap, KERN_DEBUG, 
+				"%s: EXIT, link offline\n", __FUNCTION__);
 		return 0;
 	}
 
 	if (ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT)) {
-		ata_port_printk(ap, KERN_ERR,
+		if (ata_msg_err(ap))
+			ata_port_printk(ap, KERN_ERR,
 				"COMRESET failed (device not ready)\n");
 		return -EIO;
 	}
@@ -2625,7 +2661,9 @@ int sata_std_hardreset(struct ata_port *
 
 	*class = ata_dev_try_classify(ap, 0, NULL);
 
-	DPRINTK("EXIT, class=%u\n", *class);
+	if (ata_msg_ctl(ap))
+		ata_port_printk(ap, KERN_DEBUG, "%s: EXIT, class=%u\n", 
+				__FUNCTION__, *class);
 	return 0;
 }
 
@@ -2648,7 +2686,8 @@ void ata_std_postreset(struct ata_port *
 {
 	u32 serror;
 
-	DPRINTK("ENTER\n");
+	if (ata_msg_ctl(ap))
+		ata_port_printk(ap, KERN_DEBUG, "%s: ENTER\n", __FUNCTION__);
 
 	/* print link status */
 	sata_print_link_status(ap);
@@ -2672,7 +2711,9 @@ void ata_std_postreset(struct ata_port *
 
 	/* bail out if no device is present */
 	if (classes[0] == ATA_DEV_NONE && classes[1] == ATA_DEV_NONE) {
-		DPRINTK("EXIT, no device\n");
+		if (ata_msg_ctl(ap))
+			ata_port_printk(ap, KERN_DEBUG, 
+				"%s: EXIT, no device\n", __FUNCTION__);
 		return;
 	}
 
@@ -2684,7 +2725,8 @@ void ata_std_postreset(struct ata_port *
 			outb(ap->ctl, ap->ioaddr.ctl_addr);
 	}
 
-	DPRINTK("EXIT\n");
+	if (ata_msg_ctl(ap))
+		ata_port_printk(ap, KERN_DEBUG, "%s: EXIT\n", __FUNCTION__);
 }
 
 /**
@@ -2786,7 +2828,8 @@ int ata_drive_probe_reset(struct ata_por
 		rc = ata_do_reset(ap, softreset, classes);
 		if (rc == 0 && classes[0] != ATA_DEV_UNKNOWN)
 			goto done;
-		ata_port_printk(ap, KERN_INFO, "softreset failed, "
+		if (ata_msg_info(ap))
+			ata_port_printk(ap, KERN_INFO, "softreset failed, "
 				"will try hardreset in 5 secs\n");
 		ssleep(5);
 	}
@@ -2805,13 +2848,15 @@ int ata_drive_probe_reset(struct ata_por
 		if (sata_down_spd_limit(ap))
 			goto done;
 
-		ata_port_printk(ap, KERN_INFO, "hardreset failed, "
+		if (ata_msg_info(ap))
+			ata_port_printk(ap, KERN_INFO, "hardreset failed, "
 				"will retry in 5 secs\n");
 		ssleep(5);
 	}
 
 	if (softreset) {
-		ata_port_printk(ap, KERN_INFO,
+		if (ata_msg_info(ap))
+			ata_port_printk(ap, KERN_INFO,
 				"hardreset succeeded without classification, "
 				"will retry softreset in 5 secs\n");
 		ssleep(5);
@@ -2856,8 +2901,10 @@ static int ata_dev_same_device(struct at
 	u64 new_n_sectors;
 
 	if (dev->class != new_class) {
-		ata_dev_printk(dev, KERN_INFO, "class mismatch %d != %d\n",
-			       dev->class, new_class);
+		if (ata_msg_info(dev->ap))
+			ata_dev_printk(dev, KERN_INFO, 
+				"class mismatch %d != %d\n",
+				dev->class, new_class);
 		return 0;
 	}
 
@@ -2868,19 +2915,22 @@ static int ata_dev_same_device(struct at
 	new_n_sectors = ata_id_n_sectors(new_id);
 
 	if (strcmp(model[0], model[1])) {
-		ata_dev_printk(dev, KERN_INFO, "model number mismatch "
+		if (ata_msg_info(dev->ap))
+			ata_dev_printk(dev, KERN_INFO, "model number mismatch "
 			       "'%s' != '%s'\n", model[0], model[1]);
 		return 0;
 	}
 
 	if (strcmp(serial[0], serial[1])) {
-		ata_dev_printk(dev, KERN_INFO, "serial number mismatch "
-			       "'%s' != '%s'\n", serial[0], serial[1]);
+		if (ata_msg_info(dev->ap))
+			ata_dev_printk(dev, KERN_INFO, "serial number mismatch"
+			       " '%s' != '%s'\n", serial[0], serial[1]);
 		return 0;
 	}
 
 	if (dev->class == ATA_DEV_ATA && dev->n_sectors != new_n_sectors) {
-		ata_dev_printk(dev, KERN_INFO, "n_sectors mismatch "
+		if (ata_msg_info(dev->ap))
+			ata_dev_printk(dev, KERN_INFO, "n_sectors mismatch "
 			       "%llu != %llu\n",
 			       (unsigned long long)dev->n_sectors,
 			       (unsigned long long)new_n_sectors);
@@ -5200,7 +5250,15 @@ static void ata_host_init(struct ata_por
 	ap->sata_spd_limit = UINT_MAX;
 	ap->active_tag = ATA_TAG_POISON;
 	ap->last_ctl = 0xFF;
-	ap->msg_enable = ATA_MSG_DRV;
+
+#if defined(ATA_VERBOSE_DEBUG)
+	/* turn on all debugging levels */
+	ap->msg_enable = 0x00FF;
+#elif defined(ATA_DEBUG)
+	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_INFO | ATA_MSG_CTL | ATA_MSG_WARN | ATA_MSG_ERR;
+#else 
+	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_ERR;
+#endif
 
 	INIT_WORK(&ap->port_task, NULL, NULL);
 	INIT_LIST_HEAD(&ap->eh_done_q);

	

	
		
___________________________________________________________ 
Telefonate ohne weitere Kosten vom PC zum PC: http://messenger.yahoo.de

