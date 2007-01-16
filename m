From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Subject: [PATCH 3/4] libata-sff.c: add another IRQ calls
Date: Tue, 16 Jan 2007 19:46:23 +0900
Message-ID: <200701161046.l0GAkE3s029370@toshiba.co.jp>
Mime-Version: 1.0
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from imx12.toshiba.co.jp ([61.202.160.132]:61903 "EHLO
	imx12.toshiba.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059AbXAPKqS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Jan 2007 05:46:18 -0500
Received: from wall11.toshiba.co.jp (wall11 [133.199.90.149])
	by imx12.toshiba.co.jp  with ESMTP id l0GAkHoR011735
	for <linux-ide@vger.kernel.org>; Tue, 16 Jan 2007 19:46:17 +0900 (JST)
Received: (from root@localhost)
	by wall11.toshiba.co.jp  id l0GAkGnc024927
	for linux-ide@vger.kernel.org; Tue, 16 Jan 2007 19:46:16 +0900 (JST)
Received: from mx.toshiba.co.jp (localhost [127.0.0.1])
	by ovp11.toshiba.co.jp  with ESMTP id l0GAkEYG021782
	for <linux-ide@vger.kernel.org>; Tue, 16 Jan 2007 19:46:15 +0900 (JST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org, kou.ishizaki@toshiba.co.jp, benh@kernel.crashing.org, arnd@arndb.de, paulus@samba.org, linas@austin.ibm.com, jeff@garzik.org, alan@lxorguk.ukuu.org.uk

When enabling IRQ, ap->ops->irq_on is checked.
Because most drivers can use ata_irq_on() as is, this
patch allows ap->ops->irq_on to be NULL.
If it is NULL, ata_irq_on() are used.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
---

--- linux-2.6.20-rc4/drivers/ata/libata-sff.c.orig	2007-01-17 01:45:56.000000000 +0900
+++ linux-2.6.20-rc4/drivers/ata/libata-sff.c	2007-01-17 02:16:00.000000000 +0900
@@ -724,8 +724,12 @@ void ata_bmdma_thaw(struct ata_port *ap)
 	/* clear & re-enable interrupts */
 	ata_chk_status(ap);
 	ap->ops->irq_clear(ap);
-	if (ap->ioaddr.ctl_addr)	/* FIXME: hack. create a hook instead */
-		ata_irq_on(ap);
+	if (ap->ioaddr.ctl_addr) {	/* FIXME: hack. create a hook instead */
+		if (ap->ops->irq_on)
+			ap->ops->irq_on(ap);
+		else
+			ata_irq_on(ap);
+	}
 }
 
 /**

