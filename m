From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 02/06] sata_mv: enable ATAPI DMA for GEN_IIE chips
Date: Fri, 13 Feb 2009 00:05:00 -0500
Message-ID: <4994FF7C.2050607@rtr.ca>
References: <4994FF3D.90904@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:35124 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750714AbZBMFFC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Feb 2009 00:05:02 -0500
In-Reply-To: <4994FF3D.90904@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Enable use of (basic) DMA for ATAPI on GEN_IIE chips.
This also gets rid of any need for mv_mode_filter().

Using basic DMA on GEN_IIE requires setting an undocumented
bit in an undocumented register.  For safety, we clear that
bit again when switching back to EDMA mode.

To avoid a performance penalty when switching modes,
we cache the register in port_priv, as already done for other regs.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2009-02-05 10:14:43.000000000 -0500
+++ linux/drivers/ata/sata_mv.c	2009-02-05 10:13:12.000000000 -0500
@@ -345,7 +345,7 @@
  	EDMA_ARB_CFG_OFS	= 0x38,

  	EDMA_HALTCOND_OFS	= 0x60,		/* GenIIe halt conditions */
-
+	EDMA_UNKNOWN_RSVD_OFS	= 0x6C,		/* GenIIe unknown/reserved */

  	BMDMA_CMD_OFS		= 0x224,	/* bmdma command register */
  	BMDMA_STATUS_OFS	= 0x228,	/* bmdma status register */
@@ -447,6 +447,7 @@
  	u32			fiscfg;
  	u32			ltmode;
  	u32			haltcond;
+	u32			unknown_rsvd;
  };

  struct mv_port_priv {
@@ -563,8 +564,6 @@
  static void mv_process_crpb_entries(struct ata_port *ap,
  					struct mv_port_priv *pp);

-static unsigned long mv_mode_filter(struct ata_device *dev,
-				    unsigned long xfer_mask);
  static void mv_sff_irq_clear(struct ata_port *ap);
  static int mv_check_atapi_dma(struct ata_queued_cmd *qc);
  static void mv_bmdma_setup(struct ata_queued_cmd *qc);
@@ -626,7 +625,6 @@
  	.bmdma_start		= mv_bmdma_start,
  	.bmdma_stop		= mv_bmdma_stop,
  	.bmdma_status		= mv_bmdma_status,
-	.mode_filter		= mv_mode_filter,
  };

  static struct ata_port_operations mv_iie_ops = {
@@ -842,6 +840,7 @@
  	pp->cached.fiscfg = readl(port_mmio + FISCFG_OFS);
  	pp->cached.ltmode = readl(port_mmio + LTMODE_OFS);
  	pp->cached.haltcond = readl(port_mmio + EDMA_HALTCOND_OFS);
+	pp->cached.unknown_rsvd = readl(port_mmio + EDMA_UNKNOWN_RSVD_OFS);
  }

  /**
@@ -1252,6 +1251,30 @@
  		writel(new, hpriv->base + MV_GPIO_PORT_CTL_OFS);
  }

+/**
+ * 	mv_bmdma_enable - set a magic bit on GEN_IIE to allow bmdma
+ * 	@ap: Port being initialized
+ *
+ *	There are two DMA modes on these chips:  basic DMA, and EDMA.
+ *
+ *	Bit-0 of the "EDMA RESERVED" register enables/disables use
+ *	of basic DMA on the GEN_IIE versions of the chips.
+ *
+ *	This bit survives EDMA resets, and must be set for basic DMA
+ *	to function, and should be cleared when EDMA is active.
+ */
+static void mv_bmdma_enable_iie(struct ata_port *ap, int enable_bmdma)
+{
+	struct mv_port_priv *pp = ap->private_data;
+	u32 new, *old = &pp->cached.unknown_rsvd;
+
+	if (enable_bmdma)
+		new = *old | 1;
+	else
+		new = *old & ~1;
+	mv_write_cached_reg(mv_ap_base(ap) + EDMA_UNKNOWN_RSVD_OFS, old, new);
+}
+
  static void mv_edma_cfg(struct ata_port *ap, int want_ncq, int want_edma)
  {
  	u32 cfg;
@@ -1297,6 +1320,7 @@
  		}
  		if (hpriv->hp_flags & MV_HP_CUT_THROUGH)
  			cfg |= (1 << 17); /* enab cut-thru (dis stor&forwrd) */
+		mv_bmdma_enable_iie(ap, !want_edma);
  	}

  	if (want_ncq) {
@@ -1465,26 +1489,6 @@
  }

  /**
- *	mv_mode_filter - Allow ATAPI DMA only on GenII chips.
- *	@dev: device whose xfer modes are being configured.
- *
- *	Only the GenII hardware can use DMA with ATAPI drives.
- */
-static unsigned long mv_mode_filter(struct ata_device *adev,
-				    unsigned long xfer_mask)
-{
-	if (adev->class == ATA_DEV_ATAPI) {
-		struct mv_host_priv *hpriv = adev->link->ap->host->private_data;
-		if (!IS_GEN_II(hpriv)) {
-			xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
-			ata_dev_printk(adev, KERN_INFO,
-				"ATAPI DMA not supported on this chipset\n");
-		}
-	}
-	return xfer_mask;
-}
-
-/**
   *	mv_sff_irq_clear - Clear hardware interrupt after DMA.
   *	@ap: Port associated with this ATA transaction.
   *
