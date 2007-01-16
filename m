From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Subject: [PATCH 1/4] libata.h: add another IRQ calls
Date: Tue, 16 Jan 2007 19:46:07 +0900
Message-ID: <200701161045.l0GAjwNk009593@toshiba.co.jp>
Mime-Version: 1.0
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from inet-tsb5.toshiba.co.jp ([202.33.96.24]:36574 "EHLO
	inet-tsb5.toshiba.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058AbXAPKqC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Jan 2007 05:46:02 -0500
Received: from tsb-wall.toshiba.co.jp ([133.199.160.134])
	by inet-tsb5.toshiba.co.jp  with ESMTP id l0GAjxbY016548
	for <linux-ide@vger.kernel.org>; Tue, 16 Jan 2007 19:45:59 +0900 (JST)
Received: (from root@localhost)
	by tsb-wall.toshiba.co.jp  id l0GAjxkx021380
	for linux-ide@vger.kernel.org; Tue, 16 Jan 2007 19:45:59 +0900 (JST)
Received: from mx11.toshiba.co.jp (localhost [127.0.0.1])
	by ovp1.toshiba.co.jp  with ESMTP id l0GAjwC3018669
	for <linux-ide@vger.kernel.org>; Tue, 16 Jan 2007 19:45:59 +0900 (JST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org, kou.ishizaki@toshiba.co.jp, benh@kernel.crashing.org, arnd@arndb.de, paulus@samba.org, linas@austin.ibm.com, jeff@garzik.org, alan@lxorguk.ukuu.org.uk

Two IRQ calls are added in ata_port_operations.
- irq_on() is used to enable interrupts. 
- irq_ack() is used to acknowledge a device interrupt.

And there are additional function declarations which are
used in pata_scc.c.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
---

--- linux-2.6.20-rc4/include/linux/libata.h.orig	2007-01-17 01:46:12.000000000 +0900
+++ linux-2.6.20-rc4/include/linux/libata.h	2007-01-17 02:14:57.000000000 +0900
@@ -638,6 +638,8 @@ struct ata_port_operations {
 
 	irq_handler_t irq_handler;
 	void (*irq_clear) (struct ata_port *);
+	u8 (*irq_on) (struct ata_port *);
+	u8 (*irq_ack) (struct ata_port *ap, unsigned int chk_drq);
 
 	u32 (*scr_read) (struct ata_port *ap, unsigned int sc_reg);
 	void (*scr_write) (struct ata_port *ap, unsigned int sc_reg,
@@ -761,6 +763,9 @@ extern void ata_port_queue_task(struct a
 extern u32 ata_wait_register(void __iomem *reg, u32 mask, u32 val,
 			     unsigned long interval_msec,
 			     unsigned long timeout_msec);
+unsigned int ata_dev_try_classify(struct ata_port *, unsigned int, u8 *);
+struct ata_probe_ent *ata_probe_ent_alloc(struct device *,
+					  const struct ata_port_info *);
 
 /*
  * Default driver ops implementations
