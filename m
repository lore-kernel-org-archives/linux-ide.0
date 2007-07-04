From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 2/10] libata: add irq_off
Date: Wed, 04 Jul 2007 16:46:25 +0800
Message-ID: <468B5E61.6000601@tw.ibm.com>
References: <468B5C97.1000803@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:50902 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755323AbXGDIqa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Jul 2007 04:46:30 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l648kTYe010538
	for <linux-ide@vger.kernel.org>; Wed, 4 Jul 2007 04:46:29 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l648kT4J261188
	for <linux-ide@vger.kernel.org>; Wed, 4 Jul 2007 02:46:29 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l648kSvm003796
	for <linux-ide@vger.kernel.org>; Wed, 4 Jul 2007 02:46:29 -0600
In-Reply-To: <468B5C97.1000803@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>

Patch 2/10:
  Currently there is ->irq_on but no ->irq_off.
Turning irq off is done via altering the nIEN bit of qc->tf, together with tf_load().

This patch adds ->irq_off for symmetry.
tf_load() and ata_qc_set_polling() will be fixed/removed in later patches.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---

diff -Nrup 01_remove_leftover_irqon/drivers/ata/libata-core.c 02_add_irq_off/drivers/ata/libata-core.c
--- 01_remove_leftover_irqon/drivers/ata/libata-core.c	2007-07-04 11:43:30.000000000 +0800
+++ 02_add_irq_off/drivers/ata/libata-core.c	2007-07-04 11:57:33.000000000 +0800
@@ -6901,6 +6901,8 @@ EXPORT_SYMBOL_GPL(ata_eh_qc_retry);
 EXPORT_SYMBOL_GPL(ata_do_eh);
 EXPORT_SYMBOL_GPL(ata_irq_on);
 EXPORT_SYMBOL_GPL(ata_dummy_irq_on);
+EXPORT_SYMBOL_GPL(ata_irq_off);
+EXPORT_SYMBOL_GPL(ata_dummy_irq_off);
 EXPORT_SYMBOL_GPL(ata_irq_ack);
 EXPORT_SYMBOL_GPL(ata_dummy_irq_ack);
 EXPORT_SYMBOL_GPL(ata_dev_try_classify);
diff -Nrup 01_remove_leftover_irqon/drivers/ata/libata-sff.c 02_add_irq_off/drivers/ata/libata-sff.c
--- 01_remove_leftover_irqon/drivers/ata/libata-sff.c	2007-07-04 11:26:30.000000000 +0800
+++ 02_add_irq_off/drivers/ata/libata-sff.c	2007-07-04 11:57:33.000000000 +0800
@@ -67,6 +67,39 @@ u8 ata_irq_on(struct ata_port *ap)
 u8 ata_dummy_irq_on (struct ata_port *ap) 	{ return 0; }
 
 /**
+ *	ata_irq_off - Disable interrupts on a port.
+ *	@ap: Port on which interrupts are disabled.
+ *
+ *	Disable interrupts on a legacy IDE device using MMIO or PIO,
+ *	wait for idle, clear any pending interrupts.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
+u8 ata_irq_off(struct ata_port *ap)
+{
+	struct ata_ioports *ioaddr = &ap->ioaddr;
+	u8 tmp;
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
+	tmp = ata_wait_idle(ap);
+
+	ap->ops->irq_clear(ap);
+
+	return tmp;
+}
+
+u8 ata_dummy_irq_off (struct ata_port *ap) 	{ return 0; }
+
+/**
  *	ata_irq_ack - Acknowledge a device interrupt.
  *	@ap: Port on which interrupts are enabled.
  *
diff -Nrup 01_remove_leftover_irqon/drivers/ata/libata.h 02_add_irq_off/drivers/ata/libata.h
--- 01_remove_leftover_irqon/drivers/ata/libata.h	2007-07-04 11:26:30.000000000 +0800
+++ 02_add_irq_off/drivers/ata/libata.h	2007-07-04 11:57:33.000000000 +0800
@@ -156,7 +156,5 @@ extern void ata_port_wait_eh(struct ata_
 extern void ata_qc_schedule_eh(struct ata_queued_cmd *qc);
 
 /* libata-sff.c */
-extern u8 ata_irq_on(struct ata_port *ap);
-
 
 #endif /* __LIBATA_H__ */
diff -Nrup 01_remove_leftover_irqon/include/linux/libata.h 02_add_irq_off/include/linux/libata.h
--- 01_remove_leftover_irqon/include/linux/libata.h	2007-07-04 11:26:45.000000000 +0800
+++ 02_add_irq_off/include/linux/libata.h	2007-07-04 11:57:33.000000000 +0800
@@ -597,6 +597,7 @@ struct ata_port_operations {
 	irq_handler_t irq_handler;
 	void (*irq_clear) (struct ata_port *);
 	u8 (*irq_on) (struct ata_port *);
+	u8 (*irq_off) (struct ata_port *);
 	u8 (*irq_ack) (struct ata_port *ap, unsigned int chk_drq);
 
 	u32 (*scr_read) (struct ata_port *ap, unsigned int sc_reg);
@@ -804,6 +805,8 @@ extern struct ata_device *ata_dev_pair(s
 extern int ata_do_set_mode(struct ata_port *ap, struct ata_device **r_failed_dev);
 extern u8 ata_irq_on(struct ata_port *ap);
 extern u8 ata_dummy_irq_on(struct ata_port *ap);
+extern u8 ata_irq_off(struct ata_port *ap);
+extern u8 ata_dummy_irq_off(struct ata_port *ap);
 extern u8 ata_irq_ack(struct ata_port *ap, unsigned int chk_drq);
 extern u8 ata_dummy_irq_ack(struct ata_port *ap, unsigned int chk_drq);
 


