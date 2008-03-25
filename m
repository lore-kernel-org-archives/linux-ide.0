From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 06/27] libata: kill ata_chk_status()
Date: Tue, 25 Mar 2008 22:16:44 +0900
Message-ID: <12064510261000-git-send-email-htejun@gmail.com>
References: <1206451025926-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:60507 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754794AbYCYNRj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Mar 2008 09:17:39 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1755484rvb.1
        for <linux-ide@vger.kernel.org>; Tue, 25 Mar 2008 06:17:39 -0700 (PDT)
In-Reply-To: <1206451025926-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, James.Bottomley@HansenPartnership.com, brking@us.ibm.com, ashish.kalra@freescale.com, leoli@freescale.com
Cc: Tejun Heo <htejun@gmail.com>

ata_chk_status() just calls ops->check_status and it only adds
confusion with other status functions.  Kill it.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-sff.c    |   22 +++++++++++-----------
 drivers/ata/pata_bf54x.c    |    2 +-
 drivers/ata/pata_scc.c      |    2 +-
 drivers/ata/sata_inic162x.c |   10 +++++-----
 drivers/ata/sata_sil.c      |    6 +++---
 drivers/ata/sata_via.c      |    2 +-
 drivers/ata/sata_vsc.c      |    2 +-
 include/linux/libata.h      |    7 +------
 8 files changed, 24 insertions(+), 29 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index add54f5..5208ca2 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -290,7 +290,7 @@ int ata_busy_sleep(struct ata_port *ap,
 	while (status != 0xff && (status & ATA_BUSY) &&
 	       time_before(jiffies, timeout)) {
 		msleep(50);
-		status = ata_chk_status(ap);
+		status = ap->ops->check_status(ap);
 	}
 
 	if (status == 0xff)
@@ -326,7 +326,7 @@ int ata_wait_ready(struct ata_port *ap, unsigned long deadline)
 	int warned = 0;
 
 	while (1) {
-		u8 status = ata_chk_status(ap);
+		u8 status = ap->ops->check_status(ap);
 		unsigned long now = jiffies;
 
 		if (!(status & ATA_BUSY))
@@ -1486,7 +1486,7 @@ inline unsigned int ata_host_intr(struct ata_port *ap,
 		goto idle_irq;
 
 	/* check main status, clearing INTRQ */
-	status = ata_chk_status(ap);
+	status = ap->ops->check_status(ap);
 	if (unlikely(status & ATA_BUSY))
 		goto idle_irq;
 
@@ -1506,7 +1506,7 @@ idle_irq:
 
 #ifdef ATA_IRQ_TRAP
 	if ((ap->stats.idle_irq % 1000) == 0) {
-		ata_chk_status(ap);
+		ap->ops->check_status(ap);
 		ap->ops->irq_clear(ap);
 		ata_port_printk(ap, KERN_WARNING, "irq trap\n");
 		return 1;
@@ -1582,7 +1582,7 @@ void ata_bmdma_freeze(struct ata_port *ap)
 	 * ATA_NIEN manipulation.  Also, many controllers fail to mask
 	 * previously pending IRQ on ATA_NIEN assertion.  Clear it.
 	 */
-	ata_chk_status(ap);
+	ap->ops->check_status(ap);
 
 	ap->ops->irq_clear(ap);
 }
@@ -1599,7 +1599,7 @@ void ata_bmdma_freeze(struct ata_port *ap)
 void ata_bmdma_thaw(struct ata_port *ap)
 {
 	/* clear & re-enable interrupts */
-	ata_chk_status(ap);
+	ap->ops->check_status(ap);
 	ap->ops->irq_clear(ap);
 	ap->ops->irq_on(ap);
 }
@@ -1709,7 +1709,7 @@ unsigned int ata_dev_try_classify(struct ata_device *dev, int present,
 			class = ATA_DEV_ATA;
 		else
 			class = ATA_DEV_NONE;
-	} else if ((class == ATA_DEV_ATA) && (ata_chk_status(ap) == 0))
+	} else if ((class == ATA_DEV_ATA) && (ap->ops->check_status(ap) == 0))
 		class = ATA_DEV_NONE;
 
 	return class;
@@ -1820,7 +1820,7 @@ void ata_wait_after_reset(struct ata_port *ap, unsigned long deadline)
 	 */
 	if (ap->flags & ATA_FLAG_SATA) {
 		while (1) {
-			u8 status = ata_chk_status(ap);
+			u8 status = ap->ops->check_status(ap);
 
 			if (status != 0xff || time_after(jiffies, deadline))
 				return;
@@ -1851,7 +1851,7 @@ static int ata_bus_softreset(struct ata_port *ap, unsigned int devmask,
 	 * the bus shows 0xFF because the odd clown forgets the D7
 	 * pulldown resistor.
 	 */
-	if (ata_chk_status(ap) == 0xFF)
+	if (ap->ops->check_status(ap) == 0xFF)
 		return -ENODEV;
 
 	return ata_bus_post_reset(ap, devmask, deadline);
@@ -2035,7 +2035,7 @@ void ata_bmdma_error_handler(struct ata_port *ap)
 	}
 
 	ata_altstatus(ap);
-	ata_chk_status(ap);
+	ap->ops->check_status(ap);
 	ap->ops->irq_clear(ap);
 
 	spin_unlock_irqrestore(ap->lock, flags);
@@ -2726,7 +2726,6 @@ EXPORT_SYMBOL_GPL(ata_sff_port_ops);
 EXPORT_SYMBOL_GPL(ata_bmdma_port_ops);
 EXPORT_SYMBOL_GPL(ata_qc_prep);
 EXPORT_SYMBOL_GPL(ata_dumb_qc_prep);
-EXPORT_SYMBOL_GPL(ata_pci_default_filter);
 EXPORT_SYMBOL_GPL(ata_std_dev_select);
 EXPORT_SYMBOL_GPL(ata_check_status);
 EXPORT_SYMBOL_GPL(ata_altstatus);
@@ -2755,6 +2754,7 @@ EXPORT_SYMBOL_GPL(ata_bmdma_error_handler);
 EXPORT_SYMBOL_GPL(ata_bmdma_post_internal_cmd);
 EXPORT_SYMBOL_GPL(ata_sff_port_start);
 EXPORT_SYMBOL_GPL(ata_std_ports);
+EXPORT_SYMBOL_GPL(ata_pci_default_filter);
 EXPORT_SYMBOL_GPL(ata_bmdma_setup);
 EXPORT_SYMBOL_GPL(ata_bmdma_start);
 EXPORT_SYMBOL_GPL(ata_bmdma_stop);
diff --git a/drivers/ata/pata_bf54x.c b/drivers/ata/pata_bf54x.c
index eea275a..457ac80 100644
--- a/drivers/ata/pata_bf54x.c
+++ b/drivers/ata/pata_bf54x.c
@@ -1264,7 +1264,7 @@ static void bfin_bmdma_freeze(struct ata_port *ap)
 	 * ATA_NIEN manipulation.  Also, many controllers fail to mask
 	 * previously pending IRQ on ATA_NIEN assertion.  Clear it.
 	 */
-	ata_chk_status(ap);
+	ap->ops->check_status(ap);
 
 	bfin_irq_clear(ap);
 }
diff --git a/drivers/ata/pata_scc.c b/drivers/ata/pata_scc.c
index 07f2d7a..85d3363 100644
--- a/drivers/ata/pata_scc.c
+++ b/drivers/ata/pata_scc.c
@@ -854,7 +854,7 @@ static void scc_bmdma_freeze (struct ata_port *ap)
 	 * ATA_NIEN manipulation.  Also, many controllers fail to mask
 	 * previously pending IRQ on ATA_NIEN assertion.  Clear it.
 	 */
-	ata_chk_status(ap);
+	ap->ops->check_status(ap);
 
 	ap->ops->irq_clear(ap);
 }
diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index ba1c099..12fbf38 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -267,14 +267,14 @@ static void inic_host_intr(struct ata_port *ap)
 			ata_qc_from_tag(ap, ap->link.active_tag);
 
 		if (unlikely(!qc || (qc->tf.flags & ATA_TFLAG_POLLING))) {
-			ata_chk_status(ap);	/* clear ATA interrupt */
+			ap->ops->check_status(ap); /* clear ATA interrupt */
 			return;
 		}
 
 		if (likely(ata_host_intr(ap, qc)))
 			return;
 
-		ata_chk_status(ap);	/* clear ATA interrupt */
+		ap->ops->check_status(ap); /* clear ATA interrupt */
 		ata_port_printk(ap, KERN_WARNING, "unhandled "
 				"interrupt, irq_stat=%x\n", irq_stat);
 		return;
@@ -351,7 +351,7 @@ static unsigned int inic_qc_issue(struct ata_queued_cmd *qc)
 	 */
 	if (unlikely(qc->tf.command == ATA_CMD_ID_ATA ||
 		     qc->tf.command == ATA_CMD_ID_ATAPI)) {
-		u8 stat = ata_chk_status(ap);
+		u8 stat = ap->ops->check_status(ap);
 		if (stat == 0x7f || stat == 0xff)
 			return AC_ERR_HSM;
 	}
@@ -365,7 +365,7 @@ static void inic_freeze(struct ata_port *ap)
 
 	__inic_set_pirq_mask(ap, PIRQ_MASK_FREEZE);
 
-	ata_chk_status(ap);
+	ap->ops->check_status(ap);
 	writeb(0xff, port_base + PORT_IRQ_STAT);
 
 	readb(port_base + PORT_IRQ_STAT); /* flush */
@@ -375,7 +375,7 @@ static void inic_thaw(struct ata_port *ap)
 {
 	void __iomem *port_base = inic_port_base(ap);
 
-	ata_chk_status(ap);
+	ap->ops->check_status(ap);
 	writeb(0xff, port_base + PORT_IRQ_STAT);
 
 	__inic_set_pirq_mask(ap, PIRQ_MASK_OTHER);
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index eac7ca7..659dfcb 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -369,7 +369,7 @@ static void sil_host_intr(struct ata_port *ap, u32 bmdma2)
 
 	if (unlikely(!qc || (qc->tf.flags & ATA_TFLAG_POLLING))) {
 		/* this sometimes happens, just clear IRQ */
-		ata_chk_status(ap);
+		ap->ops->check_status(ap);
 		return;
 	}
 
@@ -405,7 +405,7 @@ static void sil_host_intr(struct ata_port *ap, u32 bmdma2)
 	}
 
 	/* check main status, clearing INTRQ */
-	status = ata_chk_status(ap);
+	status = ap->ops->check_status(ap);
 	if (unlikely(status & ATA_BUSY))
 		goto err_hsm;
 
@@ -480,7 +480,7 @@ static void sil_thaw(struct ata_port *ap)
 	u32 tmp;
 
 	/* clear IRQ */
-	ata_chk_status(ap);
+	ap->ops->check_status(ap);
 	ata_bmdma_irq_clear(ap);
 
 	/* turn on SATA IRQ if supported */
diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index 402fd73..4bc6e84 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -173,7 +173,7 @@ static void svia_noop_freeze(struct ata_port *ap)
 	/* Some VIA controllers choke if ATA_NIEN is manipulated in
 	 * certain way.  Leave it alone and just clear pending IRQ.
 	 */
-	ata_chk_status(ap);
+	ap->ops->check_status(ap);
 	ata_bmdma_irq_clear(ap);
 }
 
diff --git a/drivers/ata/sata_vsc.c b/drivers/ata/sata_vsc.c
index 8045a72..fb3a887 100644
--- a/drivers/ata/sata_vsc.c
+++ b/drivers/ata/sata_vsc.c
@@ -251,7 +251,7 @@ static void vsc_port_intr(u8 port_status, struct ata_port *ap)
 	 * simply clear the interrupt
 	 */
 	if (unlikely(!handled))
-		ata_chk_status(ap);
+		ap->ops->check_status(ap);
 }
 
 /*
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 3884285..af7195c 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1420,11 +1420,6 @@ extern int ata_pci_init_one(struct pci_dev *pdev,
 			    struct scsi_host_template *sht, void *host_priv);
 #endif /* CONFIG_PCI */
 
-static inline u8 ata_chk_status(struct ata_port *ap)
-{
-	return ap->ops->check_status(ap);
-}
-
 /**
  *	ata_pause - Flush writes and pause 400 nanoseconds.
  *	@ap: Port to wait for.
@@ -1458,7 +1453,7 @@ static inline u8 ata_busy_wait(struct ata_port *ap, unsigned int bits,
 
 	do {
 		udelay(10);
-		status = ata_chk_status(ap);
+		status = ap->ops->check_status(ap);
 		max--;
 	} while (status != 0xff && (status & bits) && (max > 0));
 
-- 
1.5.2.4

