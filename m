From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 01/07] sata_mv hardreset rework
Date: Wed, 16 Apr 2008 14:56:12 -0400
Message-ID: <48064BCC.5070505@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2713 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751308AbYDPS4P (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Apr 2008 14:56:15 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Rework and simplify sata_mv's hardreset code to take advantage
of libata improvements since it was first coded.

Also, get rid of the now unnecessary prereset, postreset, and phy_reset functions.

This patch also paves the way for subsequent pmp support patches,
which will follow once this one passes muster.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2008-04-10 14:30:27.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2008-04-10 14:31:01.000000000 -0400
@@ -478,10 +478,8 @@
 static void mv_qc_prep(struct ata_queued_cmd *qc);
 static void mv_qc_prep_iie(struct ata_queued_cmd *qc);
 static unsigned int mv_qc_issue(struct ata_queued_cmd *qc);
-static int mv_prereset(struct ata_link *link, unsigned long deadline);
 static int mv_hardreset(struct ata_link *link, unsigned int *class,
 			unsigned long deadline);
-static void mv_postreset(struct ata_link *link, unsigned int *classes);
 static void mv_eh_freeze(struct ata_port *ap);
 static void mv_eh_thaw(struct ata_port *ap);
 static void mv6_dev_config(struct ata_device *dev);
@@ -545,9 +543,7 @@
 
 	.freeze			= mv_eh_freeze,
 	.thaw			= mv_eh_thaw,
-	.prereset		= mv_prereset,
 	.hardreset		= mv_hardreset,
-	.postreset		= mv_postreset,
 	.error_handler		= ata_std_error_handler, /* avoid SFF EH */
 	.post_internal_cmd	= ATA_OP_NULL,
 
@@ -1904,7 +1900,6 @@
 	 * (but doesn't say what the problem might be).  So we first try
 	 * to disable the EDMA engine before doing the ATA_RST operation.
 	 */
-	mv_stop_edma_engine(port_mmio);
 	mv_reset_channel(hpriv, mmio, port);
 
 	ZERO(0x028);	/* command */
@@ -2184,7 +2179,6 @@
 	 * (but doesn't say what the problem might be).  So we first try
 	 * to disable the EDMA engine before doing the ATA_RST operation.
 	 */
-	mv_stop_edma_engine(port_mmio);
 	mv_reset_channel(hpriv, mmio, port);
 
 	ZERO(0x028);		/* command */
@@ -2261,6 +2255,7 @@
 {
 	void __iomem *port_mmio = mv_port_base(mmio, port_no);
 
+	mv_stop_edma_engine(port_mmio);
 	writelfl(ATA_RST, port_mmio + EDMA_CMD_OFS);
 
 	if (!IS_GEN_I(hpriv)) {
@@ -2282,116 +2277,6 @@
 		mdelay(1);
 }
 
-/**
- *      mv_phy_reset - Perform eDMA reset followed by COMRESET
- *      @ap: ATA channel to manipulate
- *
- *      Part of this is taken from __sata_phy_reset and modified to
- *      not sleep since this routine gets called from interrupt level.
- *
- *      LOCKING:
- *      Inherited from caller.  This is coded to safe to call at
- *      interrupt level, i.e. it does not sleep.
- */
-static void mv_phy_reset(struct ata_port *ap, unsigned int *class,
-			 unsigned long deadline)
-{
-	struct mv_port_priv *pp	= ap->private_data;
-	struct mv_host_priv *hpriv = ap->host->private_data;
-	void __iomem *port_mmio = mv_ap_base(ap);
-	int retry = 5;
-	u32 sstatus;
-
-	VPRINTK("ENTER, port %u, mmio 0x%p\n", ap->port_no, port_mmio);
-
-#ifdef DEBUG
-	{
-		u32 sstatus, serror, scontrol;
-
-		mv_scr_read(ap, SCR_STATUS, &sstatus);
-		mv_scr_read(ap, SCR_ERROR, &serror);
-		mv_scr_read(ap, SCR_CONTROL, &scontrol);
-		DPRINTK("S-regs after ATA_RST: SStat 0x%08x SErr 0x%08x "
-			"SCtrl 0x%08x\n", sstatus, serror, scontrol);
-	}
-#endif
-
-	/* Issue COMRESET via SControl */
-comreset_retry:
-	sata_scr_write_flush(&ap->link, SCR_CONTROL, 0x301);
-	msleep(1);
-
-	sata_scr_write_flush(&ap->link, SCR_CONTROL, 0x300);
-	msleep(20);
-
-	do {
-		sata_scr_read(&ap->link, SCR_STATUS, &sstatus);
-		if (((sstatus & 0x3) == 3) || ((sstatus & 0x3) == 0))
-			break;
-
-		msleep(1);
-	} while (time_before(jiffies, deadline));
-
-	/* work around errata */
-	if (IS_GEN_II(hpriv) &&
-	    (sstatus != 0x0) && (sstatus != 0x113) && (sstatus != 0x123) &&
-	    (retry-- > 0))
-		goto comreset_retry;
-
-#ifdef DEBUG
-	{
-		u32 sstatus, serror, scontrol;
-
-		mv_scr_read(ap, SCR_STATUS, &sstatus);
-		mv_scr_read(ap, SCR_ERROR, &serror);
-		mv_scr_read(ap, SCR_CONTROL, &scontrol);
-		DPRINTK("S-regs after PHY wake: SStat 0x%08x SErr 0x%08x "
-			"SCtrl 0x%08x\n", sstatus, serror, scontrol);
-	}
-#endif
-
-	if (ata_link_offline(&ap->link)) {
-		*class = ATA_DEV_NONE;
-		return;
-	}
-
-	/* even after SStatus reflects that device is ready,
-	 * it seems to take a while for link to be fully
-	 * established (and thus Status no longer 0x80/0x7F),
-	 * so we poll a bit for that, here.
-	 */
-	retry = 20;
-	while (1) {
-		u8 drv_stat = ata_sff_check_status(ap);
-		if ((drv_stat != 0x80) && (drv_stat != 0x7f))
-			break;
-		msleep(500);
-		if (retry-- <= 0)
-			break;
-		if (time_after(jiffies, deadline))
-			break;
-	}
-
-	/* FIXME: if we passed the deadline, the following
-	 * code probably produces an invalid result
-	 */
-
-	/* finally, read device signature from TF registers */
-	*class = ata_sff_dev_classify(ap->link.device, 1, NULL);
-
-	writelfl(0, port_mmio + EDMA_ERR_IRQ_CAUSE_OFS);
-
-	WARN_ON(pp->pp_flags & MV_PP_FLAG_EDMA_EN);
-
-	VPRINTK("EXIT\n");
-}
-
-static int mv_prereset(struct ata_link *link, unsigned long deadline)
-{
-	mv_stop_edma(link->ap);
-	return 0;
-}
-
 static int mv_hardreset(struct ata_link *link, unsigned int *class,
 			unsigned long deadline)
 {
@@ -2399,34 +2284,33 @@
 	struct mv_host_priv *hpriv = ap->host->private_data;
 	struct mv_port_priv *pp = ap->private_data;
 	void __iomem *mmio = hpriv->base;
+	int rc, attempts = 0, extra = 0;
+	u32 sstatus;
+	bool online;
 
 	mv_reset_channel(hpriv, mmio, ap->port_no);
 	pp->pp_flags &= ~MV_PP_FLAG_EDMA_EN;
-	mv_phy_reset(ap, class, deadline);
-
-	return 0;
-}
-
-static void mv_postreset(struct ata_link *link, unsigned int *classes)
-{
-	struct ata_port *ap = link->ap;
-	u32 serr;
 
-	/* print link status */
-	sata_print_link_status(link);
+	/* Workaround for errata FEr SATA#10 (part 2) */
+	do {
+		const unsigned long *timing = sata_ehc_deb_timing(&link->eh_context);
 
-	/* clear SError */
-	sata_scr_read(link, SCR_ERROR, &serr);
-	sata_scr_write_flush(link, SCR_ERROR, serr);
-
-	/* bail out if no device is present */
-	if (classes[0] == ATA_DEV_NONE && classes[1] == ATA_DEV_NONE) {
-		DPRINTK("EXIT, no device\n");
-		return;
-	}
+		rc = sata_link_hardreset(link, timing, deadline + extra, &online, NULL);
+		if (rc) {
+			ata_link_printk(link, KERN_ERR,
+					"COMRESET failed (errno=%d)\n", rc);
+			return rc;
+		}
+		sata_scr_read(link, SCR_STATUS, &sstatus);
+		if (!IS_GEN_I(hpriv) && ++attempts >= 5 && sstatus == 0x121) {
+			/* Force 1.5gb/s link speed and try again */
+			mv_setup_ifctl(mv_ap_base(ap), 0);
+			if (time_after(jiffies + HZ, deadline))
+				extra = HZ; /* only extend it once, max */
+		}
+	} while (sstatus != 0x0 && sstatus != 0x113 && sstatus != 0x123);
 
-	/* set up device control */
-	iowrite8(ap->ctl, ap->ioaddr.ctl_addr);
+	return online ? -EAGAIN : rc;
 }
 
 static void mv_eh_freeze(struct ata_port *ap)
