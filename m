From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 9/10] libata: Integrate freeze/thaw with irq_on/off
Date: Wed, 04 Jul 2007 17:16:30 +0800
Message-ID: <468B656E.9060002@tw.ibm.com>
References: <468B5C97.1000803@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:36183 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756798AbXGDJQf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Jul 2007 05:16:35 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id l649BK4e004496
	for <linux-ide@vger.kernel.org>; Wed, 4 Jul 2007 05:11:20 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l649GYuL076102
	for <linux-ide@vger.kernel.org>; Wed, 4 Jul 2007 03:16:35 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l649GYNl024094
	for <linux-ide@vger.kernel.org>; Wed, 4 Jul 2007 03:16:34 -0600
In-Reply-To: <468B5C97.1000803@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>

Patch 9/10:

  irq_on/irq_off are now only wrapped by freeze/thaw (and unused otherwise).
We can integrate freeze/thaw with irq_on/irq_off.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
This is for libata-core. The LLDDs will be fixed in the next patch.

diff -Nrup 08_tfload_cleanup/drivers/ata/libata-core.c 09_integrate_irq_on_off/drivers/ata/libata-core.c
--- 08_tfload_cleanup/drivers/ata/libata-core.c	2007-07-04 13:13:56.000000000 +0800
+++ 09_integrate_irq_on_off/drivers/ata/libata-core.c	2007-07-04 13:35:05.000000000 +0800
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
diff -Nrup 08_tfload_cleanup/drivers/ata/libata-eh.c 09_integrate_irq_on_off/drivers/ata/libata-eh.c
--- 08_tfload_cleanup/drivers/ata/libata-eh.c	2007-07-04 11:26:30.000000000 +0800
+++ 09_integrate_irq_on_off/drivers/ata/libata-eh.c	2007-07-04 13:36:27.000000000 +0800
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
 
diff -Nrup 08_tfload_cleanup/drivers/ata/libata-sff.c 09_integrate_irq_on_off/drivers/ata/libata-sff.c
--- 08_tfload_cleanup/drivers/ata/libata-sff.c	2007-07-04 13:20:30.000000000 +0800
+++ 09_integrate_irq_on_off/drivers/ata/libata-sff.c	2007-07-04 13:57:21.000000000 +0800
@@ -48,23 +48,20 @@
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
+void ata_dummy_irq_on (struct ata_port *ap) 	{ }
 
 /**
  *	ata_irq_off - Disable interrupts on a port.
@@ -76,10 +73,9 @@ u8 ata_dummy_irq_on (struct ata_port *ap
  *	LOCKING:
  *	Inherited from caller.
  */
-u8 ata_irq_off(struct ata_port *ap)
+void ata_irq_off(struct ata_port *ap)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
-	u8 tmp;
 
 	ap->ctl |= ATA_NIEN;
 	ap->last_ctl = ap->ctl;
@@ -90,14 +86,12 @@ u8 ata_irq_off(struct ata_port *ap)
 	 * ATA_NIEN manipulation.  Also, many controllers fail to mask
 	 * previously pending IRQ on ATA_NIEN assertion.  Clear it.
 	 */
-	tmp = ata_wait_idle(ap);
+	ata_wait_idle(ap);
 
 	ap->ops->irq_clear(ap);
-
-	return tmp;
 }
 
-u8 ata_dummy_irq_off (struct ata_port *ap) 	{ return 0; }
+void ata_dummy_irq_off (struct ata_port *ap) 	{ }
 
 /**
  *	ata_irq_ack - Acknowledge a device interrupt.
@@ -405,37 +399,6 @@ void ata_bmdma_stop(struct ata_queued_cm
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
-	ap->ops->irq_off(ap);
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
diff -Nrup 08_tfload_cleanup/include/linux/libata.h 09_integrate_irq_on_off/include/linux/libata.h
--- 08_tfload_cleanup/include/linux/libata.h	2007-07-04 13:13:56.000000000 +0800
+++ 09_integrate_irq_on_off/include/linux/libata.h	2007-07-04 13:52:06.000000000 +0800
@@ -589,15 +589,13 @@ struct ata_port_operations {
 	 */
 	void (*eng_timeout) (struct ata_port *ap); /* obsolete */
 
-	void (*freeze) (struct ata_port *ap);
-	void (*thaw) (struct ata_port *ap);
 	void (*error_handler) (struct ata_port *ap);
 	void (*post_internal_cmd) (struct ata_queued_cmd *qc);
 
 	irq_handler_t irq_handler;
 	void (*irq_clear) (struct ata_port *);
-	u8 (*irq_on) (struct ata_port *);
-	u8 (*irq_off) (struct ata_port *);
+	void (*irq_on) (struct ata_port *);
+	void (*irq_off) (struct ata_port *);
 	u8 (*irq_ack) (struct ata_port *ap, unsigned int chk_drq);
 
 	u32 (*scr_read) (struct ata_port *ap, unsigned int sc_reg);
@@ -779,8 +777,6 @@ extern void ata_bmdma_start (struct ata_
 extern void ata_bmdma_stop(struct ata_queued_cmd *qc);
 extern u8   ata_bmdma_status(struct ata_port *ap);
 extern void ata_bmdma_irq_clear(struct ata_port *ap);
-extern void ata_bmdma_freeze(struct ata_port *ap);
-extern void ata_bmdma_thaw(struct ata_port *ap);
 extern void ata_bmdma_drive_eh(struct ata_port *ap, ata_prereset_fn_t prereset,
 			       ata_reset_fn_t softreset,
 			       ata_reset_fn_t hardreset,
@@ -803,10 +799,10 @@ extern int ata_scsi_change_queue_depth(s
 				       int queue_depth);
 extern struct ata_device *ata_dev_pair(struct ata_device *adev);
 extern int ata_do_set_mode(struct ata_port *ap, struct ata_device **r_failed_dev);
-extern u8 ata_irq_on(struct ata_port *ap);
-extern u8 ata_dummy_irq_on(struct ata_port *ap);
-extern u8 ata_irq_off(struct ata_port *ap);
-extern u8 ata_dummy_irq_off(struct ata_port *ap);
+extern void ata_irq_on(struct ata_port *ap);
+extern void ata_dummy_irq_on(struct ata_port *ap);
+extern void ata_irq_off(struct ata_port *ap);
+extern void ata_dummy_irq_off(struct ata_port *ap);
 extern u8 ata_irq_ack(struct ata_port *ap, unsigned int chk_drq);
 extern u8 ata_dummy_irq_ack(struct ata_port *ap, unsigned int chk_drq);
 


