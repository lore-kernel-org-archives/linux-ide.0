From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 4/5] sata_mv new mv_sata_hardreset handler
Date: Mon, 31 Mar 2008 19:35:59 -0400
Message-ID: <47F1755F.9000303@rtr.ca>
References: <47F1736F.8020104@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3048 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750943AbYCaXgA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 31 Mar 2008 19:36:00 -0400
In-Reply-To: <47F1736F.8020104@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>

Introduce mv_sata_hardreset() to perform a link hard reset
while dealing with certain chipset errata during the reset.

Also beef up error-handling in mv_prereset() to trigger a hard reset
whenever mv_stop_edma() fails.

Signed-off-by: Mark Lord <mlord@pobox.com>
---

--- old/drivers/ata/sata_mv.c	2008-03-31 18:14:40.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2008-03-31 18:24:50.000000000 -0400
@@ -2388,7 +2388,97 @@
 
 static int mv_prereset(struct ata_link *link, unsigned long deadline)
 {
-	mv_stop_edma(link->ap);
+	if (mv_stop_edma(link->ap))
+		link->eh_context.i.action |= ATA_EH_HARDRESET;
+	return ata_std_prereset(link, deadline);
+}
+
+/**
+ *	mv_sata_hardreset - reset host port via SATA phy reset
+ *	@link: link to reset
+ *	@class: resulting class of attached device
+ *	@deadline: deadline jiffies for the operation
+ *
+ *	SATA phy-reset host port using DET bits of SControl register,
+ *	wait for !BSY and classify the attached device.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+int mv_sata_hardreset(struct ata_link *link, unsigned int *class,
+			unsigned long deadline)
+{
+	struct ata_port *ap = link->ap;
+	struct mv_host_priv *hpriv = ap->host->private_data;
+	const unsigned long *timing = sata_ehc_deb_timing(&link->eh_context);
+	int rc, attempts = 0, extra = 0;
+	u32 sstatus;
+
+	DPRINTK("ENTER\n");
+
+	/* FIXME:
+	 * Except for the outer do-while construct below, this function
+	 * is an exact clone of sata_std_hardreset() from libata-core.c.
+	 *
+	 * Once this driver is stable, we should re-org libata so we can share
+	 * more of that code, rather than duplicating so much of it here
+	 * and in other drivers.
+	 */
+
+	/* do-while is workaround for errata FEr SATA#10 (part 2) */
+	do {
+		/* do hardreset */
+		rc = sata_link_hardreset(link, timing, deadline + extra);
+		if (rc) {
+			ata_link_printk(link, KERN_ERR,
+					"COMRESET failed (errno=%d)\n", rc);
+			return rc;
+		}
+		sata_scr_read(&ap->link, SCR_STATUS, &sstatus);
+		if (!IS_GEN_I(hpriv) && ++attempts >= 5 && sstatus == 0x121) {
+			/* Force 1.5gb/s link speed and try again */
+			mv_setup_ifctl(mv_ap_base(ap), 0);
+			if (time_after(jiffies + HZ, deadline))
+				extra = HZ; /* only extend it once, max */
+		}
+	} while (sstatus != 0x0 && sstatus != 0x113 && sstatus != 0x123);
+
+	/* TODO: phy layer with polling, timeouts, etc. */
+	if (ata_link_offline(link)) {
+		*class = ATA_DEV_NONE;
+		DPRINTK("EXIT, link offline\n");
+		return 0;
+	}
+
+	/* wait a while before checking status */
+	ata_wait_after_reset(ap, deadline + extra);
+
+	/* If PMP is supported, we have to do follow-up SRST.  Note
+	 * that some PMPs don't send D2H Reg FIS after hardreset at
+	 * all if the first port is empty.  Wait for it just for a
+	 * second and request follow-up SRST.
+	 */
+	if (ap->flags & ATA_FLAG_PMP) {
+		ata_wait_ready(ap, jiffies + HZ);
+		return -EAGAIN;
+	}
+
+	rc = ata_wait_ready(ap, deadline + extra);
+	/* link occupied, -ENODEV too is an error */
+	if (rc) {
+		ata_link_printk(link, KERN_ERR,
+				"COMRESET failed (errno=%d)\n", rc);
+		return rc;
+	}
+
+	ap->ops->dev_select(ap, 0);	/* probably unnecessary */
+
+	*class = ata_dev_try_classify(link->device, 1, NULL);
+
+	DPRINTK("EXIT, class=%u\n", *class);
 	return 0;
 }
 
@@ -2402,9 +2492,8 @@
 
 	mv_reset_channel(hpriv, mmio, ap->port_no);
 	pp->pp_flags &= ~MV_PP_FLAG_EDMA_EN;
-	mv_phy_reset(ap, class, deadline);
 
-	return 0;
+	return mv_sata_hardreset(link, class, deadline);
 }
 
 static void mv_postreset(struct ata_link *link, unsigned int *classes)
