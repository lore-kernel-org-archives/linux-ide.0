From: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] libata MWDMA support, xfer mode rework
Date: Sun, 04 Jul 2004 17:38:40 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40E878E0.3070505@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020208090509060005050006"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38360 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265798AbUGDViz
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 4 Jul 2004 17:38:55 -0400
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>

This is a multi-part message in MIME format.
--------------020208090509060005050006
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Since I need MWDMA support to make a few of my CD-ROMs work :) I hacked 
it into libata.  It doesn't seem to break anything.

But enable the #if 0 in ata_piix (enables mwdma timings), the IDE 
controller locks up.  So, more work needed, probably in the ata_piix driver.

	Jeff




--------------020208090509060005050006
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

# ChangeSet
#   2004/07/04 17:35:29-04:00 jgarzik@pobox.com 
#   [libata] transfer mode cleanup
#   
#   Add MWDMA support, and rework pio/mwdma/udma mode setup.
#   
#   In the lone test case for PATA support, ata_piix, MWDMA mode setting
#   does not appear to work here.  UDMA and PIO continue to work, so nobody
#   will really notice.  But beware.  Probably a driver problem, not
#   a bug in the core.
#   
#   Also, doesn't bother writing to dummy timing registers on ICH5/6 SATA
#   anymore.
# 
diff -Nru a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
--- a/drivers/scsi/ata_piix.c	2004-07-04 17:35:44 -04:00
+++ b/drivers/scsi/ata_piix.c	2004-07-04 17:35:44 -04:00
@@ -65,10 +65,8 @@
 
 static void piix_pata_phy_reset(struct ata_port *ap);
 static void piix_sata_phy_reset(struct ata_port *ap);
-static void piix_set_piomode (struct ata_port *ap, struct ata_device *adev,
-			      unsigned int pio);
-static void piix_set_udmamode (struct ata_port *ap, struct ata_device *adev,
-			       unsigned int udma);
+static void piix_set_piomode (struct ata_port *ap, struct ata_device *adev);
+static void piix_set_dmamode (struct ata_port *ap, struct ata_device *adev);
 
 static unsigned int in_module_init = 1;
 
@@ -126,7 +124,7 @@
 static struct ata_port_operations piix_pata_ops = {
 	.port_disable		= ata_port_disable,
 	.set_piomode		= piix_set_piomode,
-	.set_udmamode		= piix_set_udmamode,
+	.set_dmamode		= piix_set_dmamode,
 
 	.tf_load		= ata_tf_load_pio,
 	.tf_read		= ata_tf_read_pio,
@@ -151,8 +149,6 @@
 
 static struct ata_port_operations piix_sata_ops = {
 	.port_disable		= ata_port_disable,
-	.set_piomode		= piix_set_piomode,
-	.set_udmamode		= piix_set_udmamode,
 
 	.tf_load		= ata_tf_load_pio,
 	.tf_read		= ata_tf_read_pio,
@@ -181,7 +177,12 @@
 		.sht		= &piix_sht,
 		.host_flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST |
 				  PIIX_FLAG_CHECKINTR,
-		.pio_mask	= 0x03,	/* pio3-4 */
+		.pio_mask	= 0x1f,	/* pio0-4 */
+#if 0
+		.mwdma_mask	= 0x06, /* mwdma1-2 */
+#else
+		.mwdma_mask	= 0x00, /* mwdma broken */
+#endif
 		.udma_mask	= ATA_UDMA_MASK_40C, /* FIXME: cbl det */
 		.port_ops	= &piix_pata_ops,
 	},
@@ -191,8 +192,9 @@
 		.sht		= &piix_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_SRST |
 				  PIIX_FLAG_COMBINED | PIIX_FLAG_CHECKINTR,
-		.pio_mask	= 0x03,	/* pio3-4 */
-		.udma_mask	= 0x7f,	/* udma0-6 ; FIXME */
+		.pio_mask	= 0x1f,	/* pio0-4 */
+		.mwdma_mask	= 0x07, /* mwdma0-2 */
+		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &piix_sata_ops,
 	},
 
@@ -200,7 +202,12 @@
 	{
 		.sht		= &piix_sht,
 		.host_flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
-		.pio_mask	= 0x03, /* pio3-4 */
+		.pio_mask	= 0x1f,	/* pio0-4 */
+#if 0
+		.mwdma_mask	= 0x06, /* mwdma1-2 */
+#else
+		.mwdma_mask	= 0x00, /* mwdma broken */
+#endif
 		.udma_mask	= ATA_UDMA_MASK_40C, /* FIXME: cbl det */
 		.port_ops	= &piix_pata_ops,
 	},
@@ -211,8 +218,9 @@
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_SRST |
 				  PIIX_FLAG_COMBINED | PIIX_FLAG_CHECKINTR |
 				  ATA_FLAG_SLAVE_POSS,
-		.pio_mask	= 0x03,	/* pio3-4 */
-		.udma_mask	= 0x7f,	/* udma0-6 ; FIXME */
+		.pio_mask	= 0x1f,	/* pio0-4 */
+		.mwdma_mask	= 0x07, /* mwdma0-2 */
+		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &piix_sata_ops,
 	},
 };
@@ -368,9 +376,9 @@
  *	None (inherited from caller).
  */
 
