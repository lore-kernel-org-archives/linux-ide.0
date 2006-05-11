From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 22/22] libata: use ATA printk helpers
Date: Thu, 11 May 2006 20:59:52 +0900
Message-ID: <1147348792393-git-send-email-htejun@gmail.com>
References: <11473487893774-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.193]:58054 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751621AbWEKMAH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 08:00:07 -0400
Received: by wx-out-0102.google.com with SMTP id t16so118649wxc
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 05:00:06 -0700 (PDT)
In-Reply-To: <11473487893774-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Use ATA printk helpers.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ahci.c         |    8 +-
 drivers/scsi/ata_piix.c     |    4 -
 drivers/scsi/libata-core.c  |  199 ++++++++++++++++++++-----------------------
 drivers/scsi/libata-eh.c    |    5 +
 drivers/scsi/libata-scsi.c  |    9 +-
 drivers/scsi/sata_mv.c      |    8 +-
 drivers/scsi/sata_promise.c |    7 +-
 drivers/scsi/sata_sil.c     |    8 +-
 drivers/scsi/sata_sil24.c   |    6 +
 drivers/scsi/sata_sx4.c     |    7 +-
 10 files changed, 124 insertions(+), 137 deletions(-)

9fbba69c142464ffe56e6682d2d96cffef1aea8d
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index f6e4c8e..a4fb8d0 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -655,8 +655,7 @@ static int ahci_softreset(struct ata_por
  fail_restart:
 	ahci_start_engine(ap);
  fail:
-	printk(KERN_ERR "ata%u: softreset failed (%s)\n",
-	       ap->id, reason);
+	ata_port_printk(ap, KERN_ERR, "softreset failed (%s)\n", reason);
 	return rc;
 }
 
