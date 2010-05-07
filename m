From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 2/2] libata: make sff_irq_on() method optional
Date: Fri, 7 May 2010 22:49:02 +0400
Message-ID: <201005072249.02373.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:58709 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752803Ab0EGStu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 May 2010 14:49:50 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Now, with the introduction of the sff_set_devctl() method, we can use it in
sff_irq_on() method too -- that way its implementations in 'pata_bf54x' and
'pata_scc' become virtually identical to ata_sff_irq_on().  The sff_irq_on()
method now becomes quite superfluous, and the only reason not to remove it
completely is the existence of the 'pata_octeon_cf' driver which implements it
as an empty function. Just make the method optional then, with ata_sff_irq_on()
becoming generic taskfile-bound function, still global for the 'pata_bf54x'
driver to be able to call it from its thaw() and postreset() methods.

While at it, make the sff_irq_on() method and ata_sff_irq_on() return 'void' as
the result is always ignored anyway.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent Linus' tree.

 drivers/ata/libata-sff.c     |   26 +++++++++++++++-----------
 drivers/ata/pata_bf54x.c     |   29 ++---------------------------
 drivers/ata/pata_octeon_cf.c |    3 +--
 drivers/ata/pata_scc.c       |   24 ------------------------
 include/linux/libata.h       |    4 ++--
 5 files changed, 20 insertions(+), 66 deletions(-)

Index: linux-2.6/drivers/ata/libata-sff.c
===================================================================
--- linux-2.6.orig/drivers/ata/libata-sff.c
+++ linux-2.6/drivers/ata/libata-sff.c
@@ -63,7 +63,6 @@ const struct ata_port_operations ata_sff
 	.sff_tf_read		= ata_sff_tf_read,
 	.sff_exec_command	= ata_sff_exec_command,
 	.sff_data_xfer		= ata_sff_data_xfer,
-	.sff_irq_on		= ata_sff_irq_on,
 	.sff_irq_clear		= ata_sff_irq_clear,
 
 	.lost_interrupt		= ata_sff_lost_interrupt,
@@ -538,24 +537,29 @@ void ata_dev_select(struct ata_port *ap,
  *	Enable interrupts on a legacy IDE device using MMIO or PIO,
  *	wait for idle, clear any pending interrupts.
  *
+ *	Note: may NOT be used as the sff_irq_on() entry in
+ *	ata_port_operations.
+ *
  *	LOCKING:
  *	Inherited from caller.
  */
-u8 ata_sff_irq_on(struct ata_port *ap)
+void ata_sff_irq_on(struct ata_port *ap)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
-	u8 tmp;
+
+	if (ap->ops->sff_irq_on) {
+		ap->ops->sff_irq_on(ap);
+		return;
+	}
 
 	ap->ctl &= ~ATA_NIEN;
 	ap->last_ctl = ap->ctl;
 
-	if (ioaddr->ctl_addr)
-		iowrite8(ap->ctl, ioaddr->ctl_addr);
-	tmp = ata_wait_idle(ap);
+	if (ap->ops->sff_set_devctl || ioaddr->ctl_addr)
+		ata_sff_set_devctl(ap, ap->ctl);
+	ata_wait_idle(ap);
 
 	ap->ops->sff_irq_clear(ap);
-
-	return tmp;
 }
 EXPORT_SYMBOL_GPL(ata_sff_irq_on);
 
