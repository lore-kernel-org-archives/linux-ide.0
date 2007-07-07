From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 5/7] libata: integrate freeze/thaw with irq_on/off
Date: Sat, 07 Jul 2007 15:12:34 +0800
Message-ID: <468F3CE2.9080709@tw.ibm.com>
References: <468F3949.5050800@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:52542 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363AbXGGHMw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 7 Jul 2007 03:12:52 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l677Cpnv011294
	for <linux-ide@vger.kernel.org>; Sat, 7 Jul 2007 03:12:51 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l677CpDF251666
	for <linux-ide@vger.kernel.org>; Sat, 7 Jul 2007 01:12:51 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l677Co0w026390
	for <linux-ide@vger.kernel.org>; Sat, 7 Jul 2007 01:12:51 -0600
In-Reply-To: <468F3949.5050800@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Doug Maxey <dwm@enoyolf.org>, Mark Lord <mlord@pobox.com>, Tejun Heo <htejun@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>

irq_on/irq_off are now only wrapped by freeze/thaw and unused elsewhere.
We can integrate freeze/thaw with irq_on/irq_off.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---

The strange thing here is sata_via. It implements
svia_noop_freeze() that doesn't actually disable the irq.
This is related to the following bug:
http://bugzilla.kernel.org/show_bug.cgi?id=7415

Sine a lot has been changed since 2.6.19, maybe we
can remove such quirk at this momemt and ask the bug submitter
to test his VIA 8420 with the new code again.