-static void piix_set_piomode (struct ata_port *ap, struct ata_device *adev,
-			      unsigned int pio)
+static void piix_set_piomode (struct ata_port *ap, struct ata_device *adev)
 {
+	unsigned int pio	= adev->pio_mode;
 	struct pci_dev *dev	= ap->host_set->pdev;
 	unsigned int is_slave	= (adev->flags & ATA_DFLAG_MASTER) ? 0 : 1;
 	unsigned int master_port= ap->port_no ? 0x42 : 0x40;
@@ -409,7 +417,7 @@
 }
 
 /**
- *	piix_set_udmamode - Initialize host controller PATA PIO timings
+ *	piix_set_dmamode - Initialize host controller PATA PIO timings
  *	@ap: Port whose timings we are configuring
  *	@adev: um
  *	@udma: udma mode, 0 - 6
@@ -420,9 +428,9 @@
  *	None (inherited from caller).
  */
 
-static void piix_set_udmamode (struct ata_port *ap, struct ata_device *adev,
-			      unsigned int udma)
+static void piix_set_dmamode (struct ata_port *ap, struct ata_device *adev)
 {
+	unsigned int udma	= adev->dma_mode; /* FIXME: MWDMA too */
 	struct pci_dev *dev	= ap->host_set->pdev;
 	u8 maslave		= ap->port_no ? 0x42 : 0x40;
 	u8 speed		= udma;
@@ -452,25 +460,38 @@
 		case XFER_UDMA_3:
 		case XFER_UDMA_1:	u_speed = 1 << (drive_dn * 4); break;
 		case XFER_UDMA_0:	u_speed = 0 << (drive_dn * 4); break;
+		case XFER_MW_DMA_2:
+		case XFER_MW_DMA_1:	break;
 		default:
 			BUG();
 			return;
 	}
 
-	if (!(reg48 & u_flag))
-		pci_write_config_byte(dev, 0x48, reg48 | u_flag);
-	if (speed == XFER_UDMA_5) {
-		pci_write_config_byte(dev, 0x55, (u8) reg55|w_flag);
+	if (speed >= XFER_UDMA_0) {
+		if (!(reg48 & u_flag))
+			pci_write_config_byte(dev, 0x48, reg48 | u_flag);
+		if (speed == XFER_UDMA_5) {
+			pci_write_config_byte(dev, 0x55, (u8) reg55|w_flag);
+		} else {
+			pci_write_config_byte(dev, 0x55, (u8) reg55 & ~w_flag);
+		}
+		if ((reg4a & a_speed) != u_speed)
+			pci_write_config_word(dev, 0x4a, (reg4a & ~a_speed) | u_speed);
+		if (speed > XFER_UDMA_2) {
+			if (!(reg54 & v_flag))
+				pci_write_config_byte(dev, 0x54, reg54 | v_flag);
+		} else
+			pci_write_config_byte(dev, 0x54, reg54 & ~v_flag);
 	} else {
-		pci_write_config_byte(dev, 0x55, (u8) reg55 & ~w_flag);
+		if (reg48 & u_flag)
+			pci_write_config_byte(dev, 0x48, reg48 & ~u_flag);
+		if (reg4a & a_speed)
+			pci_write_config_word(dev, 0x4a, reg4a & ~a_speed);
+		if (reg54 & v_flag)
+			pci_write_config_byte(dev, 0x54, reg54 & ~v_flag);
+		if (reg55 & w_flag)
+			pci_write_config_byte(dev, 0x55, (u8) reg55 & ~w_flag);
 	}
-	if ((reg4a & a_speed) != u_speed)
-		pci_write_config_word(dev, 0x4a, (reg4a & ~a_speed) | u_speed);
-	if (speed > XFER_UDMA_2) {
-		if (!(reg54 & v_flag))
-			pci_write_config_byte(dev, 0x54, reg54 | v_flag);
-	} else
-		pci_write_config_byte(dev, 0x54, reg54 & ~v_flag);
 }
 
 /* move to PCI layer, integrate w/ MSI stuff */
diff -Nru a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c	2004-07-04 17:35:44 -04:00
+++ b/drivers/scsi/libata-core.c	2004-07-04 17:35:44 -04:00
@@ -50,11 +50,13 @@
 				    unsigned long tmout_pat,
 			    	    unsigned long tmout);
 static void __ata_dev_select (struct ata_port *ap, unsigned int device);
-static void ata_host_set_pio(struct ata_port *ap);
-static void ata_host_set_udma(struct ata_port *ap);
-static void ata_dev_set_pio(struct ata_port *ap, unsigned int device);
-static void ata_dev_set_udma(struct ata_port *ap, unsigned int device);
 static void ata_set_mode(struct ata_port *ap);
+static void ata_dev_set_xfermode(struct ata_port *ap, struct ata_device *dev);
+static unsigned int ata_get_mode_mask(struct ata_port *ap, int shift);
+static int fgb(unsigned long bitmap);
+static int ata_choose_xfer_mode(struct ata_port *ap,
+				unsigned int *xfer_mode_out,
+				unsigned int *xfer_shift_out);
 
 static unsigned int ata_unique_id = 1;
 static struct workqueue_struct *ata_wq;
@@ -524,7 +526,7 @@
 	dev->write_cmd = (cmd >> 8) & 0xff;
 }
 
