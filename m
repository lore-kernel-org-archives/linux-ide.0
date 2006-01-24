From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: PATCH convert libata-core to the new debugging scheme
Date: Tue, 24 Jan 2006 10:07:24 +0100
Message-ID: <20060124090724.GA7897@gollum.tnic>
References: <20060117105702.5e5a5cb5.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:35506 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1030404AbWAXKBl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 Jan 2006 05:01:41 -0500
Content-Disposition: inline
In-Reply-To: <20060117105702.5e5a5cb5.randy_d_dunlap@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Tue, Jan 17, 2006 at 10:57:02AM -0800, Randy Dunlap wrote:
Hi Jeff, Randy,
   
   here's a rehash against 2.6.16-rc1 of the 2nd patch I sent then but it somehow 
   got lost along the way. It converts the libata-core.c to the new debugging scheme.

   Problem: In the ata_dev_classify() function we don't have access to an 
   ata_host struct probably because we're still probing so maybe we'll have to 
   print debugging statements in a different manner. Same for early init 
   routines like ata_device_add(),  ata_probe_ent_alloc(), ata_pci_init_one().

   Also, Jeff, if you'd still like to have a way of setting/getting debugging 
   levels from userspace, please elaborate more on that so that I have some
   directions (ioctl, proc, etc).

   Thanks,
   Boris.

   p.s. Please CC me since I'm not subscribed to the linux-ide ML.

   Signed-off-by: Borislav Petkov <petkov@uni-muenster.de>