@@ -1186,7 +1190,7 @@ static void ata_hsm_qc_complete(struct a
 			qc = ata_qc_from_tag(ap, qc->tag);
 			if (qc) {
 				if (likely(!(qc->err_mask & AC_ERR_HSM))) {
-					ap->ops->sff_irq_on(ap);
+					ata_sff_irq_on(ap);
 					ata_qc_complete(qc);
 				} else
 					ata_port_freeze(ap);
@@ -1202,7 +1206,7 @@ static void ata_hsm_qc_complete(struct a
 	} else {
 		if (in_wq) {
 			spin_lock_irqsave(ap->lock, flags);
-			ap->ops->sff_irq_on(ap);
+			ata_sff_irq_on(ap);
 			ata_qc_complete(qc);
 			spin_unlock_irqrestore(ap->lock, flags);
 		} else
@@ -1946,7 +1950,7 @@ void ata_sff_thaw(struct ata_port *ap)
 	/* clear & re-enable interrupts */
 	ap->ops->sff_check_status(ap);
 	ap->ops->sff_irq_clear(ap);
-	ap->ops->sff_irq_on(ap);
+	ata_sff_irq_on(ap);
 }
 EXPORT_SYMBOL_GPL(ata_sff_thaw);
 
Index: linux-2.6/drivers/ata/pata_bf54x.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_bf54x.c
+++ linux-2.6/drivers/ata/pata_bf54x.c
@@ -1228,30 +1228,6 @@ static void bfin_irq_clear(struct ata_po
 }
 
 /**
- *	bfin_irq_on - Enable interrupts on a port.
- *	@ap: Port on which interrupts are enabled.
- *
- *	Note: Original code is ata_sff_irq_on().
- */
-
-static unsigned char bfin_irq_on(struct ata_port *ap)
-{
-	void __iomem *base = (void __iomem *)ap->ioaddr.ctl_addr;
-	u8 tmp;
-
-	dev_dbg(ap->dev, "in atapi irq on\n");
-	ap->ctl &= ~ATA_NIEN;
-	ap->last_ctl = ap->ctl;
-
-	write_atapi_register(base, ATA_REG_CTRL, ap->ctl);
-	tmp = ata_wait_idle(ap);
-
-	bfin_irq_clear(ap);
-
-	return tmp;
-}
-
-/**
  *	bfin_thaw - Thaw DMA controller port
  *	@ap: port to thaw
  *
@@ -1262,7 +1238,7 @@ void bfin_thaw(struct ata_port *ap)
 {
 	dev_dbg(ap->dev, "in atapi dma thaw\n");
 	bfin_check_status(ap);
-	bfin_irq_on(ap);
+	ata_sff_irq_on(ap);
 }
 
 /**
@@ -1279,7 +1255,7 @@ static void bfin_postreset(struct ata_li
 	void __iomem *base = (void __iomem *)ap->ioaddr.ctl_addr;
 
 	/* re-enable interrupts */
-	bfin_irq_on(ap);
+	ata_sff_irq_on(ap);
 
 	/* is double-select really necessary? */
 	if (classes[0] != ATA_DEV_NONE)
@@ -1477,7 +1453,6 @@ static struct ata_port_operations bfin_p
 	.postreset		= bfin_postreset,
 
 	.sff_irq_clear		= bfin_irq_clear,
-	.sff_irq_on		= bfin_irq_on,
 
 	.port_start		= bfin_port_start,
 	.port_stop		= bfin_port_stop,
Index: linux-2.6/drivers/ata/pata_octeon_cf.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_octeon_cf.c
+++ linux-2.6/drivers/ata/pata_octeon_cf.c
@@ -489,9 +489,8 @@ static void octeon_cf_exec_command16(str
 	ata_wait_idle(ap);
 }
 
-static u8 octeon_cf_irq_on(struct ata_port *ap)
+static void octeon_cf_irq_on(struct ata_port *ap)
 {
-	return 0;
 }
 
 static void octeon_cf_irq_clear(struct ata_port *ap)
Index: linux-2.6/drivers/ata/pata_scc.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_scc.c
+++ linux-2.6/drivers/ata/pata_scc.c
@@ -828,29 +828,6 @@ static unsigned int scc_data_xfer (struc
 }
 
 /**
- *	scc_irq_on - Enable interrupts on a port.
- *	@ap: Port on which interrupts are enabled.
- *
- *	Note: Original code is ata_sff_irq_on().
- */
-
-static u8 scc_irq_on (struct ata_port *ap)
-{
-	struct ata_ioports *ioaddr = &ap->ioaddr;
-	u8 tmp;
-
-	ap->ctl &= ~ATA_NIEN;
-	ap->last_ctl = ap->ctl;
-
-	out_be32(ioaddr->ctl_addr, ap->ctl);
-	tmp = ata_wait_idle(ap);
-
-	ap->ops->sff_irq_clear(ap);
-
-	return tmp;
-}
-
-/**
  *	scc_pata_prereset - prepare for reset
  *	@ap: ATA port to be reset
  *	@deadline: deadline jiffies for the operation
@@ -977,7 +954,6 @@ static struct ata_port_operations scc_pa
 	.post_internal_cmd	= scc_bmdma_stop,
 
 	.sff_irq_clear		= scc_irq_clear,
-	.sff_irq_on		= scc_irq_on,
 
 	.port_start		= scc_port_start,
 	.port_stop		= scc_port_stop,
Index: linux-2.6/include/linux/libata.h
===================================================================
--- linux-2.6.orig/include/linux/libata.h
+++ linux-2.6/include/linux/libata.h
@@ -858,7 +858,7 @@ struct ata_port_operations {
 				 const struct ata_taskfile *tf);
 	unsigned int (*sff_data_xfer)(struct ata_device *dev,
 			unsigned char *buf, unsigned int buflen, int rw);
-	u8   (*sff_irq_on)(struct ata_port *);
+	void (*sff_irq_on)(struct ata_port *);
 	bool (*sff_irq_check)(struct ata_port *);
 	void (*sff_irq_clear)(struct ata_port *);
 
@@ -1598,7 +1598,7 @@ extern unsigned int ata_sff_data_xfer32(
 			unsigned char *buf, unsigned int buflen, int rw);
 extern unsigned int ata_sff_data_xfer_noirq(struct ata_device *dev,
 			unsigned char *buf, unsigned int buflen, int rw);
-extern u8 ata_sff_irq_on(struct ata_port *ap);
+extern void ata_sff_irq_on(struct ata_port *ap);
 extern void ata_sff_irq_clear(struct ata_port *ap);
 extern int ata_sff_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
 			    u8 status, int in_wq);