-static const char * udma_str[] = {
+static const char * xfer_mode_str[] = {
 	"UDMA/16",
 	"UDMA/25",
 	"UDMA/33",
@@ -533,6 +535,14 @@
 	"UDMA/100",
 	"UDMA/133",
 	"UDMA7",
+	"MWDMA0",
+	"MWDMA1",
+	"MWDMA2",
+	"PIO0",
+	"PIO1",
+	"PIO2",
+	"PIO3",
+	"PIO4",
 };
 
 /**
@@ -550,16 +560,24 @@
  *	@udma_mask, or the constant C string "<n/a>".
  */
 
-static const char *ata_udma_string(unsigned int udma_mask)
+static const char *ata_mode_string(unsigned int mask)
 {
 	int i;
 
-	for (i = 7; i >= 0; i--) {
-		if (udma_mask & (1 << i))
-			return udma_str[i];
-	}
+	for (i = 7; i >= 0; i--)
+		if (mask & (1 << i))
+			goto out;
+	for (i = ATA_SHIFT_MWDMA + 2; i >= ATA_SHIFT_MWDMA; i--)
+		if (mask & (1 << i))
+			goto out;
+	for (i = ATA_SHIFT_PIO + 4; i >= ATA_SHIFT_PIO; i--)
+		if (mask & (1 << i))
+			goto out;
 
 	return "<n/a>";
+
+out:
+	return xfer_mode_str[i];
 }
 
 /**
@@ -930,7 +948,7 @@
 {
 	struct ata_device *dev = &ap->device[device];
 	unsigned int i;
-	u16 tmp, udma_modes;
+	u16 tmp, xfer_modes;
 	u8 status;
 	struct ata_taskfile tf;
 	unsigned int using_edd;
@@ -1046,11 +1064,12 @@
 	}
 
 	/* we require UDMA support */
-	udma_modes =
-	tmp = dev->id[ATA_ID_UDMA_MODES];
-	if ((tmp & 0xff) == 0) {
-		printk(KERN_DEBUG "ata%u: no udma\n", ap->id);
-		goto err_out_nosup;
+	xfer_modes = dev->id[ATA_ID_UDMA_MODES];
+	if (!xfer_modes)
+		xfer_modes = (dev->id[ATA_ID_MWDMA_MODES]) << ATA_SHIFT_MWDMA;
+	if (!xfer_modes) {
+		xfer_modes = (dev->id[ATA_ID_PIO_MODES]) << (ATA_SHIFT_PIO + 3);
+		xfer_modes |= (0x7 << ATA_SHIFT_PIO);
 	}
 
 	ata_dump_id(dev);
@@ -1083,7 +1102,7 @@
 		/* print device info to dmesg */
 		printk(KERN_INFO "ata%u: dev %u ATA, max %s, %Lu sectors:%s\n",
 		       ap->id, device,
-		       ata_udma_string(udma_modes),
+		       ata_mode_string(xfer_modes),
 		       (unsigned long long)dev->n_sectors,
 		       dev->flags & ATA_DFLAG_LBA48 ? " lba48" : "");
 	}
@@ -1101,7 +1120,7 @@
 		/* print device info to dmesg */
 		printk(KERN_INFO "ata%u: dev %u ATAPI, max %s\n",
 		       ap->id, device,
-		       ata_udma_string(udma_modes));
+		       ata_mode_string(xfer_modes));
 	}
 
 	DPRINTK("EXIT, drv_stat = 0x%x\n", ata_chk_status(ap));
@@ -1232,6 +1251,89 @@
 	ap->flags |= ATA_FLAG_PORT_DISABLED;
 }
 
