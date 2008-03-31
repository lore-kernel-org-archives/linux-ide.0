From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 5/5] sata_mv remove mv_phy_reset and mv_postreset
Date: Mon, 31 Mar 2008 19:36:50 -0400
Message-ID: <47F17592.8070002@rtr.ca>
References: <47F1736F.8020104@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4892 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751520AbYCaXgw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 31 Mar 2008 19:36:52 -0400
In-Reply-To: <47F1736F.8020104@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>

Remove the now unused mv_phy_reset() code,
as well as the unnecessary mv_postreset() function.

Signed-off-by: Mark Lord <mlord@pobox.com>
---

--- old/drivers/ata/sata_mv.c	2008-03-31 18:46:44.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2008-03-31 18:46:49.000000000 -0400
@@ -481,7 +481,6 @@
 static int mv_prereset(struct ata_link *link, unsigned long deadline);
 static int mv_hardreset(struct ata_link *link, unsigned int *class,
 			unsigned long deadline);
-static void mv_postreset(struct ata_link *link, unsigned int *classes);
 static void mv_eh_freeze(struct ata_port *ap);
 static void mv_eh_thaw(struct ata_port *ap);
 static void mv6_dev_config(struct ata_device *dev);
@@ -547,7 +546,6 @@
 	.thaw			= mv_eh_thaw,
 	.prereset		= mv_prereset,
 	.hardreset		= mv_hardreset,
-	.postreset		= mv_postreset,
 	.error_handler		= ata_std_error_handler, /* avoid SFF EH */
 	.post_internal_cmd	= ATA_OP_NULL,
 
@@ -2282,110 +2280,6 @@
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
-		u8 drv_stat = ata_check_status(ap);
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
-	*class = ata_dev_try_classify(ap->link.device, 1, NULL);
-
-	writelfl(0, port_mmio + EDMA_ERR_IRQ_CAUSE_OFS);
-
-	WARN_ON(pp->pp_flags & MV_PP_FLAG_EDMA_EN);
-
-	VPRINTK("EXIT\n");
-}
-
 static int mv_prereset(struct ata_link *link, unsigned long deadline)
 {
 	if (mv_stop_edma(link->ap))
@@ -2496,28 +2390,6 @@
 	return mv_sata_hardreset(link, class, deadline);
 }
 
-static void mv_postreset(struct ata_link *link, unsigned int *classes)
-{
-	struct ata_port *ap = link->ap;
-	u32 serr;
-
-	/* print link status */
-	sata_print_link_status(link);
-
-	/* clear SError */
-	sata_scr_read(link, SCR_ERROR, &serr);
-	sata_scr_write_flush(link, SCR_ERROR, serr);
-
-	/* bail out if no device is present */
-	if (classes[0] == ATA_DEV_NONE && classes[1] == ATA_DEV_NONE) {
-		DPRINTK("EXIT, no device\n");
-		return;
-	}
-
-	/* set up device control */
-	iowrite8(ap->ctl, ap->ioaddr.ctl_addr);
-}
-
 static void mv_eh_freeze(struct ata_port *ap)
 {
 	struct mv_host_priv *hpriv = ap->host->private_data;
