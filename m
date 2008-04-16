From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 05/07] sata_mv add basic port multiplier support
Date: Wed, 16 Apr 2008 14:59:07 -0400
Message-ID: <48064C7B.500@rtr.ca>
References: <48064BCC.5070505@rtr.ca> <48064BF3.8010301@rtr.ca> <48064C15.9090109@rtr.ca> <48064C45.4070208@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2661 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751359AbYDPS7J (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Apr 2008 14:59:09 -0400
In-Reply-To: <48064C45.4070208@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Add basic port-multiplier support to sata_mv.
This works in Command-based-switching mode for Gen-II chipsets,
and in FIS-based-switching mode for Gen-IIe chipsets.

Error handling remains at the primary port level for now
(works okay, but not great).  This will get fixed in a subsequent
patch series for IRQ/EH handling fixes.  There are also some
known NCQ/PMP errata to be dealt with in the near future,
once we have this basic PMP support in place.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2008-04-15 18:23:09.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2008-04-15 18:32:31.000000000 -0400
@@ -40,7 +40,7 @@
 
   5) Investigate problems with PCI Message Signalled Interrupts (MSI).
 
-  6) Add port multiplier support (intermediate)
+  6) Cache frequently-accessed registers in mv_port_priv to reduce overhead.
 
   7) Fix/reenable hot plug/unplug (should happen as a side-effect of (2) above).
 
@@ -528,6 +528,12 @@
 static int mv_stop_edma_engine(void __iomem *port_mmio);
 static void mv_edma_cfg(struct ata_port *ap, int want_ncq);
 
+static void mv_pmp_select(struct ata_port *ap, int pmp);
+static int mv_pmp_hardreset(struct ata_link *link, unsigned int *class,
+				unsigned long deadline);
+static int  mv_softreset(struct ata_link *link, unsigned int *class,
+				unsigned long deadline);
+
 /* .sg_tablesize is (MV_MAX_SG_CT / 2) in the structures below
  * because we have to allow room for worst case splitting of
  * PRDs for 64K boundaries in mv_fill_sg().
@@ -566,14 +572,20 @@
 
 static struct ata_port_operations mv6_ops = {
 	.inherits		= &mv5_ops,
-	.qc_defer		= ata_std_qc_defer,
+	.qc_defer		= sata_pmp_qc_defer_cmd_switch,
 	.dev_config             = mv6_dev_config,
 	.scr_read		= mv_scr_read,
 	.scr_write		= mv_scr_write,
+
+	.pmp_hardreset		= mv_pmp_hardreset,
+	.pmp_softreset		= mv_softreset,
+	.softreset		= mv_softreset,
+	.error_handler		= sata_pmp_error_handler,
 };
 
 static struct ata_port_operations mv_iie_ops = {
 	.inherits		= &mv6_ops,
+	.qc_defer		= ata_std_qc_defer, /* FIS-based switching */
 	.dev_config		= ATA_OP_NULL,
 	.qc_prep		= mv_qc_prep_iie,
 };