+static struct {
+	unsigned int shift;
+	unsigned int base;
+} xfer_mode_classes[] = {
+	{ ATA_SHIFT_UDMA,	XFER_UDMA_0 },
+	{ ATA_SHIFT_MWDMA,	XFER_MW_DMA_0 },
+	{ ATA_SHIFT_PIO,	XFER_PIO_0 },
+};
+
+static inline unsigned int base_from_shift(unsigned int shift)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(xfer_mode_classes); i++)
+		if (xfer_mode_classes[i].shift == shift)
+			return xfer_mode_classes[i].base;
+
+	return 0xffffffff;
+}
+
+static void ata_dev_set_mode(struct ata_port *ap, struct ata_device *dev)
+{
+	unsigned int base, offset;
+
+	if (!ata_dev_present(dev) || (ap->flags & ATA_FLAG_PORT_DISABLED))
+		return;
+
+	ata_dev_set_xfermode(ap, dev);
+
+	base = base_from_shift(dev->xfer_shift);
+	offset = dev->xfer_mode - base;
+
+	printk(KERN_INFO "ata%u: dev %u configured for %s\n",
+		ap->id, dev->devno,
+		xfer_mode_str[offset + dev->xfer_shift]);
+}
+
+static int ata_host_set_pio(struct ata_port *ap)
+{
+	unsigned int mask, base, xfer_mode;
+	int x, i;
+
+	mask = ata_get_mode_mask(ap, ATA_SHIFT_PIO);
+	x = fgb(mask);
+	if (x < 0) {
+		printk(KERN_WARNING "ata%u: no PIO support\n", ap->id);
+		return -1;
+	}
+
+	base = base_from_shift(ATA_SHIFT_PIO);
+	xfer_mode = base + x;
+
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		struct ata_device *dev = &ap->device[i];
+		if (ata_dev_present(dev)) {
+			dev->pio_mode = xfer_mode;
+			dev->xfer_mode = xfer_mode;
+			dev->xfer_shift = ATA_SHIFT_PIO;
+			if (ap->ops->set_piomode)
+				ap->ops->set_piomode(ap, dev);
+		}
+	}
+
+	return 0;
+}
+
+static void ata_host_set_dma(struct ata_port *ap, unsigned int xfer_mode,
+			    unsigned int xfer_shift)
+{
+	int i;
+
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		struct ata_device *dev = &ap->device[i];
+		if (ata_dev_present(dev)) {
+			dev->dma_mode = xfer_mode;
+			dev->xfer_mode = xfer_mode;
+			dev->xfer_shift = xfer_shift;
+			if (ap->ops->set_dmamode)
+				ap->ops->set_dmamode(ap, dev);
+		}
+	}
+}
+
 /**
  *	ata_set_mode - Program timings and issue SET FEATURES - XFER
  *	@ap: port on which timings will be programmed
@@ -1241,29 +1343,27 @@
  */
 static void ata_set_mode(struct ata_port *ap)
 {
-	unsigned int force_pio, i;
-
-	ata_host_set_pio(ap);
-	if (ap->flags & ATA_FLAG_PORT_DISABLED)
-		return;
+	unsigned int i, xfer_mode, xfer_shift;
+	int rc;
 
-	ata_host_set_udma(ap);
-	if (ap->flags & ATA_FLAG_PORT_DISABLED)
-		return;
+	/* step 1: always set host PIO timings */
+	rc = ata_host_set_pio(ap);
+	if (rc)
+		goto err_out;
 
-#ifdef ATA_FORCE_PIO
-	force_pio = 1;
-#else
-	force_pio = 0;
-#endif
+	/* step 2: choose the best data xfer mode */
+	xfer_mode = xfer_shift = 0;
+	rc = ata_choose_xfer_mode(ap, &xfer_mode, &xfer_shift);
+	if (rc)
+		goto err_out;
 
-	if (force_pio) {
-		ata_dev_set_pio(ap, 0);
-		ata_dev_set_pio(ap, 1);
-	} else {
-		ata_dev_set_udma(ap, 0);
-		ata_dev_set_udma(ap, 1);
-	}
+	/* step 3: if that xfer mode isn't PIO, set host DMA timings */
+	if (xfer_shift != ATA_SHIFT_PIO)
+		ata_host_set_dma(ap, xfer_mode, xfer_shift);
+
+	/* step 4: update devices' xfer mode */
+	ata_dev_set_mode(ap, &ap->device[0]);
+	ata_dev_set_mode(ap, &ap->device[1]);
 
 	if (ap->flags & ATA_FLAG_PORT_DISABLED)
 		return;
@@ -1275,6 +1375,11 @@
 		struct ata_device *dev = &ap->device[i];
 		ata_dev_set_protocol(dev);
 	}
