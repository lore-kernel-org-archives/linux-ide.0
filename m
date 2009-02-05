From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 01/02] sata_mv: cache frequently read port registers
Date: Thu, 05 Feb 2009 10:36:41 -0500
Message-ID: <498B0789.2080900@rtr.ca>
References: <4989D8F9.2060500@rtr.ca> <498B06DF.8010501@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:41654 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751699AbZBEPgm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 5 Feb 2009 10:36:42 -0500
In-Reply-To: <498B06DF.8010501@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: Grant Grundler <grundler@google.com>

Maintain a local (mv_port_priv) cache of frequently accessed registers,
to avoid having to re-read them (very slow) on every transistion
between EDMA and non-EDMA modes.  This speeds up things like
flushing the drive write cache, and anything using basic DMA transfers.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2009-02-05 10:16:58.000000000 -0500
+++ linux/drivers/ata/sata_mv.c	2009-02-05 10:14:43.000000000 -0500
@@ -438,6 +438,17 @@
 	__le32			reserved;
 };
 
+/*
+ * We keep a local cache of a few frequently accessed port
+ * registers here, to avoid having to read them (very slow)
+ * when switching between EDMA and non-EDMA modes.
+ */
+struct mv_cached_regs {
+	u32			fiscfg;
+	u32			ltmode;
+	u32			haltcond;
+};
+
 struct mv_port_priv {
 	struct mv_crqb		*crqb;
 	dma_addr_t		crqb_dma;
@@ -450,6 +461,7 @@
 	unsigned int		resp_idx;
 
 	u32			pp_flags;
+	struct mv_cached_regs	cached;
 	unsigned int		delayed_eh_pmp_map;
 };
 
@@ -812,6 +824,43 @@
 	return ((port_flags & MV_FLAG_DUAL_HC) ? 2 : 1);
 }
 
+/**
+ *      mv_save_cached_regs - (re-)initialize cached port registers
+ *      @ap: the port whose registers we are caching
+ *
+ *	Initialize the local cache of port registers,
+ *	so that reading them over and over again can
+ *	be avoided on the hotter paths of this driver.
+ *	This saves a few microseconds each time we switch
+ *	to/from EDMA mode to perform (eg.) a drive cache flush.
+ */
+static void mv_save_cached_regs(struct ata_port *ap)
+{
+	void __iomem *port_mmio = mv_ap_base(ap);
+	struct mv_port_priv *pp = ap->private_data;
+
+	pp->cached.fiscfg = readl(port_mmio + FISCFG_OFS);
+	pp->cached.ltmode = readl(port_mmio + LTMODE_OFS);
+	pp->cached.haltcond = readl(port_mmio + EDMA_HALTCOND_OFS);
+}
+
+/**
+ *      mv_write_cached_reg - write to a cached port register
+ *      @addr: hardware address of the register
+ *      @old: pointer to cached value of the register
+ *      @new: new value for the register
+ *
+ *	Write a new value to a cached register,
+ *	but only if the value is different from before.
+ */
+static inline void mv_write_cached_reg(void __iomem *addr, u32 *old, u32 new)
+{
+	if (new != *old) {
+		*old = new;
+		writel(new, addr);
+	}
+}
+
 static void mv_set_edma_ptrs(void __iomem *port_mmio,
 			     struct mv_host_priv *hpriv,
 			     struct mv_port_priv *pp)
@@ -1159,35 +1208,33 @@
 	return ATA_DEFER_PORT;
 }
 
-static void mv_config_fbs(void __iomem *port_mmio, int want_ncq, int want_fbs)
+static void mv_config_fbs(struct ata_port *ap, int want_ncq, int want_fbs)
 {
-	u32 new_fiscfg, old_fiscfg;
-	u32 new_ltmode, old_ltmode;
-	u32 new_haltcond, old_haltcond;
-
-	old_fiscfg   = readl(port_mmio + FISCFG_OFS);
-	old_ltmode   = readl(port_mmio + LTMODE_OFS);
-	old_haltcond = readl(port_mmio + EDMA_HALTCOND_OFS);
-
-	new_fiscfg   = old_fiscfg & ~(FISCFG_SINGLE_SYNC | FISCFG_WAIT_DEV_ERR);
-	new_ltmode   = old_ltmode & ~LTMODE_BIT8;
-	new_haltcond = old_haltcond | EDMA_ERR_DEV;
+	struct mv_port_priv *pp = ap->private_data;
+	void __iomem *port_mmio;
+
+	u32 fiscfg,   *old_fiscfg   = &pp->cached.fiscfg;
+	u32 ltmode,   *old_ltmode   = &pp->cached.ltmode;
+	u32 haltcond, *old_haltcond = &pp->cached.haltcond;
+
+	ltmode   = *old_ltmode & ~LTMODE_BIT8;
+	haltcond = *old_haltcond | EDMA_ERR_DEV;
 
 	if (want_fbs) {
-		new_fiscfg = old_fiscfg | FISCFG_SINGLE_SYNC;
-		new_ltmode = old_ltmode | LTMODE_BIT8;
+		fiscfg = *old_fiscfg | FISCFG_SINGLE_SYNC;
+		ltmode = *old_ltmode | LTMODE_BIT8;
 		if (want_ncq)
-			new_haltcond &= ~EDMA_ERR_DEV;
+			haltcond &= ~EDMA_ERR_DEV;
 		else
-			new_fiscfg |=  FISCFG_WAIT_DEV_ERR;
+			fiscfg |=  FISCFG_WAIT_DEV_ERR;
+	} else {
+		fiscfg = *old_fiscfg & ~(FISCFG_SINGLE_SYNC | FISCFG_WAIT_DEV_ERR);
 	}
 
-	if (new_fiscfg != old_fiscfg)
-		writelfl(new_fiscfg, port_mmio + FISCFG_OFS);
-	if (new_ltmode != old_ltmode)
-		writelfl(new_ltmode, port_mmio + LTMODE_OFS);
-	if (new_haltcond != old_haltcond)
-		writelfl(new_haltcond, port_mmio + EDMA_HALTCOND_OFS);
+	port_mmio = mv_ap_base(ap);
+	mv_write_cached_reg(port_mmio + FISCFG_OFS, old_fiscfg, fiscfg);
+	mv_write_cached_reg(port_mmio + LTMODE_OFS, old_ltmode, ltmode);
+	mv_write_cached_reg(port_mmio + EDMA_HALTCOND_OFS, old_haltcond, haltcond);
 }
 
 static void mv_60x1_errata_sata25(struct ata_port *ap, int want_ncq)
@@ -1235,7 +1282,7 @@
 		 */
 		want_fbs &= want_ncq;
 
-		mv_config_fbs(port_mmio, want_ncq, want_fbs);
+		mv_config_fbs(ap, want_ncq, want_fbs);
 
 		if (want_fbs) {
 			pp->pp_flags |= MV_PP_FLAG_FBS_EN;
@@ -1339,6 +1386,7 @@
 			pp->sg_tbl_dma[tag] = pp->sg_tbl_dma[0];
 		}
 	}
+	mv_save_cached_regs(ap);
 	mv_edma_cfg(ap, 0, 0);
 	return 0;
 
@@ -2996,6 +3044,7 @@
 				extra = HZ; /* only extend it once, max */
 		}
 	} while (sstatus != 0x0 && sstatus != 0x113 && sstatus != 0x123);
+	mv_save_cached_regs(ap);
 	mv_edma_cfg(ap, 0, 0);
 
 	return rc;