@@ -798,9 +797,8 @@ static void ahci_restart_port(struct ata
 
 	if ((ap->device[0].class != ATA_DEV_ATAPI) ||
 	    ((irq_stat & PORT_IRQ_TF_ERR) == 0))
-		printk(KERN_WARNING "ata%u: port reset, "
+		ata_port_printk(ap, KERN_WARNING, "port reset, "
 		       "p_is %x is %x pis %x cmd %x tf %x ss %x se %x\n",
-			ap->id,
 			irq_stat,
 			readl(mmio + HOST_IRQ_STAT),
 			readl(port_mmio + PORT_IRQ_STAT),
@@ -840,7 +838,7 @@ static void ahci_eng_timeout(struct ata_
 	struct ata_queued_cmd *qc;
 	unsigned long flags;
 
-	printk(KERN_WARNING "ata%u: handling error/timeout\n", ap->id);
+	ata_port_printk(ap, KERN_WARNING, "handling error/timeout\n");
 
 	spin_lock_irqsave(&host_set->lock, flags);
 
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index 62dabf7..af1d46e 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -484,7 +484,7 @@ static int piix_pata_probe_reset(struct 
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 
 	if (!pci_test_config_bits(pdev, &piix_enable_bits[ap->hard_port_no])) {
-		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
+		ata_port_printk(ap, KERN_INFO, "port disabled. ignoring.\n");
 		return 0;
 	}
 
@@ -565,7 +565,7 @@ static unsigned int piix_sata_probe (str
 static int piix_sata_probe_reset(struct ata_port *ap, unsigned int *classes)
 {
 	if (!piix_sata_probe(ap)) {
-		printk(KERN_INFO "ata%u: SATA port has no device.\n", ap->id);
+		ata_port_printk(ap, KERN_INFO, "SATA port has no device.\n");
 		return 0;
 	}
 
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 8eee5af..126adef 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -412,8 +412,7 @@ static const char *sata_spd_string(unsig
 void ata_dev_disable(struct ata_device *dev)
 {
 	if (ata_dev_enabled(dev)) {
-		printk(KERN_WARNING "ata%u: dev %u disabled\n",
-		       dev->ap->id, dev->devno);
+		ata_dev_printk(dev, KERN_WARNING, "disabled\n");
 		dev->class++;
 	}
 }
@@ -1021,8 +1020,9 @@ unsigned ata_exec_internal(struct ata_de
 		if (qc->flags & ATA_QCFLAG_ACTIVE) {
 			qc->err_mask = AC_ERR_TIMEOUT;
 			ata_qc_complete(qc);
-			printk(KERN_WARNING "ata%u: qc timeout (cmd 0x%x)\n",
-			       ap->id, command);
+
+			ata_dev_printk(dev, KERN_WARNING,
+				       "qc timeout (cmd 0x%x)\n", command);
 		}
 
 		spin_unlock_irqrestore(&ap->host_set->lock, flags);
@@ -1187,8 +1187,8 @@ static int ata_dev_read_id(struct ata_de
 	return 0;
 
  err_out:
-	printk(KERN_WARNING "ata%u: dev %u failed to IDENTIFY (%s)\n",
-	       ap->id, dev->devno, reason);
+	ata_dev_printk(dev, KERN_WARNING, "failed to IDENTIFY "
+		       "(%s, err_mask=0x%x)\n", reason, err_mask);
 	return rc;
 }
 
@@ -1228,10 +1228,10 @@ static int ata_dev_configure(struct ata_
 
 	/* print device capabilities */
 	if (print_info)
-		printk(KERN_DEBUG "ata%u: dev %u cfg 49:%04x 82:%04x 83:%04x "
-		       "84:%04x 85:%04x 86:%04x 87:%04x 88:%04x\n",
-		       ap->id, dev->devno, id[49], id[82], id[83],
-		       id[84], id[85], id[86], id[87], id[88]);
+		ata_dev_printk(dev, KERN_DEBUG, "cfg 49:%04x 82:%04x 83:%04x "
+			       "84:%04x 85:%04x 86:%04x 87:%04x 88:%04x\n",
+			       id[49], id[82], id[83], id[84],
+			       id[85], id[86], id[87], id[88]);
 
 	/* initialize to-be-configured parameters */
 	dev->flags &= ~ATA_DFLAG_CFG_MASK;
@@ -1267,13 +1267,12 @@ static int ata_dev_configure(struct ata_
 
 			/* print device info to dmesg */
 			if (print_info)
-				printk(KERN_INFO "ata%u: dev %u ATA-%d, "
-				       "max %s, %Lu sectors: %s\n",
-				       ap->id, dev->devno,
-				       ata_id_major_version(id),
-				       ata_mode_string(xfer_mask),
-				       (unsigned long long)dev->n_sectors,
-				       lba_desc);
+				ata_dev_printk(dev, KERN_INFO, "ATA-%d, "
+					"max %s, %Lu sectors: %s\n",
+					ata_id_major_version(id),
+					ata_mode_string(xfer_mask),
+					(unsigned long long)dev->n_sectors,
+					lba_desc);
 		} else {
 			/* CHS */
 
@@ -1291,13 +1290,12 @@ static int ata_dev_configure(struct ata_
 
 			/* print device info to dmesg */
 			if (print_info)
-				printk(KERN_INFO "ata%u: dev %u ATA-%d, "
-				       "max %s, %Lu sectors: CHS %u/%u/%u\n",
-				       ap->id, dev->devno,
-				       ata_id_major_version(id),
-				       ata_mode_string(xfer_mask),
-				       (unsigned long long)dev->n_sectors,
-				       dev->cylinders, dev->heads, dev->sectors);
+				ata_dev_printk(dev, KERN_INFO, "ATA-%d, "
+					"max %s, %Lu sectors: CHS %u/%u/%u\n",
+					ata_id_major_version(id),
+					ata_mode_string(xfer_mask),
+					(unsigned long long)dev->n_sectors,
+					dev->cylinders, dev->heads, dev->sectors);
 		}
 
 		dev->cdb_len = 16;
@@ -1307,7 +1305,8 @@ static int ata_dev_configure(struct ata_
 	else if (dev->class == ATA_DEV_ATAPI) {
 		rc = atapi_cdb_len(id);
 		if ((rc < 12) || (rc > ATAPI_CDB_LEN)) {
-			printk(KERN_WARNING "ata%u: unsupported CDB len\n", ap->id);
+			ata_dev_printk(dev, KERN_WARNING,
+				       "unsupported CDB len\n");
 			rc = -EINVAL;
 			goto err_out_nosup;
 		}
@@ -1315,8 +1314,8 @@ static int ata_dev_configure(struct ata_
 
 		/* print device info to dmesg */
 		if (print_info)
-			printk(KERN_INFO "ata%u: dev %u ATAPI, max %s\n",
-			       ap->id, dev->devno, ata_mode_string(xfer_mask));
+			ata_dev_printk(dev, KERN_INFO, "ATAPI, max %s\n",
+				       ata_mode_string(xfer_mask));
 	}
 
 	ap->host->max_cmd_len = 0;
@@ -1328,8 +1327,8 @@ static int ata_dev_configure(struct ata_
 	/* limit bridge transfers to udma5, 200 sectors */
 	if (ata_dev_knobble(dev)) {
 		if (print_info)
-			printk(KERN_INFO "ata%u(%u): applying bridge limits\n",
-			       ap->id, dev->devno);
+			ata_dev_printk(dev, KERN_INFO,
+				       "applying bridge limits\n");
 		dev->udma_mask &= ATA_UDMA5;
 		dev->max_sectors = ATA_MAX_SECTORS;
 	}
@@ -1382,7 +1381,8 @@ static int ata_bus_probe(struct ata_port
 	if (ap->ops->probe_reset) {
 		rc = ap->ops->probe_reset(ap, classes);
 		if (rc) {
-			printk("ata%u: reset failed (errno=%d)\n", ap->id, rc);
+			ata_port_printk(ap, KERN_ERR,
+					"reset failed (errno=%d)\n", rc);
 			return rc;
 		}
 	} else {
@@ -1495,13 +1495,13 @@ static void sata_print_link_status(struc
 
 	if (ata_port_online(ap)) {
 		tmp = (sstatus >> 4) & 0xf;
-		printk(KERN_INFO
-		       "ata%u: SATA link up %s (SStatus %X SControl %X)\n",
-		       ap->id, sata_spd_string(tmp), sstatus, scontrol);
+		ata_port_printk(ap, KERN_INFO,
+				"SATA link up %s (SStatus %X SControl %X)\n",
+				sata_spd_string(tmp), sstatus, scontrol);
 	} else {
-		printk(KERN_INFO
-		       "ata%u: SATA link down (SStatus %X SControl %X)\n",
-		       ap->id, sstatus, scontrol);
+		ata_port_printk(ap, KERN_INFO,
+				"SATA link down (SStatus %X SControl %X)\n",
+				sstatus, scontrol);
 	}
 }
 
@@ -1655,8 +1655,8 @@ int ata_down_sata_spd_limit(struct ata_p
 
 	ap->sata_spd_limit = mask;
 
-	printk(KERN_WARNING "ata%u: limiting SATA link speed to %s\n",
-	       ap->id, sata_spd_string(fls(mask)));
+	ata_port_printk(ap, KERN_WARNING, "limiting SATA link speed to %s\n",
+			sata_spd_string(fls(mask)));
 
 	return 0;
 }
@@ -1895,7 +1895,6 @@ int ata_timing_compute(struct ata_device
  */
 int ata_down_xfermask_limit(struct ata_device *dev, int force_pio0)
 {
-	struct ata_port *ap = dev->ap;
 	unsigned long xfer_mask;
 	int highbit;
 
@@ -1918,8 +1917,8 @@ int ata_down_xfermask_limit(struct ata_d
 	ata_unpack_xfermask(xfer_mask, &dev->pio_mask, &dev->mwdma_mask,
 			    &dev->udma_mask);
 
-	printk(KERN_WARNING "ata%u: dev %u limiting speed to %s\n",
-	       ap->id, dev->devno, ata_mode_string(xfer_mask));
+	ata_dev_printk(dev, KERN_WARNING, "limiting speed to %s\n",
+		       ata_mode_string(xfer_mask));
 
 	return 0;
 
@@ -1929,7 +1928,6 @@ int ata_down_xfermask_limit(struct ata_d
 
 static int ata_dev_set_mode(struct ata_device *dev)
 {
-	struct ata_port *ap = dev->ap;
 	unsigned int err_mask;
 	int rc;
 
@@ -1939,9 +1937,8 @@ static int ata_dev_set_mode(struct ata_d
 
 	err_mask = ata_dev_set_xfermode(dev);
 	if (err_mask) {
-		printk(KERN_ERR
-		       "ata%u: failed to set xfermode (err_mask=0x%x)\n",
-		       ap->id, err_mask);
+		ata_dev_printk(dev, KERN_ERR, "failed to set xfermode "
+			       "(err_mask=0x%x)\n", err_mask);
 		return -EIO;
 	}
 
@@ -1952,9 +1949,8 @@ static int ata_dev_set_mode(struct ata_d
 	DPRINTK("xfer_shift=%u, xfer_mode=0x%x\n",
 		dev->xfer_shift, (int)dev->xfer_mode);
 
-	printk(KERN_INFO "ata%u: dev %u configured for %s\n",
-	       ap->id, dev->devno,
-	       ata_mode_string(ata_xfer_mode2mask(dev->xfer_mode)));
+	ata_dev_printk(dev, KERN_INFO, "configured for %s\n",
+		       ata_mode_string(ata_xfer_mode2mask(dev->xfer_mode)));
 	return 0;
 }
 
@@ -2022,8 +2018,7 @@ int ata_set_mode(struct ata_port *ap, st
 			continue;
 
 		if (!dev->pio_mode) {
-			printk(KERN_WARNING "ata%u: dev %u no PIO support\n",
-			       ap->id, dev->devno);
+			ata_dev_printk(dev, KERN_WARNING, "no PIO support\n");
 			rc = -EINVAL;
 			goto out;
 		}
@@ -2122,8 +2117,8 @@ unsigned int ata_busy_sleep (struct ata_
 	}
 
 	if (status & ATA_BUSY)
-		printk(KERN_WARNING "ata%u is slow to respond, "
-		       "please be patient\n", ap->id);
+		ata_port_printk(ap, KERN_WARNING,
+				"port is slow to respond, please be patient\n");
 
 	timeout = timer_start + tmout;
 	while ((status & ATA_BUSY) && (time_before(jiffies, timeout))) {
@@ -2132,8 +2127,8 @@ unsigned int ata_busy_sleep (struct ata_
 	}
 
 	if (status & ATA_BUSY) {
-		printk(KERN_ERR "ata%u failed to respond (%lu secs)\n",
-		       ap->id, tmout / HZ);
+		ata_port_printk(ap, KERN_ERR, "port failed to respond "
+				"(%lu secs)\n", tmout / HZ);
 		return 1;
 	}
 
@@ -2226,7 +2221,7 @@ static unsigned int ata_bus_softreset(st
 	 * pulldown resistor.
 	 */
 	if (ata_check_status(ap) == 0xFF) {
-		printk(KERN_ERR "ata%u: SRST failed (status 0xFF)\n", ap->id);
+		ata_port_printk(ap, KERN_ERR, "SRST failed (status 0xFF)\n");
 		return AC_ERR_OTHER;
 	}
 
@@ -2320,7 +2315,7 @@ void ata_bus_reset(struct ata_port *ap)
 	return;
 
 err_out:
-	printk(KERN_ERR "ata%u: disabling port\n", ap->id);
+	ata_port_printk(ap, KERN_ERR, "disabling port\n");
 	ap->ops->port_disable(ap);
 
 	DPRINTK("EXIT\n");
@@ -2423,8 +2418,8 @@ int ata_std_softreset(struct ata_port *a
 	DPRINTK("about to softreset, devmask=%x\n", devmask);
 	err_mask = ata_bus_softreset(ap, devmask);
 	if (err_mask) {
-		printk(KERN_ERR "ata%u: SRST failed (err_mask=0x%x)\n",
-		       ap->id, err_mask);
+		ata_port_printk(ap, KERN_ERR, "SRST failed (err_mask=0x%x)\n",
+				err_mask);
 		return -EIO;
 	}
 
@@ -2502,8 +2497,8 @@ int sata_std_hardreset(struct ata_port *
 	}
 
 	if (ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT)) {
-		printk(KERN_ERR
-		       "ata%u: COMRESET failed (device not ready)\n", ap->id);
+		ata_port_printk(ap, KERN_ERR,
+				"COMRESET failed (device not ready)\n");
 		return -EIO;
 	}
 
@@ -2661,8 +2656,8 @@ int ata_drive_probe_reset(struct ata_por
 		rc = ata_do_reset(ap, softreset, classes);
 		if (rc == 0 && classes[0] != ATA_DEV_UNKNOWN)
 			goto done;
-		printk(KERN_INFO "ata%u: softreset failed, will try "
-		       "hardreset in 5 secs\n", ap->id);
+		ata_port_printk(ap, KERN_INFO, "softreset failed, "
+				"will try hardreset in 5 secs\n");
 		ssleep(5);
 	}
 
@@ -2680,15 +2675,15 @@ int ata_drive_probe_reset(struct ata_por
 		if (ata_down_sata_spd_limit(ap))
 			goto done;
 
-		printk(KERN_INFO "ata%u: hardreset failed, will retry "
-		       "in 5 secs\n", ap->id);
+		ata_port_printk(ap, KERN_INFO, "hardreset failed, "
+				"will retry in 5 secs\n");
 		ssleep(5);
 	}
 
 	if (softreset) {
-		printk(KERN_INFO "ata%u: hardreset succeeded without "
-		       "classification, will retry softreset in 5 secs\n",
-		       ap->id);
+		ata_port_printk(ap, KERN_INFO,
+				"hardreset succeeded without classification, "
+				"will retry softreset in 5 secs\n");
 		ssleep(5);
 
 		rc = ata_do_reset(ap, softreset, classes);
@@ -2723,15 +2718,13 @@ int ata_drive_probe_reset(struct ata_por
 static int ata_dev_same_device(struct ata_device *dev, unsigned int new_class,
 			       const u16 *new_id)
 {
-	struct ata_port *ap = dev->ap;
 	const u16 *old_id = dev->id;
 	unsigned char model[2][41], serial[2][21];
 	u64 new_n_sectors;
 
 	if (dev->class != new_class) {
-		printk(KERN_INFO
-		       "ata%u: dev %u class mismatch %d != %d\n",
-		       ap->id, dev->devno, dev->class, new_class);
+		ata_dev_printk(dev, KERN_INFO, "class mismatch %d != %d\n",
+			       dev->class, new_class);
 		return 0;
 	}
 
@@ -2742,24 +2735,22 @@ static int ata_dev_same_device(struct at
 	new_n_sectors = ata_id_n_sectors(new_id);
 
 	if (strcmp(model[0], model[1])) {
-		printk(KERN_INFO
-		       "ata%u: dev %u model number mismatch '%s' != '%s'\n",
-		       ap->id, dev->devno, model[0], model[1]);
+		ata_dev_printk(dev, KERN_INFO, "model number mismatch "
+			       "'%s' != '%s'\n", model[0], model[1]);
 		return 0;
 	}
 
 	if (strcmp(serial[0], serial[1])) {
-		printk(KERN_INFO
-		       "ata%u: dev %u serial number mismatch '%s' != '%s'\n",
-		       ap->id, dev->devno, serial[0], serial[1]);
+		ata_dev_printk(dev, KERN_INFO, "serial number mismatch "
+			       "'%s' != '%s'\n", serial[0], serial[1]);
 		return 0;
 	}
 
 	if (dev->class == ATA_DEV_ATA && dev->n_sectors != new_n_sectors) {
-		printk(KERN_INFO
-		       "ata%u: dev %u n_sectors mismatch %llu != %llu\n",
-		       ap->id, dev->devno, (unsigned long long)dev->n_sectors,
-		       (unsigned long long)new_n_sectors);
+		ata_dev_printk(dev, KERN_INFO, "n_sectors mismatch "
+			       "%llu != %llu\n",
+			       (unsigned long long)dev->n_sectors,
+			       (unsigned long long)new_n_sectors);
 		return 0;
 	}
 
@@ -2782,9 +2773,8 @@ static int ata_dev_same_device(struct at
  */
 int ata_dev_revalidate(struct ata_device *dev, int post_reset)
 {
-	struct ata_port *ap = dev->ap;
 	unsigned int class = dev->class;
-	u16 *id = (void *)ap->sector_buf;
+	u16 *id = (void *)dev->ap->sector_buf;
 	int rc;
 
 	if (!ata_dev_enabled(dev)) {
@@ -2811,8 +2801,7 @@ int ata_dev_revalidate(struct ata_device
 		return 0;
 
  fail:
-	printk(KERN_ERR "ata%u: dev %u revalidation failed (errno=%d)\n",
-	       ap->id, dev->devno, rc);
+	ata_dev_printk(dev, KERN_ERR, "revalidation failed (errno=%d)\n", rc);
 	return rc;
 }
 
@@ -2940,8 +2929,8 @@ static void ata_dev_xfermask(struct ata_
 	}
 
 	if (ata_dma_blacklisted(dev))
-		printk(KERN_WARNING "ata%u: dev %u is on DMA blacklist, "
-		       "disabling DMA\n", ap->id, dev->devno);
+		ata_dev_printk(dev, KERN_WARNING,
+			       "device is on DMA blacklist, disabling DMA\n");
 
 	if (hs->flags & ATA_HOST_SIMPLEX) {
 		if (hs->simplex_claimed)
@@ -3732,8 +3721,8 @@ next_sg:
 		unsigned int i;
 
 		if (words) /* warning if bytes > 1 */
-			printk(KERN_WARNING "ata%u: %u bytes trailing data\n",
-			       ap->id, bytes);
+			ata_dev_printk(qc->dev, KERN_WARNING,
+				       "%u bytes trailing data\n", bytes);
 
 		for (i = 0; i < words; i++)
 			ata_data_xfer(ap, (unsigned char*)pad_buf, 2, do_write);
@@ -3816,8 +3805,7 @@ static void atapi_pio_bytes(struct ata_q
 	return;
 
 err_out:
-	printk(KERN_INFO "ata%u: dev %u: ATAPI check failed\n",
-	      ap->id, dev->devno);
+	ata_dev_printk(dev, KERN_INFO, "ATAPI check failed\n");
 	qc->err_mask |= AC_ERR_HSM;
 	ap->hsm_task_state = HSM_ST_ERR;
 }
@@ -3886,8 +3874,7 @@ static void ata_pio_error(struct ata_que
 	struct ata_port *ap = qc->ap;
 
 	if (qc->tf.command != ATA_CMD_PACKET)
-		printk(KERN_WARNING "ata%u: dev %u PIO error\n",
-		       ap->id, qc->dev->devno);
+		ata_dev_printk(qc->dev, KERN_WARNING, "PIO error\n");
 
 	/* make sure qc->err_mask is available to
 	 * know what's wrong and recover
@@ -4313,7 +4300,7 @@ idle_irq:
 #ifdef ATA_IRQ_TRAP
 	if ((ap->stats.idle_irq % 1000) == 0) {
 		ata_irq_ack(ap, 0); /* debug trap */
-		printk(KERN_WARNING "ata%d: irq trap\n", ap->id);
+		ata_port_printk(ap, KERN_WARNING, "irq trap\n");
 		return 1;
 	}
 #endif
@@ -4521,8 +4508,8 @@ static int ata_do_simple_cmd(struct ata_
 
 	err = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0);
 	if (err)
-		printk(KERN_ERR "%s: ata command failed: %d\n",
-				__FUNCTION__, err);
+		ata_dev_printk(dev, KERN_ERR, "%s: ata command failed: %d\n",
+			       __FUNCTION__, err);
 
 	return err;
 }
@@ -4862,15 +4849,14 @@ int ata_device_add(const struct ata_prob
 				(ap->pio_mask << ATA_SHIFT_PIO);
 
 		/* print per-port info to dmesg */
-		printk(KERN_INFO "ata%u: %cATA max %s cmd 0x%lX ctl 0x%lX "
-				 "bmdma 0x%lX irq %lu\n",
-			ap->id,
-			ap->flags & ATA_FLAG_SATA ? 'S' : 'P',
-			ata_mode_string(xfer_mode_mask),
-	       		ap->ioaddr.cmd_addr,
-	       		ap->ioaddr.ctl_addr,
-	       		ap->ioaddr.bmdma_addr,
-	       		ent->irq);
+		ata_port_printk(ap, KERN_INFO, "%cATA max %s cmd 0x%lX "
+				"ctl 0x%lX bmdma 0x%lX irq %lu\n",
+				ap->flags & ATA_FLAG_SATA ? 'S' : 'P',
+				ata_mode_string(xfer_mode_mask),
+				ap->ioaddr.cmd_addr,
+				ap->ioaddr.ctl_addr,
+				ap->ioaddr.bmdma_addr,
+				ent->irq);
 
 		ata_chk_status(ap);
 		host_set->ops->irq_clear(ap);
@@ -4908,8 +4894,7 @@ int ata_device_add(const struct ata_prob
 
 		rc = scsi_add_host(ap->host, dev);
 		if (rc) {
-			printk(KERN_ERR "ata%u: scsi_add_host failed\n",
-			       ap->id);
+			ata_port_printk(ap, KERN_ERR, "scsi_add_host failed\n");
 			/* FIXME: do something useful here */
 			/* FIXME: handle unconditional calls to
 			 * scsi_scan_host and ata_host_remove, below,
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index c31b13f..959a1cd 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -167,8 +167,9 @@ static void ata_qc_timeout(struct ata_qu
 		/* ack bmdma irq events */
 		ap->ops->irq_clear(ap);
 
-		printk(KERN_ERR "ata%u: command 0x%x timeout, stat 0x%x host_stat 0x%x\n",
-		       ap->id, qc->tf.command, drv_stat, host_stat);
+		ata_dev_printk(qc->dev, KERN_ERR, "command 0x%x timeout, "
+			       "stat 0x%x host_stat 0x%x\n",
+			       qc->tf.command, drv_stat, host_stat);
 
 		/* complete taskfile transaction */
 		qc->err_mask |= ac_err_mask(drv_stat);
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index fcbf64e..a9b4083 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -1261,8 +1261,8 @@ static void ata_scsi_translate(struct at
 	if (cmd->sc_data_direction == DMA_FROM_DEVICE ||
 	    cmd->sc_data_direction == DMA_TO_DEVICE) {
 		if (unlikely(cmd->request_bufflen < 1)) {
-			printk(KERN_WARNING "ata%u(%u): WARNING: zero len r/w req\n",
-			       dev->ap->id, dev->devno);
+			ata_dev_printk(dev, KERN_WARNING,
+				       "WARNING: zero len r/w req\n");
 			goto err_did;
 		}
 
@@ -2200,8 +2200,9 @@ ata_scsi_find_dev(struct ata_port *ap, c
 
 	if (!atapi_enabled || (ap->flags & ATA_FLAG_NO_ATAPI)) {
 		if (unlikely(dev->class == ATA_DEV_ATAPI)) {
-			printk(KERN_WARNING "ata%u(%u): WARNING: ATAPI is %s, device ignored.\n",
-			       ap->id, dev->devno, atapi_enabled ? "not supported with this driver" : "disabled");
+			ata_dev_printk(dev, KERN_WARNING,
+				"WARNING: ATAPI is %s, device ignored.\n",
+				atapi_enabled ? "not supported with this driver" : "disabled");
 			return NULL;
 		}
 	}
diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index 97aad57..5b7fea5 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -680,7 +680,7 @@ static void mv_stop_dma(struct ata_port 
 	}
 
 	if (EDMA_EN & reg) {
-		printk(KERN_ERR "ata%u: Unable to stop eDMA\n", ap->id);
+		ata_port_printk(ap, KERN_ERR, "Unable to stop eDMA\n");
 		/* FIXME: Consider doing a reset here to recover */
 	}
 }
@@ -1964,8 +1964,8 @@ comreset_retry:
 		ata_port_probe(ap);
 	} else {
 		ata_scr_read(ap, SCR_STATUS, &sstatus);
-		printk(KERN_INFO "ata%u: no device found (phy stat %08x)\n",
-		       ap->id, sstatus);
+		ata_port_printk(ap, KERN_INFO,
+				"no device found (phy stat %08x)\n", sstatus);
 		ata_port_disable(ap);
 		return;
 	}
@@ -2023,7 +2023,7 @@ static void mv_eng_timeout(struct ata_po
 {
 	struct ata_queued_cmd *qc;
 
-	printk(KERN_ERR "ata%u: Entering mv_eng_timeout\n",ap->id);
+	ata_port_printk(ap, KERN_ERR, "Entering mv_eng_timeout\n");
 	DPRINTK("All regs @ start of eng_timeout\n");
 	mv_dump_all_regs(ap->host_set->mmio_base, ap->port_no,
 			 to_pci_dev(ap->host_set->dev));
diff --git a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
index ddbc0c6..e9d61bc 100644
--- a/drivers/scsi/sata_promise.c
+++ b/drivers/scsi/sata_promise.c
@@ -435,7 +435,7 @@ static void pdc_eng_timeout(struct ata_p
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
 	case ATA_PROT_NODATA:
-		printk(KERN_ERR "ata%u: command timeout\n", ap->id);
+		ata_port_printk(ap, KERN_ERR, "command timeout\n");
 		drv_stat = ata_wait_idle(ap);
 		qc->err_mask |= __ac_err_mask(drv_stat);
 		break;
@@ -443,8 +443,9 @@ static void pdc_eng_timeout(struct ata_p
 	default:
 		drv_stat = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
 
-		printk(KERN_ERR "ata%u: unknown timeout, cmd 0x%x stat 0x%x\n",
-		       ap->id, qc->tf.command, drv_stat);
+		ata_port_printk(ap, KERN_ERR,
+				"unknown timeout, cmd 0x%x stat 0x%x\n",
+				qc->tf.command, drv_stat);
 
 		qc->err_mask |= ac_err_mask(drv_stat);
 		break;
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index c933357..bfcece1 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -360,16 +360,16 @@ static void sil_dev_config(struct ata_po
 	if (slow_down ||
 	    ((ap->flags & SIL_FLAG_MOD15WRITE) &&
 	     (quirks & SIL_QUIRK_MOD15WRITE))) {
-		printk(KERN_INFO "ata%u(%u): applying Seagate errata fix (mod15write workaround)\n",
-		       ap->id, dev->devno);
+		ata_dev_printk(dev, KERN_INFO, "applying Seagate errata fix "
+			       "(mod15write workaround)\n");
 		dev->max_sectors = 15;
 		return;
 	}
 
 	/* limit to udma5 */
 	if (quirks & SIL_QUIRK_UDMA5MAX) {
-		printk(KERN_INFO "ata%u(%u): applying Maxtor errata fix %s\n",
-		       ap->id, dev->devno, model_num);
+		ata_dev_printk(dev, KERN_INFO,
+			       "applying Maxtor errata fix %s\n", model_num);
 		dev->udma_mask &= ATA_UDMA5;
 		return;
 	}
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 664b138..6144f7c 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -516,7 +516,7 @@ static int sil24_softreset(struct ata_po
 	return 0;
 
  err:
-	printk(KERN_ERR "ata%u: softreset failed (%s)\n", ap->id, reason);
+	ata_port_printk(ap, KERN_ERR, "softreset failed (%s)\n", reason);
 	return -EIO;
 }
 
@@ -561,7 +561,7 @@ static int sil24_hardreset(struct ata_po
 	return 0;
 
  err:
-	printk(KERN_ERR "ata%u: hardreset failed (%s)\n", ap->id, reason);
+	ata_port_printk(ap, KERN_ERR, "hardreset failed (%s)\n", reason);
 	return -EIO;
 }
 
@@ -721,7 +721,7 @@ static void sil24_eng_timeout(struct ata
 
 	qc = ata_qc_from_tag(ap, ap->active_tag);
 
-	printk(KERN_ERR "ata%u: command timeout\n", ap->id);
+	ata_port_printk(ap, KERN_ERR, "command timeout\n");
 	qc->err_mask |= AC_ERR_TIMEOUT;
 	ata_eh_qc_complete(qc);
 
diff --git a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
index a669d05..96d7b73 100644
--- a/drivers/scsi/sata_sx4.c
+++ b/drivers/scsi/sata_sx4.c
@@ -868,15 +868,16 @@ static void pdc_eng_timeout(struct ata_p
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
 	case ATA_PROT_NODATA:
-		printk(KERN_ERR "ata%u: command timeout\n", ap->id);
+		ata_port_printk(ap, KERN_ERR, "command timeout\n");
 		qc->err_mask |= __ac_err_mask(ata_wait_idle(ap));
 		break;
 
 	default:
 		drv_stat = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
 
-		printk(KERN_ERR "ata%u: unknown timeout, cmd 0x%x stat 0x%x\n",
-		       ap->id, qc->tf.command, drv_stat);
+		ata_port_printk(ap, KERN_ERR,
+				"unknown timeout, cmd 0x%x stat 0x%x\n",
+				qc->tf.command, drv_stat);
 
 		qc->err_mask |= ac_err_mask(drv_stat);
 		break;
-- 
1.2.4