+
+	return;
+
+err_out:
+	ata_port_disable(ap);
 }
 
 /**
@@ -1536,116 +1641,101 @@
 	DPRINTK("EXIT\n");
 }
 
-/**
- *	ata_host_set_pio -
- *	@ap:
- *
- *	LOCKING:
- */
-
-static void ata_host_set_pio(struct ata_port *ap)
+static unsigned int ata_get_mode_mask(struct ata_port *ap, int shift)
 {
 	struct ata_device *master, *slave;
-	unsigned int pio, i;
-	u16 mask;
+	unsigned int mask;
 
 	master = &ap->device[0];
 	slave = &ap->device[1];
 
 	assert (ata_dev_present(master) || ata_dev_present(slave));
 
-	mask = ap->pio_mask;
-	if (ata_dev_present(master))
-		mask &= (master->id[ATA_ID_PIO_MODES] & 0x03);
-	if (ata_dev_present(slave))
-		mask &= (slave->id[ATA_ID_PIO_MODES] & 0x03);
-
-	/* require pio mode 3 or 4 support for host and all devices */
-	if (mask == 0) {
-		printk(KERN_WARNING "ata%u: no PIO3/4 support, ignoring\n",
-		       ap->id);
-		goto err_out;
+	if (shift == ATA_SHIFT_UDMA) {
+		mask = ap->udma_mask;
+		if (ata_dev_present(master))
+			mask &= (master->id[ATA_ID_UDMA_MODES] & 0xff);
+		if (ata_dev_present(slave))
+			mask &= (slave->id[ATA_ID_UDMA_MODES] & 0xff);
+	}
+	else if (shift == ATA_SHIFT_MWDMA) {
+		mask = ap->mwdma_mask;
+		if (ata_dev_present(master))
+			mask &= (master->id[ATA_ID_MWDMA_MODES] & 0x07);
+		if (ata_dev_present(slave))
+			mask &= (slave->id[ATA_ID_MWDMA_MODES] & 0x07);
+	}
+	else if (shift == ATA_SHIFT_PIO) {
+		mask = ap->pio_mask;
+		if (ata_dev_present(master)) {
+			/* spec doesn't return explicit support for
+			 * PIO0-2, so we fake it
+			 */
+			u16 tmp_mode = master->id[ATA_ID_PIO_MODES] & 0x03;
+			tmp_mode <<= 3;
+			tmp_mode |= 0x7;
+			mask &= tmp_mode;
+		}
+		if (ata_dev_present(slave)) {
+			/* spec doesn't return explicit support for
+			 * PIO0-2, so we fake it
+			 */
+			u16 tmp_mode = slave->id[ATA_ID_PIO_MODES] & 0x03;
+			tmp_mode <<= 3;
+			tmp_mode |= 0x7;
+			mask &= tmp_mode;
+		}
+	}
+	else {
+		mask = 0xffffffff; /* shut up compiler warning */
+		BUG();
 	}
 
-	pio = (mask & ATA_ID_PIO4) ? 4 : 3;
-	for (i = 0; i < ATA_MAX_DEVICES; i++)
-		if (ata_dev_present(&ap->device[i])) {
-			ap->device[i].pio_mode = (pio == 3) ?
-				XFER_PIO_3 : XFER_PIO_4;
-			if (ap->ops->set_piomode)
-				ap->ops->set_piomode(ap, &ap->device[i], pio);
-		}
+	return mask;
+}
 
-	return;
+/* find greatest bit */
+static int fgb(unsigned long bitmap)
+{
+	int i, x = -1;
 
-err_out:
-	ap->ops->port_disable(ap);
+	for (i = 0; i < (sizeof(unsigned long) * 8); i++)
+		if (bitmap & (1 << i))
+			x = i;
+	
+	return x;
 }
 
 /**
- *	ata_host_set_udma -
+ *	ata_choose_xfer_mode - 
  *	@ap:
  *
  *	LOCKING:
+ *
+ *	RETURNS:
+ *	Zero on success, negative on error.
  */
 
-static void ata_host_set_udma(struct ata_port *ap)
-{
-	struct ata_device *master, *slave;
-	u16 mask;
-	unsigned int i, j;
-	int udma_mode = -1;
-
-	master = &ap->device[0];
-	slave = &ap->device[1];
-
-	assert (ata_dev_present(master) || ata_dev_present(slave));
-	assert ((ap->flags & ATA_FLAG_PORT_DISABLED) == 0);
-
-	DPRINTK("udma masks: host 0x%X, master 0x%X, slave 0x%X\n",
-		ap->udma_mask,
-		(!ata_dev_present(master)) ? 0xff :
-			(master->id[ATA_ID_UDMA_MODES] & 0xff),
-		(!ata_dev_present(slave)) ? 0xff :
-			(slave->id[ATA_ID_UDMA_MODES] & 0xff));
-
-	mask = ap->udma_mask;
-	if (ata_dev_present(master))
-		mask &= (master->id[ATA_ID_UDMA_MODES] & 0xff);
-	if (ata_dev_present(slave))
-		mask &= (slave->id[ATA_ID_UDMA_MODES] & 0xff);
-
-	i = XFER_UDMA_7;
-	while (i >= XFER_UDMA_0) {
-		j = i - XFER_UDMA_0;
-		DPRINTK("mask 0x%X i 0x%X j %u\n", mask, i, j);
-		if (mask & (1 << j)) {
-			udma_mode = i;
-			break;
+static int ata_choose_xfer_mode(struct ata_port *ap,
+				unsigned int *xfer_mode_out,
+				unsigned int *xfer_shift_out)
+{
+	unsigned int mask, shift;
+	int x, i;
+
+	for (i = 0; i < ARRAY_SIZE(xfer_mode_classes); i++) {
+		shift = xfer_mode_classes[i].shift;
+		mask = ata_get_mode_mask(ap, shift);
+
+		x = fgb(mask);
+		if (x >= 0) {
+			*xfer_mode_out = xfer_mode_classes[i].base + x;
+			*xfer_shift_out = shift;
+			return 0;
 		}
-
-		i--;
-	}
-
-	/* require udma for host and all attached devices */
-	if (udma_mode < 0) {
-		printk(KERN_WARNING "ata%u: no UltraDMA support, ignoring\n",
-		       ap->id);
-		goto err_out;
 	}
 
-	for (i = 0; i < ATA_MAX_DEVICES; i++)
-		if (ata_dev_present(&ap->device[i])) {
-			ap->device[i].udma_mode = udma_mode;
-			if (ap->ops->set_udmamode)
-				ap->ops->set_udmamode(ap, &ap->device[i],
-						      udma_mode);
-		}
-
-	return;
-
-err_out:
-	ap->ops->port_disable(ap);
+	return -1;
 }
 
 /**
@@ -1668,10 +1758,7 @@
 	tf.feature = SETFEATURES_XFER;
 	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	tf.protocol = ATA_PROT_NODATA;
-	if (dev->flags & ATA_DFLAG_PIO)
-		tf.nsect = dev->pio_mode;
-	else
-		tf.nsect = dev->udma_mode;
+	tf.nsect = dev->xfer_mode;
 
 	/* do bus reset */
 	ata_tf_to_host(ap, &tf);
@@ -1690,57 +1777,6 @@
 }
 
 /**
- *	ata_dev_set_udma - Set ATA device's transfer mode to Ultra DMA
- *	@ap: Port associated with device @dev
- *	@device: Device whose mode will be set
- *
- *	LOCKING:
- */
-
-static void ata_dev_set_udma(struct ata_port *ap, unsigned int device)
-{
-	struct ata_device *dev = &ap->device[device];
-
-	if (!ata_dev_present(dev) || (ap->flags & ATA_FLAG_PORT_DISABLED))
-		return;
-
-	ata_dev_set_xfermode(ap, dev);
-
-	assert((dev->udma_mode >= XFER_UDMA_0) &&
-	       (dev->udma_mode <= XFER_UDMA_7));
-	printk(KERN_INFO "ata%u: dev %u configured for %s\n",
-	       ap->id, device,
-	       udma_str[dev->udma_mode - XFER_UDMA_0]);
-}
-
-/**
- *	ata_dev_set_pio - Set ATA device's transfer mode to PIO
- *	@ap: Port associated with device @dev
- *	@device: Device whose mode will be set
- *
- *	LOCKING:
- */
-
-static void ata_dev_set_pio(struct ata_port *ap, unsigned int device)
-{
-	struct ata_device *dev = &ap->device[device];
-
-	if (!ata_dev_present(dev) || (ap->flags & ATA_FLAG_PORT_DISABLED))
-		return;
-
-	/* force PIO mode */
-	dev->flags |= ATA_DFLAG_PIO;
-
-	ata_dev_set_xfermode(ap, dev);
-
-	assert((dev->pio_mode >= XFER_PIO_3) &&
-	       (dev->pio_mode <= XFER_PIO_4));
-	printk(KERN_INFO "ata%u: dev %u configured for PIO%c\n",
-	       ap->id, device,
-	       dev->pio_mode == 3 ? '3' : '4');
-}
-
-/**
  *	ata_sg_clean -
  *	@qc:
  *
@@ -2801,6 +2837,7 @@
 	ap->host_set = host_set;
 	ap->port_no = port_no;
 	ap->pio_mask = ent->pio_mask;
+	ap->mwdma_mask = ent->mwdma_mask;
 	ap->udma_mask = ent->udma_mask;
 	ap->flags |= ent->host_flags;
 	ap->ops = ent->port_ops;
@@ -2898,19 +2935,23 @@
 	/* register each port bound to this device */
 	for (i = 0; i < ent->n_ports; i++) {
 		struct ata_port *ap;
+		unsigned int xfer_mode_mask;
 
 		ap = ata_host_add(ent, host_set, i);
 		if (!ap)
 			goto err_out;
 
 		host_set->ports[i] = ap;
+		xfer_mode_mask =(ap->udma_mask << ATA_SHIFT_UDMA) |
+				(ap->mwdma_mask << ATA_SHIFT_MWDMA) |
+				(ap->pio_mask << ATA_SHIFT_PIO);
 
 		/* print per-port info to dmesg */
 		printk(KERN_INFO "ata%u: %cATA max %s cmd 0x%lX ctl 0x%lX "
 				 "bmdma 0x%lX irq %lu\n",
 			ap->id,
 			ap->flags & ATA_FLAG_SATA ? 'S' : 'P',
-			ata_udma_string(ent->udma_mask),
+			ata_mode_string(xfer_mode_mask),
 	       		ap->ioaddr.cmd_addr,
 	       		ap->ioaddr.ctl_addr,
 	       		ap->ioaddr.bmdma_addr,
@@ -3149,6 +3190,7 @@
 	probe_ent->sht = port0->sht;
 	probe_ent->host_flags = port0->host_flags;
 	probe_ent->pio_mask = port0->pio_mask;
+	probe_ent->mwdma_mask = port0->mwdma_mask;
 	probe_ent->udma_mask = port0->udma_mask;
 	probe_ent->port_ops = port0->port_ops;
 
@@ -3171,6 +3213,7 @@
 		probe_ent2->sht = port1->sht;
 		probe_ent2->host_flags = port1->host_flags;
 		probe_ent2->pio_mask = port1->pio_mask;
+		probe_ent2->mwdma_mask = port1->mwdma_mask;
 		probe_ent2->udma_mask = port1->udma_mask;
 		probe_ent2->port_ops = port1->port_ops;
 	} else {
diff -Nru a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
--- a/drivers/scsi/sata_nv.c	2004-07-04 17:35:44 -04:00
+++ b/drivers/scsi/sata_nv.c	2004-07-04 17:35:44 -04:00
@@ -39,6 +39,7 @@
 
 #define NV_PORTS			2
 #define NV_PIO_MASK			0x1f
+#define NV_MWDMA_MASK			0x07
 #define NV_UDMA_MASK			0x7f
 #define NV_PORT0_BMDMA_REG_OFFSET	0x00
 #define NV_PORT1_BMDMA_REG_OFFSET	0x08
@@ -289,6 +290,7 @@
 	probe_ent->irq = pdev->irq;
 	probe_ent->irq_flags = SA_SHIRQ;
 	probe_ent->pio_mask = NV_PIO_MASK;
+	probe_ent->mwdma_mask = NV_MWDMA_MASK;
 	probe_ent->udma_mask = NV_UDMA_MASK;
 
 	probe_ent->port[0].cmd_addr = pci_resource_start(pdev, 0);
diff -Nru a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
--- a/drivers/scsi/sata_promise.c	2004-07-04 17:35:44 -04:00
+++ b/drivers/scsi/sata_promise.c	2004-07-04 17:35:44 -04:00
@@ -130,7 +130,8 @@
 		.sht		= &pdc_sata_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_SRST | ATA_FLAG_MMIO,
-		.pio_mask	= 0x03, /* pio3-4 */
+		.pio_mask	= 0x1f, /* pio0-4 */
+		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
 		.port_ops	= &pdc_sata_ops,
 	},
@@ -140,7 +141,8 @@
 		.sht		= &pdc_sata_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_SRST | ATA_FLAG_MMIO,
-		.pio_mask	= 0x03, /* pio3-4 */
+		.pio_mask	= 0x1f, /* pio0-4 */
+		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
 		.port_ops	= &pdc_sata_ops,
 	},
@@ -601,6 +603,7 @@
 	probe_ent->sht		= pdc_port_info[board_idx].sht;
 	probe_ent->host_flags	= pdc_port_info[board_idx].host_flags;
 	probe_ent->pio_mask	= pdc_port_info[board_idx].pio_mask;
+	probe_ent->mwdma_mask	= pdc_port_info[board_idx].mwdma_mask;
 	probe_ent->udma_mask	= pdc_port_info[board_idx].udma_mask;
 	probe_ent->port_ops	= pdc_port_info[board_idx].port_ops;
 
diff -Nru a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
--- a/drivers/scsi/sata_sil.c	2004-07-04 17:35:44 -04:00
+++ b/drivers/scsi/sata_sil.c	2004-07-04 17:35:44 -04:00
@@ -149,7 +149,8 @@
 		.sht		= &sil_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_SRST | ATA_FLAG_MMIO,
-		.pio_mask	= 0x03,			/* pio3-4 */
+		.pio_mask	= 0x1f,			/* pio0-4 */
+		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= 0x3f,			/* udma0-5 */
 		.port_ops	= &sil_ops,
 	}, /* sil_3114 */
@@ -157,7 +158,8 @@
 		.sht		= &sil_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_SRST | ATA_FLAG_MMIO,
-		.pio_mask	= 0x03,			/* pio3-4 */
+		.pio_mask	= 0x1f,			/* pio0-4 */
+		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= 0x3f,			/* udma0-5 */
 		.port_ops	= &sil_ops,
 	},
@@ -363,6 +365,7 @@
 	probe_ent->sht = sil_port_info[ent->driver_data].sht;
 	probe_ent->n_ports = (ent->driver_data == sil_3114) ? 4 : 2;
 	probe_ent->pio_mask = sil_port_info[ent->driver_data].pio_mask;
+	probe_ent->mwdma_mask = sil_port_info[ent->driver_data].mwdma_mask;
 	probe_ent->udma_mask = sil_port_info[ent->driver_data].udma_mask;
        	probe_ent->irq = pdev->irq;
        	probe_ent->irq_flags = SA_SHIRQ;
diff -Nru a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
--- a/drivers/scsi/sata_sis.c	2004-07-04 17:35:44 -04:00
+++ b/drivers/scsi/sata_sis.c	2004-07-04 17:35:44 -04:00
@@ -230,7 +230,8 @@
 		probe_ent->host_flags |= SIS_FLAG_CFGSCR;
 	}
 
