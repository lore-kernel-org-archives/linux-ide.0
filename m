From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: [PATCH 2/n] libata-core.c conversion to new debug scheme, part 2 of $N (50% done)
Date: Mon, 26 Jun 2006 10:22:45 +0200
Message-ID: <20060626082245.GA9105@zmei.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp105.plus.mail.re2.yahoo.com ([206.190.53.30]:20841 "HELO
	smtp105.plus.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030663AbWF0GP7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Jun 2006 02:15:59 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com

Hi Jeff, 
   here's a rehash of the second patch for libata-core.c

   The second 25% of libata-core.c converted to the new debugging scheme.

   Signed-off-by: <petkov@math.uni-muenster.de>


--- libata-dev/drivers/scsi/libata-core.c.orig	2006-06-26 10:05:24.000000000 +0200
+++ libata-dev/drivers/scsi/libata-core.c	2006-06-26 10:15:03.000000000 +0200
@@ -1618,11 +1618,13 @@ static void sata_print_link_status(struc
 
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
@@ -1778,7 +1780,8 @@ int sata_down_spd_limit(struct ata_port 
 
 	ap->sata_spd_limit = mask;
 
-	ata_port_printk(ap, KERN_WARNING, "limiting SATA link speed to %s\n",
+	if (ata_msg_warn(ap))
+		ata_port_printk(ap, KERN_WARNING, "limiting SATA link speed to %s\n",
 			sata_spd_string(fls(mask)));
 
 	return 0;
@@ -2041,7 +2044,8 @@ int ata_down_xfermask_limit(struct ata_d
 	ata_unpack_xfermask(xfer_mask, &dev->pio_mask, &dev->mwdma_mask,
 			    &dev->udma_mask);
 
-	ata_dev_printk(dev, KERN_WARNING, "limiting speed to %s\n",
+	if (ata_msg_warn(dev->ap))
+		ata_dev_printk(dev, KERN_WARNING, "limiting speed to %s\n",
 		       ata_mode_string(xfer_mask));
 
 	return 0;
@@ -2061,7 +2065,8 @@ static int ata_dev_set_mode(struct ata_d
 
 	err_mask = ata_dev_set_xfermode(dev);
 	if (err_mask) {
-		ata_dev_printk(dev, KERN_ERR, "failed to set xfermode "
+		if (ata_msg_err(dev->ap))
+			ata_dev_printk(dev, KERN_ERR, "failed to set xfermode "
 			       "(err_mask=0x%x)\n", err_mask);
 		return -EIO;
 	}
@@ -2070,10 +2075,13 @@ static int ata_dev_set_mode(struct ata_d
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
@@ -2142,7 +2150,8 @@ int ata_set_mode(struct ata_port *ap, st
 			continue;
 
 		if (!dev->pio_mode) {
-			ata_dev_printk(dev, KERN_WARNING, "no PIO support\n");
+			if (ata_msg_warn(ap))
+				ata_dev_printk(dev, KERN_WARNING, "no PIO support\n");
 			rc = -EINVAL;
 			goto out;
 		}
@@ -2241,7 +2250,8 @@ unsigned int ata_busy_sleep (struct ata_
 	}
 
 	if (status & ATA_BUSY)
-		ata_port_printk(ap, KERN_WARNING,
+		if (ata_msg_warn(ap))
+			ata_port_printk(ap, KERN_WARNING,
 				"port is slow to respond, please be patient\n");
 
 	timeout = timer_start + tmout;
@@ -2251,7 +2261,8 @@ unsigned int ata_busy_sleep (struct ata_
 	}
 
 	if (status & ATA_BUSY) {
-		ata_port_printk(ap, KERN_ERR, "port failed to respond "
+		if (ata_msg_err(ap))
+			ata_port_printk(ap, KERN_ERR, "port failed to respond "
 				"(%lu secs)\n", tmout / HZ);
 		return 1;
 	}
@@ -2311,7 +2322,10 @@ static unsigned int ata_bus_softreset(st
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 
-	DPRINTK("ata%u: bus reset via SRST\n", ap->id);
+	if (ata_msg_ctl(ap))
+		ata_port_printk(ap, KERN_DEBUG,	
+			"%s: ata%u: bus reset via SRST\n", 
+			__FUNCTION__, ap->id);
 
 	/* software reset.  causes dev0 to be selected */
 	if (ap->flags & ATA_FLAG_MMIO) {
@@ -2345,7 +2359,8 @@ static unsigned int ata_bus_softreset(st
 	 * pulldown resistor.
 	 */
 	if (ata_check_status(ap) == 0xFF) {
-		ata_port_printk(ap, KERN_ERR, "SRST failed (status 0xFF)\n");
+		if (ata_msg_err(ap))
+			ata_port_printk(ap, KERN_ERR, "SRST failed (status 0xFF)\n");
 		return AC_ERR_OTHER;
 	}
 
@@ -2381,7 +2396,10 @@ void ata_bus_reset(struct ata_port *ap)
 	u8 err;
 	unsigned int dev0, dev1 = 0, devmask = 0;
 
-	DPRINTK("ENTER, host %u, port %u\n", ap->id, ap->port_no);
+	if (ata_msg_ctl(ap))
+		ata_port_printk(ap, KERN_DEBUG, 
+			"%s: ENTER, host %u, port %u\n", 
+			__FUNCTION__, ap->id, ap->port_no);
 
 	/* determine if device 0/1 are present */
 	if (ap->flags & ATA_FLAG_SATA_RESET)
@@ -2435,14 +2453,18 @@ void ata_bus_reset(struct ata_port *ap)
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
 
 /**
@@ -2641,7 +2663,8 @@ int ata_std_softreset(struct ata_port *a
 	unsigned int devmask = 0, err_mask;
 	u8 err;
 
-	DPRINTK("ENTER\n");
+	if (ata_msg_ctl(ap))
+		ata_port_printk(ap, KERN_DEBUG, "%s: ENTER\n", __FUNCTION__);
 
 	if (ata_port_offline(ap)) {
 		classes[0] = ATA_DEV_NONE;
@@ -2658,11 +2681,16 @@ int ata_std_softreset(struct ata_port *a
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
 
@@ -2672,7 +2700,10 @@ int ata_std_softreset(struct ata_port *a
 		classes[1] = ata_dev_try_classify(ap, 1, &err);
 
  out:
-	DPRINTK("EXIT, classes[0]=%u [1]=%u\n", classes[0], classes[1]);
+	if (ata_msg_ctl(ap))
+		ata_port_printk(ap, KERN_DEBUG, 
+			"%s: EXIT, classes[0]=%u [1]=%u\n", 
+			__FUNCTION__, classes[0], classes[1]);
 	return 0;
 }
 
@@ -2694,7 +2725,9 @@ int sata_std_hardreset(struct ata_port *
 	u32 scontrol;
 	int rc;
 
-	DPRINTK("ENTER\n");
+	if (ata_msg_ctl(ap))
+		ata_port_printk(ap, KERN_DEBUG, 
+			"%s: ENTER\n", __FUNCTION__);
 
 	if (sata_set_spd_needed(ap)) {
 		/* SATA spec says nothing about how to reconfigure
@@ -2733,12 +2766,15 @@ int sata_std_hardreset(struct ata_port *
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
@@ -2747,7 +2783,9 @@ int sata_std_hardreset(struct ata_port *
 
 	*class = ata_dev_try_classify(ap, 0, NULL);
 
-	DPRINTK("EXIT, class=%u\n", *class);
+	if (ata_msg_ctl(ap))
+		ata_port_printk(ap, KERN_DEBUG, "%s: EXIT, class=%u\n", 
+				__FUNCTION__, *class);
 	return 0;
 }
 
@@ -2767,7 +2805,8 @@ void ata_std_postreset(struct ata_port *
 {
 	u32 serror;
 
-	DPRINTK("ENTER\n");
+	if (ata_msg_ctl(ap))
+		ata_port_printk(ap, KERN_DEBUG, "%s: ENTER\n", __FUNCTION__);
 
 	/* print link status */
 	sata_print_link_status(ap);
@@ -2791,7 +2830,9 @@ void ata_std_postreset(struct ata_port *
 
 	/* bail out if no device is present */
 	if (classes[0] == ATA_DEV_NONE && classes[1] == ATA_DEV_NONE) {
-		DPRINTK("EXIT, no device\n");
+		if (ata_msg_ctl(ap))
+			ata_port_printk(ap, KERN_DEBUG, 
+				"%s: EXIT, no device\n", __FUNCTION__);
 		return;
 	}
 
@@ -2803,7 +2844,8 @@ void ata_std_postreset(struct ata_port *
 			outb(ap->ctl, ap->ioaddr.ctl_addr);
 	}
 
-	DPRINTK("EXIT\n");
+	if (ata_msg_ctl(ap))
+		ata_port_printk(ap, KERN_DEBUG, "%s: EXIT\n", __FUNCTION__);
 }
 
 /**
@@ -2830,8 +2872,10 @@ static int ata_dev_same_device(struct at
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
 
@@ -2842,19 +2886,22 @@ static int ata_dev_same_device(struct at
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
@@ -2908,7 +2955,9 @@ int ata_dev_revalidate(struct ata_device
 		return 0;
 
  fail:
-	ata_dev_printk(dev, KERN_ERR, "revalidation failed (errno=%d)\n", rc);
+	if (ata_msg_err(dev->ap))
+		ata_dev_printk(dev, KERN_ERR, 
+				"revalidation failed (errno=%d)\n", rc);
 	return rc;
 }
 

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de