@@ -599,6 +611,7 @@
 	},
 	{  /* chip_604x */
 		.flags		= MV_COMMON_FLAGS | MV_6XXX_FLAGS |
+				  ATA_FLAG_PMP | ATA_FLAG_ACPI_SATA |
 				  ATA_FLAG_NCQ,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.udma_mask	= ATA_UDMA6,
@@ -606,6 +619,7 @@
 	},
 	{  /* chip_608x */
 		.flags		= MV_COMMON_FLAGS | MV_6XXX_FLAGS |
+				  ATA_FLAG_PMP | ATA_FLAG_ACPI_SATA |
 				  ATA_FLAG_NCQ | MV_FLAG_DUAL_HC,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.udma_mask	= ATA_UDMA6,
@@ -613,6 +627,7 @@
 	},
 	{  /* chip_6042 */
 		.flags		= MV_COMMON_FLAGS | MV_6XXX_FLAGS |
+				  ATA_FLAG_PMP | ATA_FLAG_ACPI_SATA |
 				  ATA_FLAG_NCQ,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.udma_mask	= ATA_UDMA6,
@@ -620,6 +635,7 @@
 	},
 	{  /* chip_7042 */
 		.flags		= MV_COMMON_FLAGS | MV_6XXX_FLAGS |
+				  ATA_FLAG_PMP | ATA_FLAG_ACPI_SATA |
 				  ATA_FLAG_NCQ,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.udma_mask	= ATA_UDMA6,
@@ -627,6 +643,7 @@
 	},
 	{  /* chip_soc */
 		.flags		= MV_COMMON_FLAGS | MV_6XXX_FLAGS |
+				  ATA_FLAG_PMP | ATA_FLAG_ACPI_SATA |
 				  ATA_FLAG_NCQ | MV_FLAG_SOC,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.udma_mask	= ATA_UDMA6,
@@ -1006,12 +1023,42 @@
 static void mv6_dev_config(struct ata_device *adev)
 {
 	/*
+	 * Deal with Gen-II ("mv6") hardware quirks/restrictions:
+	 *
+	 * Gen-II does not support NCQ over a port multiplier
+	 *  (no FIS-based switching).
+	 *
 	 * We don't have hob_nsect when doing NCQ commands on Gen-II.
 	 * See mv_qc_prep() for more info.
 	 */
-	if (adev->flags & ATA_DFLAG_NCQ)
-		if (adev->max_sectors > ATA_MAX_SECTORS)
+	if (adev->flags & ATA_DFLAG_NCQ) {
+		if (sata_pmp_attached(adev->link->ap))
+			adev->flags &= ~ATA_DFLAG_NCQ;
+		else if (adev->max_sectors > ATA_MAX_SECTORS)
 			adev->max_sectors = ATA_MAX_SECTORS;
+	}
+}
+
+static void mv_config_fbs(void __iomem *port_mmio, int enable_fbs)
+{
+	u32 old_fcfg, new_fcfg, old_ltmode, new_ltmode;
+	/*
+	 * Various bit settings required for operation
+	 * in FIS-based switching (fbs) mode on GenIIe:
+	 */
+	old_fcfg   = readl(port_mmio + FIS_CFG_OFS);
+	old_ltmode = readl(port_mmio + LTMODE_OFS);
+	if (enable_fbs) {
+		new_fcfg   = old_fcfg   |  FIS_CFG_SINGLE_SYNC;
+		new_ltmode = old_ltmode |  LTMODE_BIT8;
+	} else { /* disable fbs */
+		new_fcfg   = old_fcfg   & ~FIS_CFG_SINGLE_SYNC;
+		new_ltmode = old_ltmode & ~LTMODE_BIT8;
+	}
+	if (new_fcfg != old_fcfg)
+		writelfl(new_fcfg, port_mmio + FIS_CFG_OFS);
+	if (new_ltmode != old_ltmode)
+		writelfl(new_ltmode, port_mmio + LTMODE_OFS);
 }
 
 static void mv_edma_cfg(struct ata_port *ap, int want_ncq)
@@ -1035,6 +1082,13 @@
 		cfg |= (1 << 22);	/* enab 4-entry host queue cache */
 		cfg |= (1 << 18);	/* enab early completion */
 		cfg |= (1 << 17);	/* enab cut-through (dis stor&forwrd) */
+
+		if (want_ncq && sata_pmp_attached(ap)) {
+			cfg |= EDMA_CFG_EDMA_FBS; /* FIS-based switching */
+			mv_config_fbs(port_mmio, 1);
+		} else {
+			mv_config_fbs(port_mmio, 0);
+		}
 	}
 
 	if (want_ncq) {
@@ -1240,6 +1294,7 @@
 		flags |= CRQB_FLAG_READ;
 	WARN_ON(MV_MAX_Q_DEPTH <= qc->tag);
 	flags |= qc->tag << CRQB_TAG_SHIFT;
+	flags |= (qc->dev->link->pmp & 0xf) << CRQB_PMP_SHIFT;
 
 	/* get current queue index from software */
 	in_index = pp->req_idx & MV_MAX_Q_DEPTH_MASK;
@@ -1331,6 +1386,7 @@
 	WARN_ON(MV_MAX_Q_DEPTH <= qc->tag);
 	flags |= qc->tag << CRQB_TAG_SHIFT;
 	flags |= qc->tag << CRQB_HOSTQ_SHIFT;
+	flags |= (qc->dev->link->pmp & 0xf) << CRQB_PMP_SHIFT;
 
 	/* get current queue index from software */
 	in_index = pp->req_idx & MV_MAX_Q_DEPTH_MASK;
@@ -1394,6 +1450,7 @@
 		 * shadow block, etc registers.
 		 */
 		mv_stop_edma(ap);
+		mv_pmp_select(ap, qc->dev->link->pmp);
 		return ata_sff_qc_issue(qc);
 	}
 
@@ -2289,6 +2346,34 @@
 		mdelay(1);
 }
 
+static void mv_pmp_select(struct ata_port *ap, int pmp)
+{
+	if (sata_pmp_supported(ap)) {
+		void __iomem *port_mmio = mv_ap_base(ap);
+		u32 reg = readl(port_mmio + SATA_IFCTL_OFS);
+		int old = reg & 0xf;
+
+		if (old != pmp) {
+			reg = (reg & ~0xf) | pmp;
+			writelfl(reg, port_mmio + SATA_IFCTL_OFS);
+		}
+	}
+}
+
+static int mv_pmp_hardreset(struct ata_link *link, unsigned int *class,
+				unsigned long deadline)
+{
+	mv_pmp_select(link->ap, sata_srst_pmp(link));
+	return sata_std_hardreset(link, class, deadline);
+}
+
+static int mv_softreset(struct ata_link *link, unsigned int *class,
+				unsigned long deadline)
+{
+	mv_pmp_select(link->ap, sata_srst_pmp(link));
+	return ata_sff_softreset(link, class, deadline);
+}
+
 static int mv_hardreset(struct ata_link *link, unsigned int *class,
 			unsigned long deadline)
 {