-	probe_ent->pio_mask = 0x03;
+	probe_ent->pio_mask = 0x1f;
+	probe_ent->mwdma_mask = 0x7;
 	probe_ent->udma_mask = 0x7f;
 	probe_ent->port_ops = &sis_ops;
 
diff -Nru a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
--- a/drivers/scsi/sata_svw.c	2004-07-04 17:35:44 -04:00
+++ b/drivers/scsi/sata_svw.c	2004-07-04 17:35:44 -04:00
@@ -343,6 +343,7 @@
 	 * if we don't fill these
 	 */
 	probe_ent->pio_mask = 0x1f;
+	probe_ent->mwdma_mask = 0x7;
 	probe_ent->udma_mask = 0x7f;
 
 	/* We have 4 ports per PCI function */
diff -Nru a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
--- a/drivers/scsi/sata_sx4.c	2004-07-04 17:35:44 -04:00
+++ b/drivers/scsi/sata_sx4.c	2004-07-04 17:35:44 -04:00
@@ -217,7 +217,8 @@
 		.sht		= &pdc_sata_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_SRST | ATA_FLAG_MMIO,
-		.pio_mask	= 0x03, /* pio3-4 */
+		.pio_mask	= 0x1f, /* pio0-4 */
+		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
 		.port_ops	= &pdc_20621_ops,
 	},