--- 16-rc1/drivers/scsi/libata-core.c.orig	2006-01-21 09:42:53.000000000 +0100
+++ 16-rc1/drivers/scsi/libata-core.c	2006-01-24 09:58:00.000000000 +0100
@@ -115,13 +115,15 @@ static void ata_tf_load_pio(struct ata_p
 		outb(tf->hob_lbal, ioaddr->lbal_addr);
 		outb(tf->hob_lbam, ioaddr->lbam_addr);
 		outb(tf->hob_lbah, ioaddr->lbah_addr);
-		VPRINTK("hob: feat 0x%X nsect 0x%X, lba 0x%X 0x%X 0x%X\n",
-			tf->hob_feature,
-			tf->hob_nsect,
-			tf->hob_lbal,
-			tf->hob_lbam,
-			tf->hob_lbah);
-	}
+		if (ata_msg_ctl(ap)) 
+			printk(KERN_DEBUG "%s: hob: feat 0x%X nsect 0x%X, lba 0x%X 0x%X 0x%X\n",
+				__FUNCTION__,
+				tf->hob_feature,
+				tf->hob_nsect,
+				tf->hob_lbal,
+				tf->hob_lbam,
+				tf->hob_lbah);
+		}
 
 	if (is_addr) {
 		outb(tf->feature, ioaddr->feature_addr);
@@ -129,17 +131,20 @@ static void ata_tf_load_pio(struct ata_p
 		outb(tf->lbal, ioaddr->lbal_addr);
 		outb(tf->lbam, ioaddr->lbam_addr);
 		outb(tf->lbah, ioaddr->lbah_addr);
-		VPRINTK("feat 0x%X nsect 0x%X lba 0x%X 0x%X 0x%X\n",
-			tf->feature,
-			tf->nsect,
-			tf->lbal,
-			tf->lbam,
-			tf->lbah);
+		if (ata_msg_ctl(ap))
+				printk(KERN_DEBUG "%s: feat 0x%X nsect 0x%X lba 0x%X 0x%X 0x%X\n",
+					__FUNCTION__,
+					tf->feature,
+					tf->nsect,
+					tf->lbal,
+					tf->lbam,
+					tf->lbah);
 	}
 
 	if (tf->flags & ATA_TFLAG_DEVICE) {
 		outb(tf->device, ioaddr->device_addr);
-		VPRINTK("device 0x%X\n", tf->device);
+		if (ata_msg_ctl(ap))
+			printk(KERN_DEBUG "%s: device 0x%X\n", __FUNCTION__, tf->device);
 	}
 
 	ata_wait_idle(ap);
@@ -173,12 +178,14 @@ static void ata_tf_load_mmio(struct ata_
 		writeb(tf->hob_lbal, (void __iomem *) ioaddr->lbal_addr);
 		writeb(tf->hob_lbam, (void __iomem *) ioaddr->lbam_addr);
 		writeb(tf->hob_lbah, (void __iomem *) ioaddr->lbah_addr);
-		VPRINTK("hob: feat 0x%X nsect 0x%X, lba 0x%X 0x%X 0x%X\n",
-			tf->hob_feature,
-			tf->hob_nsect,
-			tf->hob_lbal,
-			tf->hob_lbam,
-			tf->hob_lbah);
+		if (ata_msg_ctl(ap))
+				printk(KERN_DEBUG "%s: hob: feat 0x%X nsect 0x%X, lba 0x%X 0x%X 0x%X\n",
+					__FUNCTION__,
+					tf->hob_feature,
+					tf->hob_nsect,
+					tf->hob_lbal,
+					tf->hob_lbam,
+					tf->hob_lbah);
 	}
 
 	if (is_addr) {
@@ -187,17 +194,20 @@ static void ata_tf_load_mmio(struct ata_
 		writeb(tf->lbal, (void __iomem *) ioaddr->lbal_addr);
 		writeb(tf->lbam, (void __iomem *) ioaddr->lbam_addr);
 		writeb(tf->lbah, (void __iomem *) ioaddr->lbah_addr);
-		VPRINTK("feat 0x%X nsect 0x%X lba 0x%X 0x%X 0x%X\n",
-			tf->feature,
-			tf->nsect,
-			tf->lbal,
-			tf->lbam,
-			tf->lbah);
+		if (ata_msg_ctl(ap))
+				printk(KERN_DEBUG "%s: feat 0x%X nsect 0x%X lba 0x%X 0x%X 0x%X\n",
+					__FUNCTION__,
+					tf->feature,
+					tf->nsect,
+					tf->lbal,
+					tf->lbam,
+					tf->lbah);
 	}
 
 	if (tf->flags & ATA_TFLAG_DEVICE) {
 		writeb(tf->device, (void __iomem *) ioaddr->device_addr);
-		VPRINTK("device 0x%X\n", tf->device);
+		if (ata_msg_ctl(ap))
+				printk(KERN_DEBUG "%s: device 0x%X\n", __FUNCTION__, tf->device);
 	}
 
 	ata_wait_idle(ap);
@@ -247,7 +257,9 @@ void ata_tf_load(struct ata_port *ap, co
 
 static void ata_exec_command_pio(struct ata_port *ap, const struct ata_taskfile *tf)
 {
-	DPRINTK("ata%u: cmd 0x%X\n", ap->id, tf->command);
+	if (ata_msg_ctl(ap))
+			printk(KERN_DEBUG "%s: ata%u: cmd 0x%X\n", 
+				__FUNCTION__, ap->id, tf->command);
 
        	outb(tf->command, ap->ioaddr.command_addr);
 	ata_pause(ap);
@@ -268,10 +280,12 @@ static void ata_exec_command_pio(struct 
 
 static void ata_exec_command_mmio(struct ata_port *ap, const struct ata_taskfile *tf)
 {
-	DPRINTK("ata%u: cmd 0x%X\n", ap->id, tf->command);
+		if (ata_msg_ctl(ap))
+				printk(KERN_DEBUG "%s: ata%u: cmd 0x%X\n", 
+					__FUNCTION__, ap->id, tf->command);
 
-       	writeb(tf->command, (void __iomem *) ap->ioaddr.command_addr);
-	ata_pause(ap);
+		writeb(tf->command, (void __iomem *) ap->ioaddr.command_addr);
+		ata_pause(ap);
 }
 
 
@@ -986,8 +1000,9 @@ void ata_std_dev_select (struct ata_port
 void ata_dev_select(struct ata_port *ap, unsigned int device,
 			   unsigned int wait, unsigned int can_sleep)
 {
-	VPRINTK("ENTER, ata%u: device %u, wait %u\n",
-		ap->id, device, wait);
+		if (ata_msg_ctl(ap))
+				printk(KERN_INFO "%s ENTER, ata%u: device %u, wait %u\n",
+					__FUNCTION__, ap->id, device, wait);
 
 	if (wait)
 		ata_wait_idle(ap);
@@ -1014,28 +1029,31 @@ void ata_dev_select(struct ata_port *ap,
 
 static inline void ata_dump_id(const struct ata_device *dev)
 {
-	DPRINTK("49==0x%04x  "
+	printk(KERN_INFO "%s: 49==0x%04x  "
 		"53==0x%04x  "
 		"63==0x%04x  "
 		"64==0x%04x  "
 		"75==0x%04x  \n",
+		__FUNCTION__,
 		dev->id[49],
 		dev->id[53],
 		dev->id[63],
 		dev->id[64],
 		dev->id[75]);
-	DPRINTK("80==0x%04x  "
+	printk(KERN_INFO "%s: 80==0x%04x  "
 		"81==0x%04x  "
 		"82==0x%04x  "
 		"83==0x%04x  "
 		"84==0x%04x  \n",
+		__FUNCTION__,
 		dev->id[80],
 		dev->id[81],
 		dev->id[82],
 		dev->id[83],
 		dev->id[84]);
-	DPRINTK("88==0x%04x  "
+	printk(KERN_INFO "%s: 88==0x%04x  "
 		"93==0x%04x\n",
+		__FUNCTION__,
 		dev->id[88],
 		dev->id[93]);
 }
@@ -1149,8 +1167,9 @@ ata_exec_internal(struct ata_port *ap, s
 		if (arg.waiting) {
 			qc->err_mask = AC_ERR_OTHER;
 			ata_qc_complete(qc);
-			printk(KERN_WARNING "ata%u: qc timeout (cmd 0x%x)\n",
-			       ap->id, command);
+			if (ata_msg_warn(ap))
+					printk(KERN_WARNING "ata%u: qc timeout (cmd 0x%x)\n",
+						ap->id, command);
 		}
 
 		spin_unlock_irqrestore(&ap->host_set->lock, flags);
@@ -1198,8 +1217,9 @@ static void ata_dev_identify(struct ata_
 	int rc;
 
 	if (!ata_dev_present(dev)) {
-		DPRINTK("ENTER/EXIT (host %u, dev %u) -- nodev\n",
-			ap->id, device);
+			if (ata_msg_probe(ap))
+					printk(KERN_INFO "%s: ENTER/EXIT (host %u, dev %u) -- nodev\n",
+						__FUNCTION__, ap->id, device);
 		return;
 	}
 
@@ -1208,7 +1228,9 @@ static void ata_dev_identify(struct ata_
 	else
 		using_edd = 1;
 
-	DPRINTK("ENTER, host %u, dev %u\n", ap->id, device);
+	if (ata_msg_probe(ap))
+			printk(KERN_INFO "%s: ENTER, host %u, dev %u\n", 
+				__FUNCTION__, ap->id, device);
 
 	assert (dev->class == ATA_DEV_ATA || dev->class == ATA_DEV_ATAPI ||
 		dev->class == ATA_DEV_NONE);
@@ -1220,10 +1242,12 @@ retry:
 
 	if (dev->class == ATA_DEV_ATA) {
 		tf.command = ATA_CMD_ID_ATA;
-		DPRINTK("do ATA identify\n");
+		if (ata_msg_probe(ap))
+				printk(KERN_INFO "%s: do ATA identify\n", __FUNCTION__);
 	} else {
 		tf.command = ATA_CMD_ID_ATAPI;
-		DPRINTK("do ATAPI identify\n");
+		if (ata_msg_probe(ap))
+				printk(KERN_INFO "%s: do ATAPI identify\n", __FUNCTION__);
 	}
 
 	tf.protocol = ATA_PROT_PIO;
@@ -1259,12 +1283,14 @@ retry:
 	swap_buf_le16(dev->id, ATA_ID_WORDS);
 
 	/* print device capabilities */
-	printk(KERN_DEBUG "ata%u: dev %u cfg "
-	       "49:%04x 82:%04x 83:%04x 84:%04x 85:%04x 86:%04x 87:%04x 88:%04x\n",
-	       ap->id, device, dev->id[49],
-	       dev->id[82], dev->id[83], dev->id[84],
-	       dev->id[85], dev->id[86], dev->id[87],
-	       dev->id[88]);
+	if (ata_msg_probe(ap))
+			printk(KERN_INFO "%s: ata%u: dev %u cfg "
+			"49:%04x 82:%04x 83:%04x 84:%04x 85:%04x 86:%04x 87:%04x 88:%04x\n",
+			__FUNCTION__,
+			ap->id, device, dev->id[49],
+			dev->id[82], dev->id[83], dev->id[84],
+			dev->id[85], dev->id[86], dev->id[87],
+			dev->id[88]);
 
 	/*
 	 * common ATA, ATAPI feature tests
@@ -1272,7 +1298,8 @@ retry:
 
 	/* we require DMA support (bits 8 of word 49) */
 	if (!ata_id_has_dma(dev->id)) {
-		printk(KERN_DEBUG "ata%u: no dma\n", ap->id);
+		if (ata_msg_probe(ap))
+				printk(KERN_INFO "%s: ata%u: no dma/lba\n", __FUNCTION__, ap->id);
 		goto err_out_nosup;
 	}
 
@@ -1283,7 +1310,8 @@ retry:
 	if (!xfer_modes)
 		xfer_modes = ata_pio_modes(dev);
 
-	ata_dump_id(dev);
+	if (ata_msg_probe(ap))
+			ata_dump_id(dev);
 
 	/* ATA-specific feature tests */
 	if (dev->class == ATA_DEV_ATA) {
@@ -1324,12 +1352,13 @@ retry:
 			}
 
 			/* print device info to dmesg */
-			printk(KERN_INFO "ata%u: dev %u ATA-%d, max %s, %Lu sectors:%s\n",
-			       ap->id, device,
-			       major_version,
-			       ata_mode_string(xfer_modes),
-			       (unsigned long long)dev->n_sectors,
-			       dev->flags & ATA_DFLAG_LBA48 ? " LBA48" : " LBA");
+			if (ata_msg_info(ap))
+					printk(KERN_INFO "ata%u: dev %u ATA-%d, max %s, %Lu sectors:%s\n",
+						ap->id, device,
+						major_version,
+						ata_mode_string(xfer_modes),
+						(unsigned long long)dev->n_sectors,
+						dev->flags & ATA_DFLAG_LBA48 ? " LBA48" : " LBA");
 		} else { 
 			/* CHS */
 
@@ -1349,7 +1378,9 @@ retry:
 			}
 
 			/* print device info to dmesg */
-			printk(KERN_INFO "ata%u: dev %u ATA-%d, max %s, %Lu sectors: CHS %d/%d/%d\n",
+			if (ata_msg_info(ap))
+					printk(KERN_INFO 
+						"ata%u: dev %u ATA-%d, max %s, %Lu sectors: CHS %d/%d/%d\n",
 			       ap->id, device,
 			       major_version,
 			       ata_mode_string(xfer_modes),
@@ -1368,27 +1399,34 @@ retry:
 
 		rc = atapi_cdb_len(dev->id);
 		if ((rc < 12) || (rc > ATAPI_CDB_LEN)) {
-			printk(KERN_WARNING "ata%u: unsupported CDB len\n", ap->id);
+				if (ata_msg_warn(ap))
+						printk(KERN_WARNING "ata%u: unsupported CDB len\n", ap->id);
 			goto err_out_nosup;
 		}
 		ap->cdb_len = (unsigned int) rc;
 		ap->host->max_cmd_len = (unsigned char) ap->cdb_len;
 
 		/* print device info to dmesg */
-		printk(KERN_INFO "ata%u: dev %u ATAPI, max %s\n",
-		       ap->id, device,
-		       ata_mode_string(xfer_modes));
+		if (ata_msg_info(ap))
+				printk(KERN_INFO "ata%u: dev %u ATAPI, max %s\n",
+					ap->id, device,
+					ata_mode_string(xfer_modes));
 	}
 
-	DPRINTK("EXIT, drv_stat = 0x%x\n", ata_chk_status(ap));
+	if (ata_msg_probe(ap))
+			printk("%s: EXIT, drv_stat = 0x%x\n", 
+				__FUNCTION__,
+				ata_chk_status(ap));
 	return;
 
 err_out_nosup:
-	printk(KERN_WARNING "ata%u: dev %u not supported, ignoring\n",
-	       ap->id, device);
+	if (ata_msg_warn(ap))
+			printk(KERN_WARNING "ata%u: dev %u not supported, ignoring\n",
+				ap->id, device);
 err_out:
 	dev->class++;	/* converts ATA_DEV_xxx into ATA_DEV_xxx_UNSUP */
-	DPRINTK("EXIT, err\n");
+	if (ata_msg_probe(ap))
+			printk(KERN_INFO "%s: EXIT, err\n", __FUNCTION__);
 }
 
 
@@ -1410,8 +1448,9 @@ void ata_dev_config(struct ata_port *ap,
 {
 	/* limit bridge transfers to udma5, 200 sectors */
 	if (ata_dev_knobble(ap)) {
-		printk(KERN_INFO "ata%u(%u): applying bridge limits\n",
-			ap->id, ap->device->devno);
+			if (ata_msg_info(ap))
+					printk(KERN_INFO "ata%u(%u): applying bridge limits\n",
+						ap->id, ap->device->devno);
 		ap->udma_mask &= ATA_UDMA5;
 		ap->host->max_sectors = ATA_MAX_SECTORS;
 		ap->host->hostt->max_sectors = ATA_MAX_SECTORS;
@@ -1531,12 +1570,14 @@ void __sata_phy_reset(struct ata_port *a
 			speed = "3.0";
 		else
 			speed = "<unknown>";
-		printk(KERN_INFO "ata%u: SATA link up %s Gbps (SStatus %X)\n",
-		       ap->id, speed, sstatus);
+		if (ata_msg_probe(ap))
+				printk(KERN_INFO "ata%u: SATA link up %s Gbps (SStatus %X)\n",
+					ap->id, speed, sstatus);
 		ata_port_probe(ap);
 	} else {
-		printk(KERN_INFO "ata%u: SATA link down (SStatus %X)\n",
-		       ap->id, sstatus);
+			if (ata_msg_probe(ap))
+					printk(KERN_INFO "ata%u: SATA link down (SStatus %X)\n",
+						ap->id, sstatus);
 		ata_port_disable(ap);
 	}
 
@@ -1776,11 +1817,14 @@ static void ata_dev_set_mode(struct ata_
 	idx = ofs + dev->xfer_shift;
 	WARN_ON(idx >= ARRAY_SIZE(xfer_mode_str));
 
-	DPRINTK("idx=%d xfer_shift=%u, xfer_mode=0x%x, base=0x%x, offset=%d\n",
-		idx, dev->xfer_shift, (int)dev->xfer_mode, (int)base, ofs);
-
-	printk(KERN_INFO "ata%u: dev %u configured for %s\n",
-		ap->id, dev->devno, xfer_mode_str[idx]);
+	if (ata_msg_probe(ap))
+			printk("%s: idx=%d xfer_shift=%u, xfer_mode=0x%x, base=0x%x, offset=%d\n",
+				__FUNCTION__,
+				idx, dev->xfer_shift, (int)dev->xfer_mode, (int)base, ofs);
+
+	if (ata_msg_info(ap))
+			printk(KERN_INFO "ata%u: dev %u configured for %s\n",
+				ap->id, dev->devno, xfer_mode_str[idx]);
 }
 
 static int ata_host_set_pio(struct ata_port *ap)
@@ -1792,15 +1836,18 @@ static int ata_host_set_pio(struct ata_p
 	mask = ata_get_mode_mask(ap, ATA_SHIFT_PIO);
 	x = fgb(mask);
 	if (x < 0) {
-		printk(KERN_WARNING "ata%u: no PIO support\n", ap->id);
+			if (ata_msg_warn(ap))
+					printk(KERN_WARNING "ata%u: no PIO support\n", ap->id);
 		return -1;
 	}
 
 	base = base_from_shift(ATA_SHIFT_PIO);
 	xfer_mode = base + x;
 
-	DPRINTK("base 0x%x xfer_mode 0x%x mask 0x%x x %d\n",
-		(int)base, (int)xfer_mode, mask, x);
+	if (ata_msg_probe(ap))
+			printk("%s: base 0x%x xfer_mode 0x%x mask 0x%x x %d\n",
+				__FUNCTION__,
+				(int)base, (int)xfer_mode, mask, x);
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		struct ata_device *dev = &ap->device[i];
@@ -1908,9 +1955,9 @@ static unsigned int ata_busy_sleep (stru
 		status = ata_busy_wait(ap, ATA_BUSY, 3);
 	}
 
-	if (status & ATA_BUSY)
-		printk(KERN_WARNING "ata%u is slow to respond, "
-		       "please be patient\n", ap->id);
+	if ((status & ATA_BUSY) && ata_msg_warn(ap))
+			printk(KERN_WARNING "ata%u is slow to respond, "
+								"please be patient\n", ap->id);
 
 	timeout = timer_start + tmout;
 	while ((status & ATA_BUSY) && (time_before(jiffies, timeout))) {
@@ -1919,9 +1966,10 @@ static unsigned int ata_busy_sleep (stru
 	}
 
 	if (status & ATA_BUSY) {
-		printk(KERN_ERR "ata%u failed to respond (%lu secs)\n",
-		       ap->id, tmout / HZ);
-		return 1;
+			if (ata_msg_warn(ap))
+					printk(KERN_ERR "ata%u failed to respond (%lu secs)\n",
+						ap->id, tmout / HZ);
+			return 1;
 	}
 
 	return 0;
@@ -1994,7 +2042,8 @@ static unsigned int ata_bus_edd(struct a
 
 	/* set up execute-device-diag (bus reset) taskfile */
 	/* also, take interrupts to a known state (disabled) */
-	DPRINTK("execute-device-diag\n");
+	if (ata_msg_probe(ap))
+			printk(KERN_DEBUG "%s: execute-device-diag\n", __FUNCTION__);
 	ata_tf_init(ap, &tf, 0);
 	tf.ctl |= ATA_NIEN;
 	tf.command = ATA_CMD_EDD;
@@ -2018,7 +2067,8 @@ static unsigned int ata_bus_softreset(st
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 
-	DPRINTK("ata%u: bus reset via SRST\n", ap->id);
+	if (ata_msg_ctl(ap))
+			printk(KERN_INFO "%s: ata%u: bus reset via SRST\n", __FUNCTION__, ap->id);
 
 	/* software reset.  causes dev0 to be selected */
 	if (ap->flags & ATA_FLAG_MMIO) {
@@ -2077,7 +2127,9 @@ void ata_bus_reset(struct ata_port *ap)
 	u8 err;
 	unsigned int dev0, dev1 = 0, rc = 0, devmask = 0;
 
-	DPRINTK("ENTER, host %u, port %u\n", ap->id, ap->port_no);
+	if (ata_msg_ctl(ap))
+			printk(KERN_DEBUG "%s: ENTER, host %u, port %u\n", 
+				__FUNCTION__, ap->id, ap->port_no);
 
 	/* determine if device 0/1 are present */
 	if (ap->flags & ATA_FLAG_SATA_RESET)
@@ -2141,21 +2193,25 @@ void ata_bus_reset(struct ata_port *ap)
 			outb(ap->ctl, ioaddr->ctl_addr);
 	}
 
-	DPRINTK("EXIT\n");
+	if (ata_msg_ctl(ap))
+			printk(KERN_DEBUG "%s: EXIT\n", __FUNCTION__);
 	return;
 
 err_out:
-	printk(KERN_ERR "ata%u: disabling port\n", ap->id);
+	if (ata_msg_err(ap))
+			printk(KERN_ERR "ata%u: disabling port\n", ap->id);
 	ap->ops->port_disable(ap);
 
-	DPRINTK("EXIT\n");
+	if (ata_msg_ctl(ap))
+			printk("%s: EXIT\n", __FUNCTION__);
 }
 
 static void ata_pr_blacklisted(const struct ata_port *ap,
 			       const struct ata_device *dev)
 {
-	printk(KERN_WARNING "ata%u: dev %u is on DMA blacklist, disabling DMA\n",
-		ap->id, dev->devno);
+		if (ata_msg_warn(ap))
+				printk(KERN_WARNING "ata%u: dev %u is on DMA blacklist,"
+					"disabling DMA\an",	ap->id, dev->devno);
 }
 
 static const char * const ata_dma_blacklist [] = {
@@ -2356,7 +2412,8 @@ static void ata_dev_set_xfermode(struct 
 	struct ata_taskfile tf;
 
 	/* set up set-features taskfile */
-	DPRINTK("set features - xfer mode\n");
+	if (ata_msg_ctl(ap))
+			printk(KERN_DEBUG "%s: set features - xfer mode\n", __FUNCTION__);
 
 	ata_tf_init(ap, &tf, dev->devno);
 	tf.command = ATA_CMD_SET_FEATURES;
@@ -2366,12 +2423,14 @@ static void ata_dev_set_xfermode(struct 
 	tf.nsect = dev->xfer_mode;
 
 	if (ata_exec_internal(ap, dev, &tf, DMA_NONE, NULL, 0)) {
-		printk(KERN_ERR "ata%u: failed to set xfermode, disabled\n",
+			if (ata_msg_err(ap))
+					printk(KERN_ERR "ata%u: failed to set xfermode, disabled\n",
 		       ap->id);
 		ata_port_disable(ap);
 	}
 
-	DPRINTK("EXIT\n");
+	if (ata_msg_ctl(ap))
+			printk(KERN_DEBUG "%s: EXIT\n", __FUNCTION__);
 }
 
 /**
@@ -2390,10 +2449,12 @@ static void ata_dev_reread_id(struct ata
 
 	if (dev->class == ATA_DEV_ATA) {
 		tf.command = ATA_CMD_ID_ATA;
-		DPRINTK("do ATA identify\n");
+		if (ata_msg_ctl(ap))
+				printk(KERN_DEBUG "%s: do ATA identify\n", __FUNCTION__);
 	} else {
 		tf.command = ATA_CMD_ID_ATAPI;
-		DPRINTK("do ATAPI identify\n");
+		if (ata_msg_ctl(ap))
+				printk(KERN_DEBUG "%s: do ATAPI identify\n", __FUNCTION__);
 	}
 
 	tf.flags |= ATA_TFLAG_DEVICE;
@@ -2407,11 +2468,13 @@ static void ata_dev_reread_id(struct ata
 
 	ata_dump_id(dev);
 
-	DPRINTK("EXIT\n");
+	if (ata_msg_ctl(ap))
+			printk(KERN_DEBUG "%s: EXIT\n", __FUNCTION__);
 
 	return;
 err_out:
-	printk(KERN_ERR "ata%u: failed to reread ID, disabled\n", ap->id);
+	if (ata_msg_err(ap))
+			printk(KERN_ERR "ata%u: failed to reread ID, disabled\n", ap->id);
 	ata_port_disable(ap);
 }
 
@@ -2434,7 +2497,8 @@ static void ata_dev_init_params(struct a
 		return;
 
 	/* set up init dev params taskfile */
-	DPRINTK("init dev params \n");
+	if (ata_msg_ctl(ap))
+			printk(KERN_DEBUG "%s: init dev params \n", __FUNCTION__);
 
 	ata_tf_init(ap, &tf, dev->devno);
 	tf.command = ATA_CMD_INIT_DEV_PARAMS;
@@ -2444,12 +2508,14 @@ static void ata_dev_init_params(struct a
 	tf.device |= (heads - 1) & 0x0f; /* max head = num. of heads - 1 */
 
 	if (ata_exec_internal(ap, dev, &tf, DMA_NONE, NULL, 0)) {
-		printk(KERN_ERR "ata%u: failed to init parameters, disabled\n",
-		       ap->id);
+			if (ata_msg_err(ap))
+					printk(KERN_ERR "ata%u: failed to init parameters, disabled\n",
+						ap->id);
 		ata_port_disable(ap);
 	}
 
-	DPRINTK("EXIT\n");
+	if (ata_msg_ctl(ap))
+			printk(KERN_DEBUG "%s: EXIT\n", __FUNCTION__);
 }
 
 /**
@@ -2475,7 +2541,9 @@ static void ata_sg_clean(struct ata_queu
 	if (qc->flags & ATA_QCFLAG_SINGLE)
 		assert(qc->n_elem == 1);
 
-	VPRINTK("unmapping %u sg elements\n", qc->n_elem);
+	if (ata_msg_malloc(ap))
+			printk(KERN_DEBUG "%s: unmapping %u sg elements\n", 
+				__FUNCTION__, qc->n_elem);
 
 	/* if we padded the buffer out to 32-bit bound, and data
 	 * xfer direction is from-device, we must copy from the
@@ -2551,7 +2619,9 @@ static void ata_fill_sg(struct ata_queue
 
 			ap->prd[idx].addr = cpu_to_le32(addr);
 			ap->prd[idx].flags_len = cpu_to_le32(len & 0xffff);
-			VPRINTK("PRD[%u] = (0x%X, 0x%X)\n", idx, addr, len);
+			if (ata_msg_malloc(ap))
+					printk(KERN_DEBUG "%s: PRD[%u] = (0x%X, 0x%X)\n", 
+						__FUNCTION__, idx, addr, len);
 
 			idx++;
 			sg_len -= len;
@@ -2694,8 +2764,9 @@ static int ata_sg_setup_one(struct ata_q
 		/* trim sg */
 		sg->length -= qc->pad_len;
 
-		DPRINTK("padding done, sg->length=%u pad_len=%u\n",
-			sg->length, qc->pad_len);
+		if (ata_msg_malloc(ap))
+				printk(KERN_DEBUG "%s: padding done, sg->length=%u pad_len=%u\n",
+					__FUNCTION__, sg->length, qc->pad_len);
 	}
 
 	if (!sg->length) {
@@ -2715,7 +2786,9 @@ static int ata_sg_setup_one(struct ata_q
 skip_map:
 	sg_dma_len(sg) = sg->length;
 
-	DPRINTK("mapped buffer of %d bytes for %s\n", sg_dma_len(sg),
+	if (ata_msg_malloc(ap))
+			printk(KERN_DEBUG "%s: mapped buffer of %d bytes for %s\n", 
+				__FUNCTION__, sg_dma_len(sg),
 		qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
 
 	return 0;
@@ -2742,7 +2815,8 @@ static int ata_sg_setup(struct ata_queue
 	struct scatterlist *lsg = &sg[qc->n_elem - 1];
 	int n_elem, pre_n_elem, dir, trim_sg = 0;
 
-	VPRINTK("ENTER, ata%u\n", ap->id);
+	if (ata_msg_malloc(ap))
+			printk(KERN_DEBUG "%s: ENTER, ata%u\n", __FUNCTION__, ap->id);
 	assert(qc->flags & ATA_QCFLAG_SG);
 
 	/* we must lengthen transfers to end on a 32-bit boundary */
@@ -2777,8 +2851,9 @@ static int ata_sg_setup(struct ata_queue
 		if (lsg->length == 0)
 			trim_sg = 1;
 
-		DPRINTK("padding done, sg[%d].length=%u pad_len=%u\n",
-			qc->n_elem - 1, lsg->length, qc->pad_len);
+		if (ata_msg_malloc(ap))
+				printk(KERN_DEBUG "%s: padding done, sg[%d].length=%u pad_len=%u\n",
+					__FUNCTION__, qc->n_elem - 1, lsg->length, qc->pad_len);
 	}
 
 	pre_n_elem = qc->n_elem;
@@ -2798,7 +2873,8 @@ static int ata_sg_setup(struct ata_queue
 		return -1;
 	}
 
-	DPRINTK("%d sg elements mapped\n", n_elem);
+	if (ata_msg_malloc(ap))
+			printk(KERN_DEBUG "%s: sg elements mapped: %d\n", __FUNCTION__, n_elem);
 
 skip_map:
 	qc->n_elem = n_elem;
@@ -3101,7 +3177,9 @@ static void ata_pio_sector(struct ata_qu
 		qc->cursg_ofs = 0;
 	}
 
-	DPRINTK("data %s\n", qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
+	if (ata_msg_ctl(ap))
+			printk(KERN_DEBUG "%s: data %s\n", 
+				__FUNCTION__, qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
 
 	/* do the actual data transfer */
 	do_write = (qc->tf.flags & ATA_TFLAG_WRITE);
@@ -3147,7 +3225,7 @@ next_sg:
 		unsigned int words = bytes >> 1;
 		unsigned int i;
 
-		if (words) /* warning if bytes > 1 */
+		if (words && ata_msg_warn(ap)) /* warning if bytes > 1 */
 			printk(KERN_WARNING "ata%u: %u bytes trailing data\n",
 			       ap->id, bytes);
 
@@ -3184,7 +3262,9 @@ next_sg:
 		qc->cursg_ofs = 0;
 	}
 
-	DPRINTK("data %s\n", qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
+	if (ata_msg_ctl(ap))
+			printk(KERN_DEBUG "%s: data %s\n", 
+				__FUNCTION__, qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
 
 	/* do the actual data transfer */
 	ata_data_xfer(ap, buf, count, do_write);
@@ -3232,8 +3312,9 @@ static void atapi_pio_bytes(struct ata_q
 	return;
 
 err_out:
-	printk(KERN_INFO "ata%u: dev %u: ATAPI check failed\n",
-	      ap->id, dev->devno);
+	if (ata_msg_err(ap))
+			printk(KERN_INFO "%s: ata%u: dev %u: ATAPI check failed\n",
+				__FUNCTION__, ap->id, dev->devno);
 	qc->err_mask |= AC_ERR_ATA_BUS;
 	ap->hsm_task_state = HSM_ST_ERR;
 }
@@ -3305,7 +3386,8 @@ static void ata_pio_error(struct ata_por
 {
 	struct ata_queued_cmd *qc;
 
-	printk(KERN_WARNING "ata%u: PIO error\n", ap->id);
+	if (ata_msg_err(ap))
+			printk(KERN_WARNING "%s: ata%u: PIO error\n", __FUNCTION__, ap->id);
 
 	qc = ata_qc_from_tag(ap, ap->active_tag);
 	assert(qc != NULL);
@@ -3385,7 +3467,8 @@ static void ata_qc_timeout(struct ata_qu
 	u8 host_stat = 0, drv_stat;
 	unsigned long flags;
 
-	DPRINTK("ENTER\n");
+	if (ata_msg_ctl(ap))
+			printk(KERN_DEBUG "%s: ENTER\n", __FUNCTION__);
 
 	spin_lock_irqsave(&host_set->lock, flags);
 
@@ -3415,8 +3498,9 @@ static void ata_qc_timeout(struct ata_qu
 		/* ack bmdma irq events */
 		ap->ops->irq_clear(ap);
 
-		printk(KERN_ERR "ata%u: command 0x%x timeout, stat 0x%x host_stat 0x%x\n",
-		       ap->id, qc->tf.command, drv_stat, host_stat);
+		if (ata_msg_err(ap))
+				printk(KERN_ERR "ata%u: command 0x%x timeout, stat 0x%x host_stat 0x%x\n",
+					ap->id, qc->tf.command, drv_stat, host_stat);
 
 		/* complete taskfile transaction */
 		qc->err_mask |= ac_err_mask(drv_stat);
@@ -3426,7 +3510,8 @@ static void ata_qc_timeout(struct ata_qu
 
 	spin_unlock_irqrestore(&host_set->lock, flags);
 
-	DPRINTK("EXIT\n");
+	if (ata_msg_ctl(ap))
+			printk(KERN_DEBUG "%s: EXIT\n", __FUNCTION__);
 }
 
 /**
@@ -3452,19 +3537,22 @@ void ata_eng_timeout(struct ata_port *ap
 {
 	struct ata_queued_cmd *qc;
 
-	DPRINTK("ENTER\n");
+	if (ata_msg_ctl(ap))
+			printk(KERN_DEBUG "%s: ENTER\n", __FUNCTION__);
 
 	qc = ata_qc_from_tag(ap, ap->active_tag);
 	if (qc)
 		ata_qc_timeout(qc);
 	else {
-		printk(KERN_ERR "ata%u: BUG: timeout without command\n",
-		       ap->id);
+			if (ata_msg_err(ap))
+					printk(KERN_ERR "ata%u: BUG: timeout without command\n",
+						ap->id);
 		goto out;
 	}
 
 out:
-	DPRINTK("EXIT\n");
+	if (ata_msg_ctl(ap))
+			printk(KERN_DEBUG "%s: EXIT\n", __FUNCTION__);
 }
 
 /**
@@ -3590,7 +3678,8 @@ void ata_qc_complete(struct ata_queued_c
 
 	__ata_qc_complete(qc);
 
-	VPRINTK("EXIT\n");
+	if (ata_msg_ctl(ap))
+			printk(KERN_DEBUG "%s: EXIT\n", __FUNCTION__);
 }
 
 static inline int ata_should_dma_map(struct ata_queued_cmd *qc)
@@ -3989,7 +4078,9 @@ inline unsigned int ata_host_intr (struc
 	case ATA_PROT_ATAPI:
 		/* check status of DMA engine */
 		host_stat = ap->ops->bmdma_status(ap);
-		VPRINTK("ata%u: host_stat 0x%X\n", ap->id, host_stat);
+		if (ata_msg_intr(ap))
+				printk(KERN_DEBUG "%s: ata%u: host_stat 0x%X\n", 
+					__FUNCTION__, ap->id, host_stat);
 
 		/* if it's not our irq... */
 		if (!(host_stat & ATA_DMA_INTR))
@@ -4011,8 +4102,9 @@ inline unsigned int ata_host_intr (struc
 		status = ata_chk_status(ap);
 		if (unlikely(status & ATA_BUSY))
 			goto idle_irq;
-		DPRINTK("ata%u: protocol %d (dev_stat 0x%X)\n",
-			ap->id, qc->tf.protocol, status);
+		if (ata_msg_intr(ap))
+				printk(KERN_DEBUG "%s: ata%u: protocol %d (dev_stat 0x%X)\n",
+					__FUNCTION__, ap->id, qc->tf.protocol, status);
 
 		/* ack bmdma irq events */
 		ap->ops->irq_clear(ap);
@@ -4035,7 +4127,8 @@ idle_irq:
 	if ((ap->stats.idle_irq % 1000) == 0) {
 		handled = 1;
 		ata_irq_ack(ap, 0); /* debug trap */
-		printk(KERN_WARNING "ata%d: irq trap\n", ap->id);
+		if (ata_msg_warn(ap))
+				printk(KERN_WARNING "ata%d: irq trap\n", ap->id);
 	}
 #endif
 	return 0;	/* irq not handled */
@@ -4112,7 +4205,8 @@ static void atapi_packet_task(void *_dat
 	assert(qc->flags & ATA_QCFLAG_ACTIVE);
 
 	/* sleep-wait for BSY to clear */
-	DPRINTK("busy wait\n");
+	if (ata_msg_ctl(ap))
+			printk(KERN_DEBUG "%s: busy wait\n", __FUNCTION__);
 	if (ata_busy_sleep(ap, ATA_TMOUT_CDB_QUICK, ATA_TMOUT_CDB)) {
 		qc->err_mask |= AC_ERR_ATA_BUS;
 		goto err_out;
@@ -4126,7 +4220,8 @@ static void atapi_packet_task(void *_dat
 	}
 
 	/* send SCSI cdb */
-	DPRINTK("send cdb\n");
+	if (ata_msg_ctl(ap))
+			printk(KERN_DEBUG "%s: send cdb\n", __FUNCTION__);
 	assert(ap->cdb_len >= 12);
 
 	if (qc->tf.protocol == ATA_PROT_ATAPI_DMA ||
@@ -4190,7 +4285,7 @@ static int ata_do_simple_cmd(struct ata_
 	tf.protocol = ATA_PROT_NODATA;
 
 	err = ata_exec_internal(ap, dev, &tf, DMA_NONE, NULL, 0);
-	if (err)
+	if (err && (ata_msg_err(ap)))
 		printk(KERN_ERR "%s: ata command failed: %d\n",
 				__FUNCTION__, err);
 
@@ -4278,7 +4373,9 @@ int ata_port_start (struct ata_port *ap)
 		return rc;
 	}
 
-	DPRINTK("prd alloc, virt %p, dma %llx\n", ap->prd, (unsigned long long) ap->prd_dma);
+	if (ata_msg_ctl(ap))
+			printk(KERN_DEBUG "%s: prd alloc, virt %p, dma %llx\n", 
+				__FUNCTION__, ap->prd, (unsigned long long) ap->prd_dma);
 
 	return 0;
 }
@@ -4324,7 +4421,8 @@ static void ata_host_remove(struct ata_p
 {
 	struct Scsi_Host *sh = ap->host;
 
-	DPRINTK("ENTER\n");
+	if (ata_msg_ctl(ap))
+			printk(KERN_DEBUG "%s: ENTER\n", __FUNCTION__);
 
 	if (do_unregister)
 		scsi_remove_host(sh);
@@ -4413,7 +4511,8 @@ static struct ata_port * ata_host_add(co
 	struct ata_port *ap;
 	int rc;
 
-	DPRINTK("ENTER\n");
+	if (ata_msg_ctl(ap))
+			printk(KERN_DEBUG "%s: ENTER\n", __FUNCTION__);
 	host = scsi_host_alloc(ent->sht, sizeof(struct ata_port));
 	if (!host)
 		return NULL;
@@ -4458,7 +4557,7 @@ int ata_device_add(const struct ata_prob
 	struct device *dev = ent->dev;
 	struct ata_host_set *host_set;
 
-	DPRINTK("ENTER\n");
+	printk(KERN_DEBUG "%s: ENTER\n", __FUNCTION__);
 	/* alloc a container for our list of ATA ports (buses) */
 	host_set = kzalloc(sizeof(struct ata_host_set) +
 			   (ent->n_ports * sizeof(void *)), GFP_KERNEL);
@@ -4489,7 +4588,7 @@ int ata_device_add(const struct ata_prob
 
 		/* print per-port info to dmesg */
 		printk(KERN_INFO "ata%u: %cATA max %s cmd 0x%lX ctl 0x%lX "
-				 "bmdma 0x%lX irq %lu\n",
+			 "bmdma 0x%lX irq %lu\n",
 			ap->id,
 			ap->flags & ATA_FLAG_SATA ? 'S' : 'P',
 			ata_mode_string(xfer_mode_mask),
@@ -4632,12 +4731,14 @@ int ata_scsi_release(struct Scsi_Host *h
 {
 	struct ata_port *ap = (struct ata_port *) &host->hostdata[0];
 
-	DPRINTK("ENTER\n");
+	if (ata_msg_ctl(ap))
+			printk(KERN_DEBUG "%s: ENTER\n", __FUNCTION__);
 
 	ap->ops->port_disable(ap);
 	ata_host_remove(ap, 0);
 
-	DPRINTK("EXIT\n");
+	if (ata_msg_ctl(ap))
+			printk(KERN_DEBUG "%s: EXIT\n", __FUNCTION__);
 	return 1;
 }
 

	

	
		
___________________________________________________________ 
Telefonate ohne weitere Kosten vom PC zum PC: http://messenger.yahoo.de

