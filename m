From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Subject: [PATCH 2/4] libata-core.c: add another IRQ calls
Date: Tue, 16 Jan 2007 19:46:14 +0900
Message-ID: <200701161046.l0GAk5Go019691@toshiba.co.jp>
Mime-Version: 1.0
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from imx12.toshiba.co.jp ([61.202.160.132]:61894 "EHLO
	imx12.toshiba.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbXAPKqJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Jan 2007 05:46:09 -0500
Received: from wall11.toshiba.co.jp (wall11 [133.199.90.149])
	by imx12.toshiba.co.jp  with ESMTP id l0GAk71i011704
	for <linux-ide@vger.kernel.org>; Tue, 16 Jan 2007 19:46:07 +0900 (JST)
Received: (from root@localhost)
	by wall11.toshiba.co.jp  id l0GAk71C024815
	for linux-ide@vger.kernel.org; Tue, 16 Jan 2007 19:46:07 +0900 (JST)
Received: from mx2.toshiba.co.jp (localhost [127.0.0.1])
	by ovp11.toshiba.co.jp  with ESMTP id l0GAk6Yo021695
	for <linux-ide@vger.kernel.org>; Tue, 16 Jan 2007 19:46:06 +0900 (JST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org, kou.ishizaki@toshiba.co.jp, benh@kernel.crashing.org, arnd@arndb.de, paulus@samba.org, linas@austin.ibm.com, jeff@garzik.org, alan@lxorguk.ukuu.org.uk

When enabling IRQ, ap->ops->irq_on is checked.
Because most drivers can use ata_irq_on() as is, this
patch allows ap->ops->irq_on to be NULL.
If it is NULL, ata_irq_on() are used.

Similarly, ap->ops->irq_ack is checked when acknowledging a IRQ.
If it is NULL, ata_irq_ack() are used.

And this patch exports ata_dev_try_classify(). It is used in
pata_scc.c to reduce the code duplication.
This driver has the copy of ata_std_softreset(), which has
low-level accessors and cannot be used as is.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
---

--- linux-2.6.20-rc4/drivers/ata/libata-core.c.orig	2007-01-17 01:45:44.000000000 +0900
+++ linux-2.6.20-rc4/drivers/ata/libata-core.c	2007-01-17 02:16:48.000000000 +0900
@@ -767,7 +767,7 @@ unsigned int ata_dev_classify(const stru
  *	Device type - %ATA_DEV_ATA, %ATA_DEV_ATAPI or %ATA_DEV_NONE.
  */
 
-static unsigned int
+unsigned int
 ata_dev_try_classify(struct ata_port *ap, unsigned int device, u8 *r_err)
 {
 	struct ata_taskfile tf;
@@ -2754,8 +2754,12 @@ void ata_bus_reset(struct ata_port *ap)
 		ap->device[1].class = ata_dev_try_classify(ap, 1, &err);
 
 	/* re-enable interrupts */
-	if (ap->ioaddr.ctl_addr)	/* FIXME: hack. create a hook instead */
-		ata_irq_on(ap);
+	if (ap->ioaddr.ctl_addr) {	/* FIXME: hack. create a hook instead */
+		if (ap->ops->irq_on)
+			ap->ops->irq_on(ap);
+		else
+			ata_irq_on(ap);
+	}
 
 	/* is double-select really necessary? */
 	if (ap->device[1].class != ATA_DEV_NONE)
@@ -3149,8 +3153,12 @@ void ata_std_postreset(struct ata_port *
 	/* re-enable interrupts */
 	if (!ap->ops->error_handler) {
 		/* FIXME: hack. create a hook instead */
-		if (ap->ioaddr.ctl_addr)
-			ata_irq_on(ap);
+		if (ap->ioaddr.ctl_addr) {
+			if (ap->ops->irq_on)
+				ap->ops->irq_on(ap);
+			else
+				ata_irq_on(ap);
+		}
 	}
 
 	/* is double-select really necessary? */
@@ -4329,7 +4337,10 @@ static void ata_hsm_qc_complete(struct a
 			qc = ata_qc_from_tag(ap, qc->tag);
 			if (qc) {
 				if (likely(!(qc->err_mask & AC_ERR_HSM))) {
-					ata_irq_on(ap);
+					if (ap->ops->irq_on)
+						ap->ops->irq_on(ap);
+					else
+						ata_irq_on(ap);
 					ata_qc_complete(qc);
 				} else
 					ata_port_freeze(ap);
@@ -4345,7 +4356,10 @@ static void ata_hsm_qc_complete(struct a
 	} else {
 		if (in_wq) {
 			spin_lock_irqsave(ap->lock, flags);
-			ata_irq_on(ap);
+			if (ap->ops->irq_on)
+				ap->ops->irq_on(ap);
+			else
+				ata_irq_on(ap);
 			ata_qc_complete(qc);
 			spin_unlock_irqrestore(ap->lock, flags);
 		} else
@@ -5170,7 +5184,10 @@ idle_irq:
 
 #ifdef ATA_IRQ_TRAP
 	if ((ap->stats.idle_irq % 1000) == 0) {
-		ata_irq_ack(ap, 0); /* debug trap */
+		if (ap->ops->irq_ack)
+			ap->ops->irq_ack(ap, 0);
+		else
+			ata_irq_ack(ap, 0); /* debug trap */
 		ata_port_printk(ap, KERN_WARNING, "irq trap\n");
 		return 1;
 	}
@@ -6500,3 +6517,5 @@ EXPORT_SYMBOL_GPL(ata_eh_thaw_port);
 EXPORT_SYMBOL_GPL(ata_eh_qc_complete);
 EXPORT_SYMBOL_GPL(ata_eh_qc_retry);
 EXPORT_SYMBOL_GPL(ata_do_eh);
+EXPORT_SYMBOL_GPL(ata_dev_try_classify);
+EXPORT_SYMBOL_GPL(ata_probe_ent_alloc);