@@ -1384,6 +1385,7 @@
 	probe_ent->sht		= pdc_port_info[board_idx].sht;
 	probe_ent->host_flags	= pdc_port_info[board_idx].host_flags;
 	probe_ent->pio_mask	= pdc_port_info[board_idx].pio_mask;
+	probe_ent->mwdma_mask	= pdc_port_info[board_idx].mwdma_mask;
 	probe_ent->udma_mask	= pdc_port_info[board_idx].udma_mask;
 	probe_ent->port_ops	= pdc_port_info[board_idx].port_ops;
 
diff -Nru a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
--- a/drivers/scsi/sata_via.c	2004-07-04 17:35:44 -04:00
+++ b/drivers/scsi/sata_via.c	2004-07-04 17:35:44 -04:00
@@ -214,6 +214,7 @@
 	probe_ent->irq = pdev->irq;
 	probe_ent->irq_flags = SA_SHIRQ;
 	probe_ent->pio_mask = 0x1f;
+	probe_ent->mwdma_mask = 0x07;
 	probe_ent->udma_mask = 0x7f;
 
 	probe_ent->port[0].cmd_addr = pci_resource_start(pdev, 0);
diff -Nru a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
--- a/drivers/scsi/sata_vsc.c	2004-07-04 17:35:44 -04:00
+++ b/drivers/scsi/sata_vsc.c	2004-07-04 17:35:44 -04:00
@@ -320,6 +320,7 @@
 	 * if we don't fill these
 	 */
 	probe_ent->pio_mask = 0x1f;