diff -Nrup 04_use_freeze_polling/drivers/ata/libata-core.c 05_rename_thaw_freeze/drivers/ata/libata-core.c
--- 04_use_freeze_polling/drivers/ata/libata-core.c	2007-07-07 10:40:10.000000000 +0800
+++ 05_rename_thaw_freeze/drivers/ata/libata-core.c	2007-07-07 10:49:04.000000000 +0800
@@ -4753,7 +4753,7 @@ static void ata_hsm_qc_complete(struct a
 			qc = ata_qc_from_tag(ap, qc->tag);
 			if (qc) {
 				if (likely(!(qc->err_mask & AC_ERR_HSM))) {
-					ap->ops->thaw(ap);
+					ap->ops->irq_on(ap);
 					ata_qc_complete(qc);
 				} else
 					ata_port_freeze(ap);
@@ -4769,7 +4769,7 @@ static void ata_hsm_qc_complete(struct a
 	} else {
 		if (in_wq) {
 			spin_lock_irqsave(ap->lock, flags);
-			ap->ops->thaw(ap);
+			ap->ops->irq_on(ap);
 			ata_qc_complete(qc);
 			spin_unlock_irqrestore(ap->lock, flags);
 		} else
@@ -5411,7 +5411,7 @@ unsigned int ata_qc_issue_prot(struct at
 	switch (qc->tf.protocol) {
 	case ATA_PROT_NODATA:
 		if (qc->tf.flags & ATA_TFLAG_POLLING)
-			ap->ops->freeze(ap);
+			ap->ops->irq_off(ap);
 
 		ata_tf_to_host(ap, &qc->tf);
 		ap->hsm_task_state = HSM_ST_LAST;
@@ -5432,7 +5432,7 @@ unsigned int ata_qc_issue_prot(struct at
 
 	case ATA_PROT_PIO:
 		if (qc->tf.flags & ATA_TFLAG_POLLING)
-			ap->ops->freeze(ap);
+			ap->ops->irq_off(ap);
 
 		ata_tf_to_host(ap, &qc->tf);
 
@@ -5461,7 +5461,7 @@ unsigned int ata_qc_issue_prot(struct at
 	case ATA_PROT_ATAPI:
 	case ATA_PROT_ATAPI_NODATA:
 		if (qc->tf.flags & ATA_TFLAG_POLLING)
-			ap->ops->freeze(ap);
+			ap->ops->irq_off(ap);
 
 		ata_tf_to_host(ap, &qc->tf);
 
@@ -6758,8 +6758,6 @@ const struct ata_port_operations ata_dum
 	.dev_select		= ata_noop_dev_select,
 	.qc_prep		= ata_noop_qc_prep,
 	.qc_issue		= ata_dummy_qc_issue,
-	.freeze			= ata_dummy_noret,
-	.thaw			= ata_dummy_noret,
 	.error_handler		= ata_dummy_noret,
 	.post_internal_cmd	= ata_dummy_qc_noret,
 	.irq_clear		= ata_dummy_noret,
@@ -6821,8 +6819,6 @@ EXPORT_SYMBOL_GPL(ata_bmdma_start);
 EXPORT_SYMBOL_GPL(ata_bmdma_irq_clear);
 EXPORT_SYMBOL_GPL(ata_bmdma_status);
 EXPORT_SYMBOL_GPL(ata_bmdma_stop);
-EXPORT_SYMBOL_GPL(ata_bmdma_freeze);
-EXPORT_SYMBOL_GPL(ata_bmdma_thaw);
 EXPORT_SYMBOL_GPL(ata_bmdma_drive_eh);
 EXPORT_SYMBOL_GPL(ata_bmdma_error_handler);
 EXPORT_SYMBOL_GPL(ata_bmdma_post_internal_cmd);
@@ -6900,7 +6896,7 @@ EXPORT_SYMBOL_GPL(ata_eh_qc_complete);
 EXPORT_SYMBOL_GPL(ata_eh_qc_retry);
 EXPORT_SYMBOL_GPL(ata_do_eh);
 EXPORT_SYMBOL_GPL(ata_irq_on);
-EXPORT_SYMBOL_GPL(ata_dummy_irq_on);
+EXPORT_SYMBOL_GPL(ata_irq_off);
 EXPORT_SYMBOL_GPL(ata_irq_ack);
 EXPORT_SYMBOL_GPL(ata_dummy_irq_ack);
 EXPORT_SYMBOL_GPL(ata_dev_try_classify);
diff -Nrup 04_use_freeze_polling/drivers/ata/libata-eh.c 05_rename_thaw_freeze/drivers/ata/libata-eh.c
--- 04_use_freeze_polling/drivers/ata/libata-eh.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_freeze/drivers/ata/libata-eh.c	2007-07-07 10:49:04.000000000 +0800
@@ -617,8 +617,7 @@ static void __ata_port_freeze(struct ata
 {
 	WARN_ON(!ap->ops->error_handler);
 
-	if (ap->ops->freeze)
-		ap->ops->freeze(ap);
+	ap->ops->irq_off(ap);
 
 	ap->pflags |= ATA_PFLAG_FROZEN;
 
@@ -690,8 +689,7 @@ void ata_eh_thaw_port(struct ata_port *a
 
 	ap->pflags &= ~ATA_PFLAG_FROZEN;
 
-	if (ap->ops->thaw)
-		ap->ops->thaw(ap);
+	ap->ops->irq_on(ap);
 
 	spin_unlock_irqrestore(ap->lock, flags);
 
diff -Nrup 04_use_freeze_polling/drivers/ata/libata.h 05_rename_thaw_freeze/drivers/ata/libata.h
--- 04_use_freeze_polling/drivers/ata/libata.h	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_freeze/drivers/ata/libata.h	2007-07-07 10:49:04.000000000 +0800
@@ -155,8 +155,5 @@ extern void ata_scsi_error(struct Scsi_H
 extern void ata_port_wait_eh(struct ata_port *ap);
 extern void ata_qc_schedule_eh(struct ata_queued_cmd *qc);
 
-/* libata-sff.c */
-extern u8 ata_irq_on(struct ata_port *ap);
-
 
 #endif /* __LIBATA_H__ */
diff -Nrup 04_use_freeze_polling/drivers/ata/libata-sff.c 05_rename_thaw_freeze/drivers/ata/libata-sff.c
--- 04_use_freeze_polling/drivers/ata/libata-sff.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_freeze/drivers/ata/libata-sff.c	2007-07-07 10:49:04.000000000 +0800
@@ -48,23 +48,46 @@
  *	LOCKING:
  *	Inherited from caller.
  */
-u8 ata_irq_on(struct ata_port *ap)
+void ata_irq_on(struct ata_port *ap)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
-	u8 tmp;
 
 	ap->ctl &= ~ATA_NIEN;
 	ap->last_ctl = ap->ctl;
 
 	iowrite8(ap->ctl, ioaddr->ctl_addr);
-	tmp = ata_wait_idle(ap);
+	ata_wait_idle(ap);
 
 	ap->ops->irq_clear(ap);
-
-	return tmp;
 }
 
-u8 ata_dummy_irq_on (struct ata_port *ap) 	{ return 0; }
+/**
+ *	ata_irq_off - Disable interrupts on a port.
+ *	@ap: Port on which interrupts are disabled.
+ *
+ *	Disable interrupts on a legacy IDE device using MMIO or PIO,
+ *	wait for idle, clear any pending interrupts.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
+void ata_irq_off(struct ata_port *ap)
+{
+	struct ata_ioports *ioaddr = &ap->ioaddr;
+
+	ap->ctl |= ATA_NIEN;
+	ap->last_ctl = ap->ctl;
+
+	iowrite8(ap->ctl, ioaddr->ctl_addr);
+
+	/* Under certain circumstances, some controllers raise IRQ on
+	 * ATA_NIEN manipulation.  Also, many controllers fail to mask
+	 * previously pending IRQ on ATA_NIEN assertion.  Clear it.
+	 */
+	ata_wait_idle(ap);
+
+	ap->ops->irq_clear(ap);
+}
 
 /**
  *	ata_irq_ack - Acknowledge a device interrupt.
@@ -370,50 +393,6 @@ void ata_bmdma_stop(struct ata_queued_cm
 }
 
 /**
- *	ata_bmdma_freeze - Freeze BMDMA controller port
- *	@ap: port to freeze
- *
- *	Freeze BMDMA controller port.
- *
- *	LOCKING:
- *	Inherited from caller.
- */
-void ata_bmdma_freeze(struct ata_port *ap)
-{
-	struct ata_ioports *ioaddr = &ap->ioaddr;
-
-	ap->ctl |= ATA_NIEN;
-	ap->last_ctl = ap->ctl;
-
-	iowrite8(ap->ctl, ioaddr->ctl_addr);
-
-	/* Under certain circumstances, some controllers raise IRQ on
-	 * ATA_NIEN manipulation.  Also, many controllers fail to mask
-	 * previously pending IRQ on ATA_NIEN assertion.  Clear it.
-	 */
-	ata_chk_status(ap);
-
-	ap->ops->irq_clear(ap);
-}
-
-/**
- *	ata_bmdma_thaw - Thaw BMDMA controller port
- *	@ap: port to thaw
- *
- *	Thaw BMDMA controller port.
- *
- *	LOCKING:
- *	Inherited from caller.
- */
-void ata_bmdma_thaw(struct ata_port *ap)
-{
-	/* clear & re-enable interrupts */
-	ata_chk_status(ap);
-	ap->ops->irq_clear(ap);
-	ap->ops->irq_on(ap);
-}
-
-/**
  *	ata_bmdma_drive_eh - Perform EH with given methods for BMDMA controller
  *	@ap: port to handle error for
  *	@prereset: prereset method (can be NULL)
diff -Nrup 04_use_freeze_polling/include/linux/libata.h 05_rename_thaw_freeze/include/linux/libata.h
--- 04_use_freeze_polling/include/linux/libata.h	2007-07-07 10:40:10.000000000 +0800
+++ 05_rename_thaw_freeze/include/linux/libata.h	2007-07-07 10:49:04.000000000 +0800
@@ -589,14 +589,13 @@ struct ata_port_operations {
 	 */
 	void (*eng_timeout) (struct ata_port *ap); /* obsolete */
 
-	void (*freeze) (struct ata_port *ap);
-	void (*thaw) (struct ata_port *ap);
 	void (*error_handler) (struct ata_port *ap);
 	void (*post_internal_cmd) (struct ata_queued_cmd *qc);
 
 	irq_handler_t irq_handler;
 	void (*irq_clear) (struct ata_port *);
-	u8 (*irq_on) (struct ata_port *);
+	void (*irq_on) (struct ata_port *);
+	void (*irq_off) (struct ata_port *);
 	u8 (*irq_ack) (struct ata_port *ap, unsigned int chk_drq);
 
 	u32 (*scr_read) (struct ata_port *ap, unsigned int sc_reg);
@@ -778,8 +777,6 @@ extern void ata_bmdma_start (struct ata_
 extern void ata_bmdma_stop(struct ata_queued_cmd *qc);
 extern u8   ata_bmdma_status(struct ata_port *ap);
 extern void ata_bmdma_irq_clear(struct ata_port *ap);
-extern void ata_bmdma_freeze(struct ata_port *ap);
-extern void ata_bmdma_thaw(struct ata_port *ap);
 extern void ata_bmdma_drive_eh(struct ata_port *ap, ata_prereset_fn_t prereset,
 			       ata_reset_fn_t softreset,
 			       ata_reset_fn_t hardreset,
@@ -802,8 +799,8 @@ extern int ata_scsi_change_queue_depth(s
 				       int queue_depth);
 extern struct ata_device *ata_dev_pair(struct ata_device *adev);
 extern int ata_do_set_mode(struct ata_port *ap, struct ata_device **r_failed_dev);
-extern u8 ata_irq_on(struct ata_port *ap);
-extern u8 ata_dummy_irq_on(struct ata_port *ap);
+extern void ata_irq_on(struct ata_port *ap);
+extern void ata_irq_off(struct ata_port *ap);
 extern u8 ata_irq_ack(struct ata_port *ap, unsigned int chk_drq);
 extern u8 ata_dummy_irq_ack(struct ata_port *ap, unsigned int chk_drq);
 
diff -Nrup 05_rename_thaw_freeze/drivers/ata/ahci.c 05_rename_thaw_lldd/drivers/ata/ahci.c
--- 05_rename_thaw_freeze/drivers/ata/ahci.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/ahci.c	2007-07-07 10:49:30.000000000 +0800
@@ -223,8 +223,8 @@ static void ahci_port_stop(struct ata_po
 static void ahci_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
 static void ahci_qc_prep(struct ata_queued_cmd *qc);
 static u8 ahci_check_status(struct ata_port *ap);
-static void ahci_freeze(struct ata_port *ap);
-static void ahci_thaw(struct ata_port *ap);
+static void ahci_irq_on(struct ata_port *ap);
+static void ahci_irq_off(struct ata_port *ap);
 static void ahci_error_handler(struct ata_port *ap);
 static void ahci_vt8251_error_handler(struct ata_port *ap);
 static void ahci_post_internal_cmd(struct ata_queued_cmd *qc);
@@ -267,15 +267,13 @@ static const struct ata_port_operations 
 	.qc_issue		= ahci_qc_issue,
 
 	.irq_clear		= ahci_irq_clear,
-	.irq_on			= ata_dummy_irq_on,
+	.irq_on			= ahci_irq_on,
+	.irq_off		= ahci_irq_off,
 	.irq_ack		= ata_dummy_irq_ack,
 
 	.scr_read		= ahci_scr_read,
 	.scr_write		= ahci_scr_write,
 
-	.freeze			= ahci_freeze,
-	.thaw			= ahci_thaw,
-
 	.error_handler		= ahci_error_handler,
 	.post_internal_cmd	= ahci_post_internal_cmd,
 
@@ -301,15 +299,13 @@ static const struct ata_port_operations 
 	.qc_issue		= ahci_qc_issue,
 
 	.irq_clear		= ahci_irq_clear,
-	.irq_on			= ata_dummy_irq_on,
+	.irq_on			= ahci_irq_on,
+	.irq_off		= ahci_irq_off,
 	.irq_ack		= ata_dummy_irq_ack,
 
 	.scr_read		= ahci_scr_read,
 	.scr_write		= ahci_scr_write,
 
-	.freeze			= ahci_freeze,
-	.thaw			= ahci_thaw,
-
 	.error_handler		= ahci_vt8251_error_handler,
 	.post_internal_cmd	= ahci_post_internal_cmd,
 
@@ -1395,7 +1391,7 @@ static unsigned int ahci_qc_issue(struct
 	return 0;
 }
 
-static void ahci_freeze(struct ata_port *ap)
+static void ahci_irq_off(struct ata_port *ap)
 {
 	void __iomem *port_mmio = ahci_port_base(ap);
 
@@ -1403,7 +1399,7 @@ static void ahci_freeze(struct ata_port 
 	writel(0, port_mmio + PORT_IRQ_MASK);
 }
 
-static void ahci_thaw(struct ata_port *ap)
+static void ahci_irq_on(struct ata_port *ap)
 {
 	void __iomem *mmio = ap->host->iomap[AHCI_PCI_BAR];
 	void __iomem *port_mmio = ahci_port_base(ap);
diff -Nrup 05_rename_thaw_freeze/drivers/ata/ata_generic.c 05_rename_thaw_lldd/drivers/ata/ata_generic.c
--- 05_rename_thaw_freeze/drivers/ata/ata_generic.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/ata_generic.c	2007-07-07 10:49:30.000000000 +0800
@@ -109,8 +109,6 @@ static struct ata_port_operations generi
 
 	.data_xfer	= ata_data_xfer,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_unknown,
@@ -121,6 +119,7 @@ static struct ata_port_operations generi
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 05_rename_thaw_freeze/drivers/ata/ata_piix.c 05_rename_thaw_lldd/drivers/ata/ata_piix.c
--- 05_rename_thaw_freeze/drivers/ata/ata_piix.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/ata_piix.c	2007-07-07 10:49:30.000000000 +0800
@@ -296,8 +296,6 @@ static const struct ata_port_operations 
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_data_xfer,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= piix_pata_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= ata_cable_40wire,
@@ -305,6 +303,7 @@ static const struct ata_port_operations 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
@@ -330,8 +329,6 @@ static const struct ata_port_operations 
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_data_xfer,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= piix_pata_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= ich_pata_cable_detect,
@@ -339,6 +336,7 @@ static const struct ata_port_operations 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
@@ -361,14 +359,13 @@ static const struct ata_port_operations 
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_data_xfer,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
diff -Nrup 05_rename_thaw_freeze/drivers/ata/pata_ali.c 05_rename_thaw_lldd/drivers/ata/pata_ali.c
--- 05_rename_thaw_freeze/drivers/ata/pata_ali.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/pata_ali.c	2007-07-07 10:49:30.000000000 +0800
@@ -306,8 +306,6 @@ static struct ata_port_operations ali_ea
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
@@ -320,6 +318,7 @@ static struct ata_port_operations ali_ea
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
@@ -343,8 +342,6 @@ static struct ata_port_operations ali_20
 	.dev_select 	= ata_std_dev_select,
 	.dev_config	= ali_lock_sectors,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
@@ -362,6 +359,7 @@ static struct ata_port_operations ali_20
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
@@ -382,8 +380,6 @@ static struct ata_port_operations ali_c2
 	.dev_select 	= ata_std_dev_select,
 	.dev_config	= ali_lock_sectors,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ali_c2_cable_detect,
@@ -401,6 +397,7 @@ static struct ata_port_operations ali_c2
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
@@ -420,8 +417,6 @@ static struct ata_port_operations ali_c5
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ali_c2_cable_detect,
@@ -439,6 +434,7 @@ static struct ata_port_operations ali_c5
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 05_rename_thaw_freeze/drivers/ata/pata_amd.c 05_rename_thaw_lldd/drivers/ata/pata_amd.c
--- 05_rename_thaw_freeze/drivers/ata/pata_amd.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/pata_amd.c	2007-07-07 10:49:30.000000000 +0800
@@ -337,8 +337,6 @@ static struct ata_port_operations amd33_
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= amd_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
@@ -356,6 +354,7 @@ static struct ata_port_operations amd33_
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
@@ -372,8 +371,6 @@ static struct ata_port_operations amd66_
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= amd_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_unknown,
@@ -391,6 +388,7 @@ static struct ata_port_operations amd66_
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
@@ -407,8 +405,6 @@ static struct ata_port_operations amd100
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= amd_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_unknown,
@@ -426,6 +422,7 @@ static struct ata_port_operations amd100
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
@@ -442,8 +439,6 @@ static struct ata_port_operations amd133
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= amd_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= amd_cable_detect,
@@ -461,6 +456,7 @@ static struct ata_port_operations amd133
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
@@ -477,8 +473,6 @@ static struct ata_port_operations nv100_
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= nv_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= nv_cable_detect,
@@ -496,6 +490,7 @@ static struct ata_port_operations nv100_
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
@@ -512,8 +507,6 @@ static struct ata_port_operations nv133_
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= nv_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= nv_cable_detect,
@@ -531,6 +524,7 @@ static struct ata_port_operations nv133_
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 05_rename_thaw_freeze/drivers/ata/pata_artop.c 05_rename_thaw_lldd/drivers/ata/pata_artop.c
--- 05_rename_thaw_freeze/drivers/ata/pata_artop.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/pata_artop.c	2007-07-07 10:49:30.000000000 +0800
@@ -340,8 +340,6 @@ static const struct ata_port_operations 
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= artop6210_error_handler,
 	.post_internal_cmd 	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= ata_cable_40wire,
@@ -358,6 +356,7 @@ static const struct ata_port_operations 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
@@ -374,8 +373,6 @@ static const struct ata_port_operations 
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= artop6260_error_handler,
 	.post_internal_cmd 	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= artop6260_cable_detect,
@@ -391,6 +388,7 @@ static const struct ata_port_operations 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
diff -Nrup 05_rename_thaw_freeze/drivers/ata/pata_atiixp.c 05_rename_thaw_lldd/drivers/ata/pata_atiixp.c
--- 05_rename_thaw_freeze/drivers/ata/pata_atiixp.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/pata_atiixp.c	2007-07-07 10:49:30.000000000 +0800
@@ -242,8 +242,6 @@ static struct ata_port_operations atiixp
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= atiixp_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= atiixp_cable_detect,
@@ -261,6 +259,7 @@ static struct ata_port_operations atiixp
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 05_rename_thaw_freeze/drivers/ata/pata_cmd640.c 05_rename_thaw_lldd/drivers/ata/pata_cmd640.c
--- 05_rename_thaw_freeze/drivers/ata/pata_cmd640.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/pata_cmd640.c	2007-07-07 10:49:30.000000000 +0800
@@ -193,8 +193,6 @@ static struct ata_port_operations cmd640
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
@@ -213,6 +211,7 @@ static struct ata_port_operations cmd640
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= cmd640_port_start,
diff -Nrup 05_rename_thaw_freeze/drivers/ata/pata_cmd64x.c 05_rename_thaw_lldd/drivers/ata/pata_cmd64x.c
--- 05_rename_thaw_freeze/drivers/ata/pata_cmd64x.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/pata_cmd64x.c	2007-07-07 10:49:30.000000000 +0800
@@ -279,8 +279,6 @@ static struct ata_port_operations cmd64x
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
@@ -298,6 +296,7 @@ static struct ata_port_operations cmd64x
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
@@ -314,8 +313,6 @@ static struct ata_port_operations cmd646
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
@@ -333,6 +330,7 @@ static struct ata_port_operations cmd646
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
@@ -349,8 +347,6 @@ static struct ata_port_operations cmd648
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= cmd648_cable_detect,
@@ -368,6 +364,7 @@ static struct ata_port_operations cmd648
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 05_rename_thaw_freeze/drivers/ata/pata_cs5520.c 05_rename_thaw_lldd/drivers/ata/pata_cs5520.c
--- 05_rename_thaw_freeze/drivers/ata/pata_cs5520.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/pata_cs5520.c	2007-07-07 10:49:30.000000000 +0800
@@ -168,8 +168,6 @@ static struct ata_port_operations cs5520
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= ata_cable_40wire,
@@ -184,6 +182,7 @@ static struct ata_port_operations cs5520
 
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
diff -Nrup 05_rename_thaw_freeze/drivers/ata/pata_cs5530.c 05_rename_thaw_lldd/drivers/ata/pata_cs5530.c
--- 05_rename_thaw_freeze/drivers/ata/pata_cs5530.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/pata_cs5530.c	2007-07-07 10:49:30.000000000 +0800
@@ -195,8 +195,6 @@ static struct ata_port_operations cs5530
 	.bmdma_stop	= ata_bmdma_stop,
 	.bmdma_status 	= ata_bmdma_status,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
@@ -209,6 +207,7 @@ static struct ata_port_operations cs5530
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 05_rename_thaw_freeze/drivers/ata/pata_cs5535.c 05_rename_thaw_lldd/drivers/ata/pata_cs5535.c
--- 05_rename_thaw_freeze/drivers/ata/pata_cs5535.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/pata_cs5535.c	2007-07-07 10:49:30.000000000 +0800
@@ -187,8 +187,6 @@ static struct ata_port_operations cs5535
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= cs5535_cable_detect,
@@ -206,6 +204,7 @@ static struct ata_port_operations cs5535
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 05_rename_thaw_freeze/drivers/ata/pata_cypress.c 05_rename_thaw_lldd/drivers/ata/pata_cypress.c
--- 05_rename_thaw_freeze/drivers/ata/pata_cypress.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/pata_cypress.c	2007-07-07 10:49:30.000000000 +0800
@@ -139,8 +139,6 @@ static struct ata_port_operations cy82c6
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
@@ -158,6 +156,7 @@ static struct ata_port_operations cy82c6
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 05_rename_thaw_freeze/drivers/ata/pata_efar.c 05_rename_thaw_lldd/drivers/ata/pata_efar.c
--- 05_rename_thaw_freeze/drivers/ata/pata_efar.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/pata_efar.c	2007-07-07 10:49:30.000000000 +0800
@@ -261,8 +261,6 @@ static const struct ata_port_operations 
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= efar_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= efar_cable_detect,
@@ -278,6 +276,7 @@ static const struct ata_port_operations 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
diff -Nrup 05_rename_thaw_freeze/drivers/ata/pata_hpt366.c 05_rename_thaw_lldd/drivers/ata/pata_hpt366.c
--- 05_rename_thaw_freeze/drivers/ata/pata_hpt366.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/pata_hpt366.c	2007-07-07 10:49:30.000000000 +0800
@@ -323,8 +323,6 @@ static struct ata_port_operations hpt366
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= hpt36x_cable_detect,
@@ -342,6 +340,7 @@ static struct ata_port_operations hpt366
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 05_rename_thaw_freeze/drivers/ata/pata_hpt37x.c 05_rename_thaw_lldd/drivers/ata/pata_hpt37x.c
--- 05_rename_thaw_freeze/drivers/ata/pata_hpt37x.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/pata_hpt37x.c	2007-07-07 10:49:30.000000000 +0800
@@ -655,8 +655,6 @@ static struct ata_port_operations hpt370
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= hpt37x_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 
@@ -673,6 +671,7 @@ static struct ata_port_operations hpt370
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
@@ -694,8 +693,6 @@ static struct ata_port_operations hpt370
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= hpt37x_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 
@@ -712,6 +709,7 @@ static struct ata_port_operations hpt370
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
@@ -734,8 +732,6 @@ static struct ata_port_operations hpt372
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= hpt37x_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 
@@ -752,6 +748,7 @@ static struct ata_port_operations hpt372
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
@@ -774,8 +771,6 @@ static struct ata_port_operations hpt374
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= hpt374_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 
@@ -792,6 +787,7 @@ static struct ata_port_operations hpt374
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 05_rename_thaw_freeze/drivers/ata/pata_hpt3x2n.c 05_rename_thaw_lldd/drivers/ata/pata_hpt3x2n.c
--- 05_rename_thaw_freeze/drivers/ata/pata_hpt3x2n.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/pata_hpt3x2n.c	2007-07-07 10:49:30.000000000 +0800
@@ -371,8 +371,6 @@ static struct ata_port_operations hpt3x2
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= hpt3x2n_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= hpt3x2n_cable_detect,
@@ -390,6 +388,7 @@ static struct ata_port_operations hpt3x2
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 05_rename_thaw_freeze/drivers/ata/pata_hpt3x3.c 05_rename_thaw_lldd/drivers/ata/pata_hpt3x3.c
--- 05_rename_thaw_freeze/drivers/ata/pata_hpt3x3.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/pata_hpt3x3.c	2007-07-07 10:49:30.000000000 +0800
@@ -114,8 +114,6 @@ static struct ata_port_operations hpt3x3
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
@@ -133,6 +131,7 @@ static struct ata_port_operations hpt3x3
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 05_rename_thaw_freeze/drivers/ata/pata_icside.c 05_rename_thaw_lldd/drivers/ata/pata_icside.c
--- 05_rename_thaw_freeze/drivers/ata/pata_icside.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/pata_icside.c	2007-07-07 10:49:30.000000000 +0800
@@ -395,13 +395,12 @@ static struct ata_port_operations pata_i
 	.qc_prep		= ata_noop_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= pata_icside_bmdma_stop,
 
 	.irq_clear		= ata_dummy_noret,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= pata_icside_irq_ack,
 
 	.port_start		= pata_icside_port_start,
diff -Nrup 05_rename_thaw_freeze/drivers/ata/pata_isapnp.c 05_rename_thaw_lldd/drivers/ata/pata_isapnp.c
--- 05_rename_thaw_freeze/drivers/ata/pata_isapnp.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/pata_isapnp.c	2007-07-07 10:49:30.000000000 +0800
@@ -45,8 +45,6 @@ static struct ata_port_operations isapnp
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
@@ -58,6 +56,7 @@ static struct ata_port_operations isapnp
 
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 05_rename_thaw_freeze/drivers/ata/pata_it8213.c 05_rename_thaw_lldd/drivers/ata/pata_it8213.c
--- 05_rename_thaw_freeze/drivers/ata/pata_it8213.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/pata_it8213.c	2007-07-07 10:49:30.000000000 +0800
@@ -271,8 +271,6 @@ static const struct ata_port_operations 
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= it8213_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= it8213_cable_detect,
@@ -288,6 +286,7 @@ static const struct ata_port_operations 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
diff -Nrup 05_rename_thaw_freeze/drivers/ata/pata_it821x.c 05_rename_thaw_lldd/drivers/ata/pata_it821x.c
--- 05_rename_thaw_freeze/drivers/ata/pata_it821x.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/pata_it821x.c	2007-07-07 10:49:30.000000000 +0800
@@ -629,8 +629,6 @@ static struct ata_port_operations it821x
 	.dev_select 	= ata_std_dev_select,
 	.dev_config	= it821x_dev_config,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_unknown,
@@ -648,6 +646,7 @@ static struct ata_port_operations it821x
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= it821x_port_start,
@@ -666,8 +665,6 @@ static struct ata_port_operations it821x
 	.check_atapi_dma= it821x_check_atapi_dma,
 	.dev_select 	= it821x_passthru_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_unknown,
@@ -685,6 +682,7 @@ static struct ata_port_operations it821x
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_handler	= ata_interrupt,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= it821x_port_start,
diff -Nrup 05_rename_thaw_freeze/drivers/ata/pata_ixp4xx_cf.c 05_rename_thaw_lldd/drivers/ata/pata_ixp4xx_cf.c
--- 05_rename_thaw_freeze/drivers/ata/pata_ixp4xx_cf.c	2007-07-07 10:39:43.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/pata_ixp4xx_cf.c	2007-07-07 10:49:30.000000000 +0800
@@ -131,11 +131,9 @@ static struct ata_port_operations ixp4xx
 	.data_xfer	= ixp4xx_mmio_data_xfer,
 	.cable_detect	= ata_cable_40wire,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
-
 	.irq_clear	= ixp4xx_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 05_rename_thaw_freeze/drivers/ata/pata_jmicron.c 05_rename_thaw_lldd/drivers/ata/pata_jmicron.c
--- 05_rename_thaw_freeze/drivers/ata/pata_jmicron.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/pata_jmicron.c	2007-07-07 10:49:30.000000000 +0800
@@ -150,8 +150,6 @@ static const struct ata_port_operations 
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= jmicron_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 
@@ -168,6 +166,7 @@ static const struct ata_port_operations 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	/* Generic PATA PCI ATA helpers */
diff -Nrup 05_rename_thaw_freeze/drivers/ata/pata_legacy.c 05_rename_thaw_lldd/drivers/ata/pata_legacy.c
--- 05_rename_thaw_freeze/drivers/ata/pata_legacy.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/pata_legacy.c	2007-07-07 10:49:30.000000000 +0800
@@ -158,8 +158,6 @@ static struct ata_port_operations simple
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
@@ -172,6 +170,7 @@ static struct ata_port_operations simple
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
@@ -188,8 +187,6 @@ static struct ata_port_operations legacy
 	.dev_select 	= ata_std_dev_select,
 	.cable_detect	= ata_cable_40wire,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 
@@ -201,6 +198,7 @@ static struct ata_port_operations legacy
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
@@ -303,8 +301,6 @@ static struct ata_port_operations pdc202
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
@@ -317,6 +313,7 @@ static struct ata_port_operations pdc202
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
@@ -359,8 +356,6 @@ static struct ata_port_operations ht6560
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
@@ -373,6 +368,7 @@ static struct ata_port_operations ht6560
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
@@ -426,8 +422,6 @@ static struct ata_port_operations ht6560
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
@@ -440,6 +434,7 @@ static struct ata_port_operations ht6560
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
@@ -548,8 +543,6 @@ static struct ata_port_operations opti82
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
@@ -562,6 +555,7 @@ static struct ata_port_operations opti82
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
@@ -682,8 +676,6 @@ static struct ata_port_operations opti82
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
@@ -696,6 +688,7 @@ static struct ata_port_operations opti82
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 05_rename_thaw_freeze/drivers/ata/pata_marvell.c 05_rename_thaw_lldd/drivers/ata/pata_marvell.c
--- 05_rename_thaw_freeze/drivers/ata/pata_marvell.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/pata_marvell.c	2007-07-07 10:49:30.000000000 +0800
@@ -119,8 +119,6 @@ static const struct ata_port_operations 
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= marvell_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= marvell_cable_detect,
@@ -138,6 +136,7 @@ static const struct ata_port_operations 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	/* Generic PATA PCI ATA helpers */
diff -Nrup 05_rename_thaw_freeze/drivers/ata/pata_mpc52xx.c 05_rename_thaw_lldd/drivers/ata/pata_mpc52xx.c
--- 05_rename_thaw_freeze/drivers/ata/pata_mpc52xx.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/pata_mpc52xx.c	2007-07-07 10:49:30.000000000 +0800
@@ -290,8 +290,6 @@ static struct ata_port_operations mpc52x
 	.tf_read		= ata_tf_read,
 	.check_status		= ata_check_status,
 	.exec_command		= ata_exec_command,
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= mpc52xx_ata_error_handler,
 	.cable_detect		= ata_cable_40wire,
 	.qc_prep		= ata_qc_prep,
@@ -299,6 +297,7 @@ static struct ata_port_operations mpc52x
 	.data_xfer		= ata_data_xfer,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 	.port_start		= ata_port_start,
 };
diff -Nrup 05_rename_thaw_freeze/drivers/ata/pata_mpiix.c 05_rename_thaw_lldd/drivers/ata/pata_mpiix.c
--- 05_rename_thaw_freeze/drivers/ata/pata_mpiix.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/pata_mpiix.c	2007-07-07 10:49:30.000000000 +0800
@@ -177,8 +177,6 @@ static struct ata_port_operations mpiix_
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= mpiix_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
@@ -189,6 +187,7 @@ static struct ata_port_operations mpiix_
 
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 05_rename_thaw_freeze/drivers/ata/pata_netcell.c 05_rename_thaw_lldd/drivers/ata/pata_netcell.c
--- 05_rename_thaw_freeze/drivers/ata/pata_netcell.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/pata_netcell.c	2007-07-07 10:49:30.000000000 +0800
@@ -49,8 +49,6 @@ static const struct ata_port_operations 
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= ata_cable_80wire,
@@ -68,6 +66,7 @@ static const struct ata_port_operations 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	/* Generic PATA PCI ATA helpers */
diff -Nrup 05_rename_thaw_freeze/drivers/ata/pata_ns87410.c 05_rename_thaw_lldd/drivers/ata/pata_ns87410.c
--- 05_rename_thaw_freeze/drivers/ata/pata_ns87410.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/pata_ns87410.c	2007-07-07 10:49:30.000000000 +0800
@@ -170,8 +170,6 @@ static struct ata_port_operations ns8741
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ns87410_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
@@ -184,6 +182,7 @@ static struct ata_port_operations ns8741
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 05_rename_thaw_freeze/drivers/ata/pata_oldpiix.c 05_rename_thaw_lldd/drivers/ata/pata_oldpiix.c
--- 05_rename_thaw_freeze/drivers/ata/pata_oldpiix.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/pata_oldpiix.c	2007-07-07 10:49:30.000000000 +0800
@@ -248,8 +248,6 @@ static const struct ata_port_operations 
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= oldpiix_pata_error_handler,
 	.post_internal_cmd 	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= ata_cable_40wire,
@@ -265,6 +263,7 @@ static const struct ata_port_operations 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
diff -Nrup 05_rename_thaw_freeze/drivers/ata/pata_opti.c 05_rename_thaw_lldd/drivers/ata/pata_opti.c
--- 05_rename_thaw_freeze/drivers/ata/pata_opti.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/pata_opti.c	2007-07-07 10:49:30.000000000 +0800
@@ -190,8 +190,6 @@ static struct ata_port_operations opti_p
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= opti_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
@@ -209,6 +207,7 @@ static struct ata_port_operations opti_p
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 05_rename_thaw_freeze/drivers/ata/pata_optidma.c 05_rename_thaw_lldd/drivers/ata/pata_optidma.c
--- 05_rename_thaw_freeze/drivers/ata/pata_optidma.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/pata_optidma.c	2007-07-07 10:49:30.000000000 +0800
@@ -376,8 +376,6 @@ static struct ata_port_operations optidm
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.error_handler	= optidma_error_handler,
 	.set_mode	= optidma_set_mode,
@@ -396,6 +394,7 @@ static struct ata_port_operations optidm
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
@@ -412,8 +411,6 @@ static struct ata_port_operations optipl
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.error_handler	= optidma_error_handler,
 	.set_mode	= optidma_set_mode,
@@ -432,6 +429,7 @@ static struct ata_port_operations optipl
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 05_rename_thaw_freeze/drivers/ata/pata_pcmcia.c 05_rename_thaw_lldd/drivers/ata/pata_pcmcia.c
--- 05_rename_thaw_freeze/drivers/ata/pata_pcmcia.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/pata_pcmcia.c	2007-07-07 10:49:30.000000000 +0800
@@ -114,8 +114,6 @@ static struct ata_port_operations pcmcia
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
@@ -127,6 +125,7 @@ static struct ata_port_operations pcmcia
 
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_sff_port_start,
diff -Nrup 05_rename_thaw_freeze/drivers/ata/pata_pdc2027x.c 05_rename_thaw_lldd/drivers/ata/pata_pdc2027x.c
--- 05_rename_thaw_freeze/drivers/ata/pata_pdc2027x.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/pata_pdc2027x.c	2007-07-07 10:49:30.000000000 +0800
@@ -165,14 +165,13 @@ static struct ata_port_operations pdc202
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_data_xfer,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= pdc2027x_error_handler,
 	.post_internal_cmd 	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= pdc2027x_cable_detect,
 
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
@@ -200,14 +199,13 @@ static struct ata_port_operations pdc202
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_data_xfer,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= pdc2027x_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= pdc2027x_cable_detect,
 
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
diff -Nrup 05_rename_thaw_freeze/drivers/ata/pata_pdc202xx_old.c 05_rename_thaw_lldd/drivers/ata/pata_pdc202xx_old.c
--- 05_rename_thaw_freeze/drivers/ata/pata_pdc202xx_old.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/pata_pdc202xx_old.c	2007-07-07 10:49:30.000000000 +0800
@@ -257,8 +257,6 @@ static struct ata_port_operations pdc202
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
@@ -275,6 +273,7 @@ static struct ata_port_operations pdc202
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
@@ -292,8 +291,6 @@ static struct ata_port_operations pdc202
 	.dev_select 	= ata_std_dev_select,
 	.dev_config	= pdc2026x_dev_config,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= pdc2026x_cable_detect,
@@ -310,6 +307,7 @@ static struct ata_port_operations pdc202
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 05_rename_thaw_freeze/drivers/ata/pata_platform.c 05_rename_thaw_lldd/drivers/ata/pata_platform.c
--- 05_rename_thaw_freeze/drivers/ata/pata_platform.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/pata_platform.c	2007-07-07 10:49:30.000000000 +0800
@@ -78,8 +78,6 @@ static struct ata_port_operations pata_p
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= ata_cable_unknown,
@@ -91,6 +89,7 @@ static struct ata_port_operations pata_p
 
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_dummy_ret0,
diff -Nrup 05_rename_thaw_freeze/drivers/ata/pata_qdi.c 05_rename_thaw_lldd/drivers/ata/pata_qdi.c
--- 05_rename_thaw_freeze/drivers/ata/pata_qdi.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/pata_qdi.c	2007-07-07 10:49:30.000000000 +0800
@@ -179,8 +179,6 @@ static struct ata_port_operations qdi650
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
@@ -192,6 +190,7 @@ static struct ata_port_operations qdi650
 
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
@@ -207,8 +206,6 @@ static struct ata_port_operations qdi658
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
@@ -220,6 +217,7 @@ static struct ata_port_operations qdi658
 
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 05_rename_thaw_freeze/drivers/ata/pata_radisys.c 05_rename_thaw_lldd/drivers/ata/pata_radisys.c
--- 05_rename_thaw_freeze/drivers/ata/pata_radisys.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/pata_radisys.c	2007-07-07 10:49:30.000000000 +0800
@@ -214,8 +214,6 @@ static const struct ata_port_operations 
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= ata_cable_unknown,
@@ -231,6 +229,7 @@ static const struct ata_port_operations 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
diff -Nrup 05_rename_thaw_freeze/drivers/ata/pata_rz1000.c 05_rename_thaw_lldd/drivers/ata/pata_rz1000.c
--- 05_rename_thaw_freeze/drivers/ata/pata_rz1000.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/pata_rz1000.c	2007-07-07 10:49:30.000000000 +0800
@@ -91,8 +91,6 @@ static struct ata_port_operations rz1000
 
 	.data_xfer	= ata_data_xfer,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
@@ -100,6 +98,7 @@ static struct ata_port_operations rz1000
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 05_rename_thaw_freeze/drivers/ata/pata_sc1200.c 05_rename_thaw_lldd/drivers/ata/pata_sc1200.c
--- 05_rename_thaw_freeze/drivers/ata/pata_sc1200.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/pata_sc1200.c	2007-07-07 10:49:30.000000000 +0800
@@ -208,8 +208,6 @@ static struct ata_port_operations sc1200
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
@@ -227,6 +225,7 @@ static struct ata_port_operations sc1200
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 05_rename_thaw_freeze/drivers/ata/pata_scc.c 05_rename_thaw_lldd/drivers/ata/pata_scc.c
--- 05_rename_thaw_freeze/drivers/ata/pata_scc.c	2007-07-07 10:39:43.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/pata_scc.c	2007-07-07 10:49:30.000000000 +0800
@@ -795,20 +795,42 @@ static void scc_data_xfer (struct ata_de
  *	Note: Original code is ata_irq_on().
  */
 
-static u8 scc_irq_on (struct ata_port *ap)
+static void scc_irq_on (struct ata_port *ap)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
-	u8 tmp;
 
 	ap->ctl &= ~ATA_NIEN;
 	ap->last_ctl = ap->ctl;
 
 	out_be32(ioaddr->ctl_addr, ap->ctl);
-	tmp = ata_wait_idle(ap);
+	ata_wait_idle(ap);
 
 	ap->ops->irq_clear(ap);
+}
+
+/**
+ *	scc_irq_off - Disable interrupts on a port.
+ *	@ap: Port on which interrupts are disabled.
+ *
+ *	Note: Original code is ata_irq_off().
+ */
+
+static void scc_irq_off (struct ata_port *ap)
+{
+	struct ata_ioports *ioaddr = &ap->ioaddr;
+
+	ap->ctl |= ATA_NIEN;
+	ap->last_ctl = ap->ctl;
 
-	return tmp;
+	out_be32(ioaddr->ctl_addr, ap->ctl);
+
+	/* Under certain circumstances, some controllers raise IRQ on
+	 * ATA_NIEN manipulation.  Also, many controllers fail to mask
+	 * previously pending IRQ on ATA_NIEN assertion.  Clear it.
+	 */
+	ata_wait_idle(ap);
+
+	ap->ops->irq_clear(ap);
 }
 
 /**
@@ -844,43 +866,6 @@ static u8 scc_irq_ack (struct ata_port *
 }
 
 /**
- *	scc_bmdma_freeze - Freeze BMDMA controller port
- *	@ap: port to freeze
- *
- *	Note: Original code is ata_bmdma_freeze().
- */
-
-static void scc_bmdma_freeze (struct ata_port *ap)
-{
-	struct ata_ioports *ioaddr = &ap->ioaddr;
-
-	ap->ctl |= ATA_NIEN;
-	ap->last_ctl = ap->ctl;
-
-	out_be32(ioaddr->ctl_addr, ap->ctl);
-
-	/* Under certain circumstances, some controllers raise IRQ on
-	 * ATA_NIEN manipulation.  Also, many controllers fail to mask
-	 * previously pending IRQ on ATA_NIEN assertion.  Clear it.
-	 */
-	ata_chk_status(ap);
-
-	ap->ops->irq_clear(ap);
-}
-
-/**
- *	scc_bmdma_thaw - Thaw BMDMA controller port
- *	@ap: port to thaw
- *
- *	Note: Original code is ata_bmdma_thaw().
- */
-
-static void scc_bmdma_thaw (struct ata_port *ap)
-{
-	scc_irq_on(ap);
-}
-
-/**
  *	scc_pata_prereset - prepare for reset
  *	@ap: ATA port to be reset
  *	@deadline: deadline jiffies for the operation
@@ -1026,13 +1011,12 @@ static const struct ata_port_operations 
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 
-	.freeze			= scc_bmdma_freeze,
-	.thaw			= scc_bmdma_thaw,
 	.error_handler		= scc_error_handler,
 	.post_internal_cmd	= scc_bmdma_stop,
 
 	.irq_clear		= scc_bmdma_irq_clear,
 	.irq_on			= scc_irq_on,
+	.irq_off		= scc_irq_off,
 	.irq_ack		= scc_irq_ack,
 
 	.port_start		= scc_port_start,
diff -Nrup 05_rename_thaw_freeze/drivers/ata/pata_serverworks.c 05_rename_thaw_lldd/drivers/ata/pata_serverworks.c
--- 05_rename_thaw_freeze/drivers/ata/pata_serverworks.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/pata_serverworks.c	2007-07-07 10:49:30.000000000 +0800
@@ -329,8 +329,6 @@ static struct ata_port_operations server
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= serverworks_cable_detect,
@@ -348,6 +346,7 @@ static struct ata_port_operations server
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
@@ -365,8 +364,6 @@ static struct ata_port_operations server
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= serverworks_cable_detect,
@@ -384,6 +381,7 @@ static struct ata_port_operations server
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 05_rename_thaw_freeze/drivers/ata/pata_sil680.c 05_rename_thaw_lldd/drivers/ata/pata_sil680.c
--- 05_rename_thaw_freeze/drivers/ata/pata_sil680.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/pata_sil680.c	2007-07-07 10:49:30.000000000 +0800
@@ -245,8 +245,6 @@ static struct ata_port_operations sil680
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= sil680_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= sil680_cable_detect,
@@ -264,6 +262,7 @@ static struct ata_port_operations sil680
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 05_rename_thaw_freeze/drivers/ata/pata_sis.c 05_rename_thaw_lldd/drivers/ata/pata_sis.c
--- 05_rename_thaw_freeze/drivers/ata/pata_sis.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/pata_sis.c	2007-07-07 10:49:30.000000000 +0800
@@ -538,8 +538,6 @@ static const struct ata_port_operations 
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= sis_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= sis_133_cable_detect,
@@ -555,6 +553,7 @@ static const struct ata_port_operations 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
@@ -572,8 +571,6 @@ static const struct ata_port_operations 
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= sis_133_cable_detect,
@@ -589,6 +586,7 @@ static const struct ata_port_operations 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
@@ -606,8 +604,6 @@ static const struct ata_port_operations 
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= sis_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= sis_66_cable_detect,
@@ -623,6 +619,7 @@ static const struct ata_port_operations 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
@@ -640,8 +637,6 @@ static const struct ata_port_operations 
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= sis_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= sis_66_cable_detect,
@@ -657,6 +652,7 @@ static const struct ata_port_operations 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
@@ -675,8 +671,6 @@ static const struct ata_port_operations 
 	.dev_select		= ata_std_dev_select,
 	.cable_detect		= sis_66_cable_detect,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= sis_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 
@@ -691,6 +685,7 @@ static const struct ata_port_operations 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
@@ -708,8 +703,6 @@ static const struct ata_port_operations 
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= sis_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= ata_cable_40wire,
@@ -725,6 +718,7 @@ static const struct ata_port_operations 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
diff -Nrup 05_rename_thaw_freeze/drivers/ata/pata_sl82c105.c 05_rename_thaw_lldd/drivers/ata/pata_sl82c105.c
--- 05_rename_thaw_freeze/drivers/ata/pata_sl82c105.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/pata_sl82c105.c	2007-07-07 10:49:30.000000000 +0800
@@ -234,8 +234,6 @@ static struct ata_port_operations sl82c1
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= sl82c105_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
@@ -253,6 +251,7 @@ static struct ata_port_operations sl82c1
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 05_rename_thaw_freeze/drivers/ata/pata_triflex.c 05_rename_thaw_lldd/drivers/ata/pata_triflex.c
--- 05_rename_thaw_freeze/drivers/ata/pata_triflex.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/pata_triflex.c	2007-07-07 10:49:30.000000000 +0800
@@ -207,8 +207,6 @@ static struct ata_port_operations trifle
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= triflex_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
@@ -226,6 +224,7 @@ static struct ata_port_operations trifle
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 05_rename_thaw_freeze/drivers/ata/pata_via.c 05_rename_thaw_lldd/drivers/ata/pata_via.c
--- 05_rename_thaw_freeze/drivers/ata/pata_via.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/pata_via.c	2007-07-07 10:49:30.000000000 +0800
@@ -344,8 +344,6 @@ static struct ata_port_operations via_po
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= via_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= via_cable_detect,
@@ -363,6 +361,7 @@ static struct ata_port_operations via_po
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
@@ -380,8 +379,6 @@ static struct ata_port_operations via_po
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= via_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= via_cable_detect,
@@ -399,6 +396,7 @@ static struct ata_port_operations via_po
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 05_rename_thaw_freeze/drivers/ata/pata_winbond.c 05_rename_thaw_lldd/drivers/ata/pata_winbond.c
--- 05_rename_thaw_freeze/drivers/ata/pata_winbond.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/pata_winbond.c	2007-07-07 10:49:30.000000000 +0800
@@ -147,8 +147,6 @@ static struct ata_port_operations winbon
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.freeze		= ata_bmdma_freeze,
-	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
@@ -160,6 +158,7 @@ static struct ata_port_operations winbon
 
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
+	.irq_off	= ata_irq_off,
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
diff -Nrup 05_rename_thaw_freeze/drivers/ata/pdc_adma.c 05_rename_thaw_lldd/drivers/ata/pdc_adma.c
--- 05_rename_thaw_freeze/drivers/ata/pdc_adma.c	2007-07-07 10:39:43.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/pdc_adma.c	2007-07-07 10:49:30.000000000 +0800
@@ -171,10 +171,9 @@ static const struct ata_port_operations 
 	.qc_issue		= adma_qc_issue,
 	.eng_timeout		= adma_eng_timeout,
 	.data_xfer		= ata_data_xfer,
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.irq_clear		= adma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 	.port_start		= adma_port_start,
 	.port_stop		= adma_port_stop,
diff -Nrup 05_rename_thaw_freeze/drivers/ata/sata_inic162x.c 05_rename_thaw_lldd/drivers/ata/sata_inic162x.c
--- 05_rename_thaw_freeze/drivers/ata/sata_inic162x.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/sata_inic162x.c	2007-07-07 10:49:30.000000000 +0800
@@ -388,7 +388,7 @@ static unsigned int inic_qc_issue(struct
 	return ata_qc_issue_prot(qc);
 }
 
-static void inic_freeze(struct ata_port *ap)
+static void inic_irq_off(struct ata_port *ap)
 {
 	void __iomem *port_base = inic_port_base(ap);
 
@@ -400,7 +400,7 @@ static void inic_freeze(struct ata_port 
 	readb(port_base + PORT_IRQ_STAT); /* flush */
 }
 
-static void inic_thaw(struct ata_port *ap)
+static void inic_irq_on(struct ata_port *ap)
 {
 	void __iomem *port_base = inic_port_base(ap);
 
@@ -566,15 +566,14 @@ static struct ata_port_operations inic_p
 	.bmdma_status		= inic_bmdma_status,
 
 	.irq_clear		= inic_irq_clear,
-	.irq_on			= ata_irq_on,
+	.irq_on			= inic_irq_on,
+	.irq_off		= inic_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.qc_prep	 	= ata_qc_prep,
 	.qc_issue		= inic_qc_issue,
 	.data_xfer		= ata_data_xfer,
 
-	.freeze			= inic_freeze,
-	.thaw			= inic_thaw,
 	.error_handler		= inic_error_handler,
 	.post_internal_cmd	= inic_post_internal_cmd,
 	.dev_config		= inic_dev_config,
diff -Nrup 05_rename_thaw_freeze/drivers/ata/sata_mv.c 05_rename_thaw_lldd/drivers/ata/sata_mv.c
--- 05_rename_thaw_freeze/drivers/ata/sata_mv.c	2007-07-07 10:39:43.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/sata_mv.c	2007-07-07 10:49:30.000000000 +0800
@@ -453,11 +453,9 @@ static const struct ata_port_operations 
 
 	.eng_timeout		= mv_eng_timeout,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
-
 	.irq_clear		= mv_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.scr_read		= mv5_scr_read,
@@ -485,11 +483,9 @@ static const struct ata_port_operations 
 
 	.eng_timeout		= mv_eng_timeout,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
-
 	.irq_clear		= mv_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.scr_read		= mv_scr_read,
@@ -517,11 +513,9 @@ static const struct ata_port_operations 
 
 	.eng_timeout		= mv_eng_timeout,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
-
 	.irq_clear		= mv_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.scr_read		= mv_scr_read,
diff -Nrup 05_rename_thaw_freeze/drivers/ata/sata_nv.c 05_rename_thaw_lldd/drivers/ata/sata_nv.c
--- 05_rename_thaw_freeze/drivers/ata/sata_nv.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/sata_nv.c	2007-07-07 10:49:30.000000000 +0800
@@ -239,10 +239,10 @@ static irqreturn_t nv_ck804_interrupt(in
 static u32 nv_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void nv_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 
-static void nv_nf2_freeze(struct ata_port *ap);
-static void nv_nf2_thaw(struct ata_port *ap);
-static void nv_ck804_freeze(struct ata_port *ap);
-static void nv_ck804_thaw(struct ata_port *ap);
+static void nv_nf2_irq_on(struct ata_port *ap);
+static void nv_nf2_irq_off(struct ata_port *ap);
+static void nv_ck804_irq_on(struct ata_port *ap);
+static void nv_ck804_irq_off(struct ata_port *ap);
 static void nv_error_handler(struct ata_port *ap);
 static int nv_adma_slave_config(struct scsi_device *sdev);
 static int nv_adma_check_atapi_dma(struct ata_queued_cmd *qc);
@@ -256,8 +256,8 @@ static void nv_adma_port_stop(struct ata
 static int nv_adma_port_suspend(struct ata_port *ap, pm_message_t mesg);
 static int nv_adma_port_resume(struct ata_port *ap);
 #endif
-static void nv_adma_freeze(struct ata_port *ap);
-static void nv_adma_thaw(struct ata_port *ap);
+static void nv_adma_irq_on(struct ata_port *ap);
+static void nv_adma_irq_off(struct ata_port *ap);
 static void nv_adma_error_handler(struct ata_port *ap);
 static void nv_adma_host_stop(struct ata_host *host);
 static void nv_adma_post_internal_cmd(struct ata_queued_cmd *qc);
@@ -352,13 +352,12 @@ static const struct ata_port_operations 
 	.bmdma_status		= ata_bmdma_status,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= nv_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.data_xfer		= ata_data_xfer,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 	.scr_read		= nv_scr_read,
 	.scr_write		= nv_scr_write,
@@ -378,13 +377,12 @@ static const struct ata_port_operations 
 	.bmdma_status		= ata_bmdma_status,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
-	.freeze			= nv_nf2_freeze,
-	.thaw			= nv_nf2_thaw,
 	.error_handler		= nv_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.data_xfer		= ata_data_xfer,
 	.irq_clear		= ata_bmdma_irq_clear,
-	.irq_on			= ata_irq_on,
+	.irq_on			= nv_nf2_irq_on,
+	.irq_off		= nv_nf2_irq_off,
 	.irq_ack		= ata_irq_ack,
 	.scr_read		= nv_scr_read,
 	.scr_write		= nv_scr_write,
@@ -404,13 +402,12 @@ static const struct ata_port_operations 
 	.bmdma_status		= ata_bmdma_status,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
-	.freeze			= nv_ck804_freeze,
-	.thaw			= nv_ck804_thaw,
 	.error_handler		= nv_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.data_xfer		= ata_data_xfer,
 	.irq_clear		= ata_bmdma_irq_clear,
-	.irq_on			= ata_irq_on,
+	.irq_on			= nv_ck804_irq_on,
+	.irq_off		= nv_ck804_irq_off,
 	.irq_ack		= ata_irq_ack,
 	.scr_read		= nv_scr_read,
 	.scr_write		= nv_scr_write,
@@ -432,13 +429,12 @@ static const struct ata_port_operations 
 	.bmdma_status		= ata_bmdma_status,
 	.qc_prep		= nv_adma_qc_prep,
 	.qc_issue		= nv_adma_qc_issue,
-	.freeze			= nv_adma_freeze,
-	.thaw			= nv_adma_thaw,
 	.error_handler		= nv_adma_error_handler,
 	.post_internal_cmd	= nv_adma_post_internal_cmd,
 	.data_xfer		= ata_data_xfer,
 	.irq_clear		= nv_adma_irq_clear,
-	.irq_on			= ata_irq_on,
+	.irq_on			= nv_adma_irq_on,
+	.irq_off		= nv_adma_irq_off,
 	.irq_ack		= ata_irq_ack,
 	.scr_read		= nv_scr_read,
 	.scr_write		= nv_scr_write,
@@ -907,13 +903,13 @@ static irqreturn_t nv_adma_interrupt(int
 	return IRQ_RETVAL(handled);
 }
 
-static void nv_adma_freeze(struct ata_port *ap)
+static void nv_adma_irq_off(struct ata_port *ap)
 {
 	struct nv_adma_port_priv *pp = ap->private_data;
 	void __iomem *mmio = pp->ctl_block;
 	u16 tmp;
 
-	nv_ck804_freeze(ap);
+	nv_ck804_irq_off(ap);
 
 	if (pp->flags & NV_ADMA_ATAPI_SETUP_COMPLETE)
 		return;
@@ -929,13 +925,13 @@ static void nv_adma_freeze(struct ata_po
 	readw( mmio + NV_ADMA_CTL );	/* flush posted write */
 }
 
-static void nv_adma_thaw(struct ata_port *ap)
+static void nv_adma_irq_on(struct ata_port *ap)
 {
 	struct nv_adma_port_priv *pp = ap->private_data;
 	void __iomem *mmio = pp->ctl_block;
 	u16 tmp;
 
-	nv_ck804_thaw(ap);
+	nv_ck804_irq_on(ap);
 
 	if (pp->flags & NV_ADMA_ATAPI_SETUP_COMPLETE)
 		return;
@@ -1407,7 +1403,7 @@ static void nv_scr_write (struct ata_por
 	iowrite32(val, ap->ioaddr.scr_addr + (sc_reg * 4));
 }
 
-static void nv_nf2_freeze(struct ata_port *ap)
+static void nv_nf2_irq_off(struct ata_port *ap)
 {
 	void __iomem *scr_addr = ap->host->ports[0]->ioaddr.scr_addr;
 	int shift = ap->port_no * NV_INT_PORT_SHIFT;
@@ -1418,7 +1414,7 @@ static void nv_nf2_freeze(struct ata_por
 	iowrite8(mask, scr_addr + NV_INT_ENABLE);
 }
 
-static void nv_nf2_thaw(struct ata_port *ap)
+static void nv_nf2_irq_on(struct ata_port *ap)
 {
 	void __iomem *scr_addr = ap->host->ports[0]->ioaddr.scr_addr;
 	int shift = ap->port_no * NV_INT_PORT_SHIFT;
@@ -1431,7 +1427,7 @@ static void nv_nf2_thaw(struct ata_port 
 	iowrite8(mask, scr_addr + NV_INT_ENABLE);
 }
 
-static void nv_ck804_freeze(struct ata_port *ap)
+static void nv_ck804_irq_off(struct ata_port *ap)
 {
 	void __iomem *mmio_base = ap->host->iomap[NV_MMIO_BAR];
 	int shift = ap->port_no * NV_INT_PORT_SHIFT;
@@ -1442,7 +1438,7 @@ static void nv_ck804_freeze(struct ata_p
 	writeb(mask, mmio_base + NV_INT_ENABLE_CK804);
 }
 
-static void nv_ck804_thaw(struct ata_port *ap)
+static void nv_ck804_irq_on(struct ata_port *ap)
 {
 	void __iomem *mmio_base = ap->host->iomap[NV_MMIO_BAR];
 	int shift = ap->port_no * NV_INT_PORT_SHIFT;
diff -Nrup 05_rename_thaw_freeze/drivers/ata/sata_promise.c 05_rename_thaw_lldd/drivers/ata/sata_promise.c
--- 05_rename_thaw_freeze/drivers/ata/sata_promise.c	2007-07-07 10:39:22.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/sata_promise.c	2007-07-07 10:49:30.000000000 +0800
@@ -142,8 +142,8 @@ static int pdc_check_atapi_dma(struct at
 static int pdc_old_sata_check_atapi_dma(struct ata_queued_cmd *qc);
 static void pdc_irq_clear(struct ata_port *ap);
 static unsigned int pdc_qc_issue_prot(struct ata_queued_cmd *qc);
-static void pdc_freeze(struct ata_port *ap);
-static void pdc_thaw(struct ata_port *ap);
+static void pdc_irq_on(struct ata_port *ap);
+static void pdc_irq_off(struct ata_port *ap);
 static void pdc_pata_error_handler(struct ata_port *ap);
 static void pdc_sata_error_handler(struct ata_port *ap);
 static void pdc_post_internal_cmd(struct ata_queued_cmd *qc);
@@ -179,14 +179,13 @@ static const struct ata_port_operations 
 
 	.qc_prep		= pdc_qc_prep,
 	.qc_issue		= pdc_qc_issue_prot,
-	.freeze			= pdc_freeze,
-	.thaw			= pdc_thaw,
 	.error_handler		= pdc_sata_error_handler,
 	.post_internal_cmd	= pdc_post_internal_cmd,
 	.cable_detect		= pdc_sata_cable_detect,
 	.data_xfer		= ata_data_xfer,
 	.irq_clear		= pdc_irq_clear,
-	.irq_on			= ata_irq_on,
+	.irq_on			= pdc_irq_on,
+	.irq_off		= pdc_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.scr_read		= pdc_sata_scr_read,
@@ -206,14 +205,13 @@ static const struct ata_port_operations 
 
 	.qc_prep		= pdc_qc_prep,
 	.qc_issue		= pdc_qc_issue_prot,
-	.freeze			= pdc_freeze,
-	.thaw			= pdc_thaw,
 	.error_handler		= pdc_sata_error_handler,
 	.post_internal_cmd	= pdc_post_internal_cmd,
 	.cable_detect		= pdc_sata_cable_detect,
 	.data_xfer		= ata_data_xfer,
 	.irq_clear		= pdc_irq_clear,
-	.irq_on			= ata_irq_on,
+	.irq_on			= pdc_irq_on,
+	.irq_off		= pdc_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.scr_read		= pdc_sata_scr_read,
@@ -232,14 +230,13 @@ static const struct ata_port_operations 
 
 	.qc_prep		= pdc_qc_prep,
 	.qc_issue		= pdc_qc_issue_prot,
-	.freeze			= pdc_freeze,
-	.thaw			= pdc_thaw,
 	.error_handler		= pdc_pata_error_handler,
 	.post_internal_cmd	= pdc_post_internal_cmd,
 	.cable_detect		= pdc_pata_cable_detect,
 	.data_xfer		= ata_data_xfer,
 	.irq_clear		= pdc_irq_clear,
-	.irq_on			= ata_irq_on,
+	.irq_on			= pdc_irq_on,
+	.irq_off		= pdc_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.port_start		= pdc_common_port_start,
@@ -571,7 +568,7 @@ static void pdc_qc_prep(struct ata_queue
 	}
 }
 
-static void pdc_freeze(struct ata_port *ap)
+static void pdc_irq_off(struct ata_port *ap)
 {
 	void __iomem *mmio = (void __iomem *) ap->ioaddr.cmd_addr;
 	u32 tmp;
@@ -582,7 +579,7 @@ static void pdc_freeze(struct ata_port *
 	readl(mmio + PDC_CTLSTAT); /* flush */
 }
 
-static void pdc_thaw(struct ata_port *ap)
+static void pdc_irq_on(struct ata_port *ap)
 {
 	void __iomem *mmio = (void __iomem *) ap->ioaddr.cmd_addr;
 	u32 tmp;
diff -Nrup 05_rename_thaw_freeze/drivers/ata/sata_qstor.c 05_rename_thaw_lldd/drivers/ata/sata_qstor.c
--- 05_rename_thaw_freeze/drivers/ata/sata_qstor.c	2007-07-07 10:39:43.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/sata_qstor.c	2007-07-07 10:49:30.000000000 +0800
@@ -157,10 +157,9 @@ static const struct ata_port_operations 
 	.qc_issue		= qs_qc_issue,
 	.data_xfer		= ata_data_xfer,
 	.eng_timeout		= qs_eng_timeout,
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.irq_clear		= qs_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 	.scr_read		= qs_scr_read,
 	.scr_write		= qs_scr_write,
diff -Nrup 05_rename_thaw_freeze/drivers/ata/sata_sil24.c 05_rename_thaw_lldd/drivers/ata/sata_sil24.c
--- 05_rename_thaw_freeze/drivers/ata/sata_sil24.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/sata_sil24.c	2007-07-07 10:49:30.000000000 +0800
@@ -332,8 +332,8 @@ static void sil24_tf_read(struct ata_por
 static void sil24_qc_prep(struct ata_queued_cmd *qc);
 static unsigned int sil24_qc_issue(struct ata_queued_cmd *qc);
 static void sil24_irq_clear(struct ata_port *ap);
-static void sil24_freeze(struct ata_port *ap);
-static void sil24_thaw(struct ata_port *ap);
+static void sil24_irq_on(struct ata_port *ap);
+static void sil24_irq_off(struct ata_port *ap);
 static void sil24_error_handler(struct ata_port *ap);
 static void sil24_post_internal_cmd(struct ata_queued_cmd *qc);
 static int sil24_port_start(struct ata_port *ap);
@@ -398,14 +398,13 @@ static const struct ata_port_operations 
 	.qc_issue		= sil24_qc_issue,
 
 	.irq_clear		= sil24_irq_clear,
-	.irq_on			= ata_dummy_irq_on,
+	.irq_on			= sil24_irq_on,
+	.irq_off		= sil24_irq_off,
 	.irq_ack		= ata_dummy_irq_ack,
 
 	.scr_read		= sil24_scr_read,
 	.scr_write		= sil24_scr_write,
 
-	.freeze			= sil24_freeze,
-	.thaw			= sil24_thaw,
 	.error_handler		= sil24_error_handler,
 	.post_internal_cmd	= sil24_post_internal_cmd,
 
@@ -728,7 +727,7 @@ static void sil24_irq_clear(struct ata_p
 	/* unused */
 }
 
-static void sil24_freeze(struct ata_port *ap)
+static void sil24_irq_off(struct ata_port *ap)
 {
 	void __iomem *port = ap->ioaddr.cmd_addr;
 
@@ -738,7 +737,7 @@ static void sil24_freeze(struct ata_port
 	writel(0xffff, port + PORT_IRQ_ENABLE_CLR);
 }
 
-static void sil24_thaw(struct ata_port *ap)
+static void sil24_irq_on(struct ata_port *ap)
 {
 	void __iomem *port = ap->ioaddr.cmd_addr;
 	u32 tmp;
diff -Nrup 05_rename_thaw_freeze/drivers/ata/sata_sil.c 05_rename_thaw_lldd/drivers/ata/sata_sil.c
--- 05_rename_thaw_freeze/drivers/ata/sata_sil.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/sata_sil.c	2007-07-07 10:49:30.000000000 +0800
@@ -118,8 +118,8 @@ static void sil_dev_config(struct ata_de
 static u32 sil_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void sil_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 static int sil_set_mode (struct ata_port *ap, struct ata_device **r_failed);
-static void sil_freeze(struct ata_port *ap);
-static void sil_thaw(struct ata_port *ap);
+static void sil_irq_on(struct ata_port *ap);
+static void sil_irq_off(struct ata_port *ap);
 
 
 static const struct pci_device_id sil_pci_tbl[] = {
@@ -200,12 +200,11 @@ static const struct ata_port_operations 
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_data_xfer,
-	.freeze			= sil_freeze,
-	.thaw			= sil_thaw,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.irq_clear		= ata_bmdma_irq_clear,
-	.irq_on			= ata_irq_on,
+	.irq_on			= sil_irq_on,
+	.irq_off		= sil_irq_off,
 	.irq_ack		= ata_irq_ack,
 	.scr_read		= sil_scr_read,
 	.scr_write		= sil_scr_write,
@@ -490,7 +489,7 @@ static irqreturn_t sil_interrupt(int irq
 	return IRQ_RETVAL(handled);
 }
 
-static void sil_freeze(struct ata_port *ap)
+static void sil_irq_off(struct ata_port *ap)
 {
 	void __iomem *mmio_base = ap->host->iomap[SIL_MMIO_BAR];
 	u32 tmp;
@@ -505,7 +504,7 @@ static void sil_freeze(struct ata_port *
 	readl(mmio_base + SIL_SYSCFG);	/* flush */
 }
 
-static void sil_thaw(struct ata_port *ap)
+static void sil_irq_on(struct ata_port *ap)
 {
 	void __iomem *mmio_base = ap->host->iomap[SIL_MMIO_BAR];
 	u32 tmp;
diff -Nrup 05_rename_thaw_freeze/drivers/ata/sata_sis.c 05_rename_thaw_lldd/drivers/ata/sata_sis.c
--- 05_rename_thaw_freeze/drivers/ata/sata_sis.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/sata_sis.c	2007-07-07 10:49:30.000000000 +0800
@@ -117,12 +117,11 @@ static const struct ata_port_operations 
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_data_xfer,
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 	.scr_read		= sis_scr_read,
 	.scr_write		= sis_scr_write,
diff -Nrup 05_rename_thaw_freeze/drivers/ata/sata_svw.c 05_rename_thaw_lldd/drivers/ata/sata_svw.c
--- 05_rename_thaw_freeze/drivers/ata/sata_svw.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/sata_svw.c	2007-07-07 10:49:30.000000000 +0800
@@ -341,12 +341,11 @@ static const struct ata_port_operations 
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_data_xfer,
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 	.scr_read		= k2_sata_scr_read,
 	.scr_write		= k2_sata_scr_write,
diff -Nrup 05_rename_thaw_freeze/drivers/ata/sata_sx4.c 05_rename_thaw_lldd/drivers/ata/sata_sx4.c
--- 05_rename_thaw_freeze/drivers/ata/sata_sx4.c	2007-07-07 10:39:43.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/sata_sx4.c	2007-07-07 10:49:30.000000000 +0800
@@ -203,10 +203,9 @@ static const struct ata_port_operations 
 	.qc_issue		= pdc20621_qc_issue_prot,
 	.data_xfer		= ata_data_xfer,
 	.eng_timeout		= pdc_eng_timeout,
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.irq_clear		= pdc20621_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 	.port_start		= pdc_port_start,
 };
diff -Nrup 05_rename_thaw_freeze/drivers/ata/sata_uli.c 05_rename_thaw_lldd/drivers/ata/sata_uli.c
--- 05_rename_thaw_freeze/drivers/ata/sata_uli.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/sata_uli.c	2007-07-07 10:49:30.000000000 +0800
@@ -110,13 +110,12 @@ static const struct ata_port_operations 
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_data_xfer,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.scr_read		= uli_scr_read,
diff -Nrup 05_rename_thaw_freeze/drivers/ata/sata_via.c 05_rename_thaw_lldd/drivers/ata/sata_via.c
--- 05_rename_thaw_freeze/drivers/ata/sata_via.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/sata_via.c	2007-07-07 10:49:30.000000000 +0800
@@ -74,7 +74,7 @@ enum {
 static int svia_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
 static u32 svia_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void svia_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
-static void svia_noop_freeze(struct ata_port *ap);
+static void svia_irq_off(struct ata_port *ap);
 static void vt6420_error_handler(struct ata_port *ap);
 static int vt6421_pata_cable_detect(struct ata_port *ap);
 static void vt6421_set_pio_mode(struct ata_port *ap, struct ata_device *adev);
@@ -139,13 +139,12 @@ static const struct ata_port_operations 
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_data_xfer,
 
-	.freeze			= svia_noop_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= vt6420_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= svia_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
@@ -172,14 +171,13 @@ static const struct ata_port_operations 
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_data_xfer,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= vt6421_pata_cable_detect,
 
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
@@ -203,14 +201,13 @@ static const struct ata_port_operations 
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_data_xfer,
 
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= ata_cable_sata,
 
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
+	.irq_off		= ata_irq_off,
 	.irq_ack		= ata_irq_ack,
 
 	.scr_read		= svia_scr_read,
@@ -263,13 +260,17 @@ static void svia_scr_write (struct ata_p
 	iowrite32(val, ap->ioaddr.scr_addr + (4 * sc_reg));
 }
 
-static void svia_noop_freeze(struct ata_port *ap)
+static void svia_irq_off(struct ata_port *ap)
 {
-	/* Some VIA controllers choke if ATA_NIEN is manipulated in
-	 * certain way.  Leave it alone and just clear pending IRQ.
-	 */
-	ata_chk_status(ap);
-	ata_bmdma_irq_clear(ap);
+	if (0) {
+		/* Some VIA controllers choke if ATA_NIEN is manipulated in
+		 * certain way.  Leave it alone and just clear pending IRQ.
+		 */
+		/* FIXME: http://bugzilla.kernel.org/show_bug.cgi?id=7415 */
+		ata_chk_status(ap);
+		ata_bmdma_irq_clear(ap);
+	} else
+		ata_irq_off(ap);
 }
 
 /**
diff -Nrup 05_rename_thaw_freeze/drivers/ata/sata_vsc.c 05_rename_thaw_lldd/drivers/ata/sata_vsc.c
--- 05_rename_thaw_freeze/drivers/ata/sata_vsc.c	2007-07-07 09:58:55.000000000 +0800
+++ 05_rename_thaw_lldd/drivers/ata/sata_vsc.c	2007-07-07 10:49:30.000000000 +0800
@@ -115,7 +115,7 @@ static void vsc_sata_scr_write (struct a
 }
 
 
-static void vsc_freeze(struct ata_port *ap)
+static void vsc_irq_off(struct ata_port *ap)
 {
 	void __iomem *mask_addr;
 
@@ -126,7 +126,7 @@ static void vsc_freeze(struct ata_port *
 }
 
 
-static void vsc_thaw(struct ata_port *ap)
+static void vsc_irq_on(struct ata_port *ap)
 {
 	void __iomem *mask_addr;
 
@@ -329,12 +329,11 @@ static const struct ata_port_operations 
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_data_xfer,
-	.freeze			= vsc_freeze,
-	.thaw			= vsc_thaw,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.irq_clear		= ata_bmdma_irq_clear,
-	.irq_on			= ata_irq_on,
+	.irq_on			= vsc_irq_on,
+	.irq_off		= vsc_irq_off,
 	.irq_ack		= ata_irq_ack,
 	.scr_read		= vsc_sata_scr_read,
 	.scr_write		= vsc_sata_scr_write,