+	probe_ent->mwdma_mask = 0x07;
 	probe_ent->udma_mask = 0x7f;
 
 	/* We have 4 ports per PCI function */
diff -Nru a/include/linux/ata.h b/include/linux/ata.h
--- a/include/linux/ata.h	2004-07-04 17:35:44 -04:00
+++ b/include/linux/ata.h	2004-07-04 17:35:44 -04:00
@@ -42,6 +42,7 @@
 	ATA_ID_SERNO_OFS	= 10,
 	ATA_ID_MAJOR_VER	= 80,
 	ATA_ID_PIO_MODES	= 64,
+	ATA_ID_MWDMA_MODES	= 63,
 	ATA_ID_UDMA_MODES	= 88,
 	ATA_ID_PIO4		= (1 << 1),
 
@@ -133,8 +134,14 @@
 	XFER_UDMA_2		= 0x42,
 	XFER_UDMA_1		= 0x41,
 	XFER_UDMA_0		= 0x40,
+	XFER_MW_DMA_2		= 0x22,
+	XFER_MW_DMA_1		= 0x21,
+	XFER_MW_DMA_0		= 0x20,
 	XFER_PIO_4		= 0x0C,
 	XFER_PIO_3		= 0x0B,
+	XFER_PIO_2		= 0x0A,
+	XFER_PIO_1		= 0x09,
+	XFER_PIO_0		= 0x08,
 
 	/* ATAPI stuff */
 	ATAPI_PKT_DMA		= (1 << 0),
diff -Nru a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h	2004-07-04 17:35:44 -04:00
+++ b/include/linux/libata.h	2004-07-04 17:35:44 -04:00
@@ -32,7 +32,6 @@
 /*
  * compile-time options
  */
-#undef ATA_FORCE_PIO		/* do not configure or use DMA */
 #undef ATA_DEBUG		/* debugging output */
 #undef ATA_VERBOSE_DEBUG	/* yet more debugging output */
 #undef ATA_IRQ_TRAP		/* define to ack screaming irqs */
@@ -140,6 +139,13 @@
 	PORT_UNKNOWN		= 0,
 	PORT_ENABLED		= 1,
 	PORT_DISABLED		= 2,
+
+	/* encoding various smaller bitmaps into a single
+	 * unsigned long bitmap
+	 */
+	ATA_SHIFT_UDMA		= 0,
+	ATA_SHIFT_MWDMA		= 8,
+	ATA_SHIFT_PIO		= 11,
 };
 
 enum pio_task_states {
@@ -188,6 +194,7 @@
 	struct ata_ioports	port[ATA_MAX_PORTS];
 	unsigned int		n_ports;
 	unsigned int		pio_mask;
+	unsigned int		mwdma_mask;
 	unsigned int		udma_mask;
 	unsigned int		legacy_mode;
 	unsigned long		irq;
@@ -252,7 +259,9 @@
 	unsigned int		devno;		/* 0 or 1 */
 	u16			id[ATA_ID_WORDS]; /* IDENTIFY xxx DEVICE data */
 	unsigned int		pio_mode;
-	unsigned int		udma_mode;
+	unsigned int		dma_mode;
+	unsigned int		xfer_mode;
+	unsigned int		xfer_shift;	/* ATA_SHIFT_xxx */
 
 	/* cache info about current transfer mode */
 	u8			xfer_protocol;	/* taskfile xfer protocol */
@@ -277,6 +286,7 @@
 	unsigned int		bus_state;
 	unsigned int		port_state;
 	unsigned int		pio_mask;
+	unsigned int		mwdma_mask;
 	unsigned int		udma_mask;
 	unsigned int		cbl;	/* cable type; ATA_CBL_xxx */
 
@@ -303,10 +313,8 @@
 
 	void (*dev_config) (struct ata_port *, struct ata_device *);
 
-	void (*set_piomode) (struct ata_port *, struct ata_device *,
-			     unsigned int);
-	void (*set_udmamode) (struct ata_port *, struct ata_device *,
-			     unsigned int);
+	void (*set_piomode) (struct ata_port *, struct ata_device *);
+	void (*set_dmamode) (struct ata_port *, struct ata_device *);
 
 	void (*tf_load) (struct ata_port *ap, struct ata_taskfile *tf);
 	void (*tf_read) (struct ata_port *ap, struct ata_taskfile *tf);
@@ -342,6 +350,7 @@
 	Scsi_Host_Template	*sht;
 	unsigned long		host_flags;
 	unsigned long		pio_mask;
+	unsigned long		mwdma_mask;
 	unsigned long		udma_mask;
 	struct ata_port_operations	*port_ops;
 };

--------------020208090509060005050006--
