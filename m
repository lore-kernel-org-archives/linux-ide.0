From: Mikael Pettersson <mikpe@it.uu.se>
Subject: [PATCH 2.6.22-rc7] sata_sil24: sil24_interrupt() micro-optimisation
Date: Tue, 3 Jul 2007 01:10:25 +0200 (MEST)
Message-ID: <200707022310.l62NAPA7007676@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:52158 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756613AbXGBXKc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 Jul 2007 19:10:32 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

sil24_interrupt() loads host->ports[i] into a local variable,
validates it, and then loads the value again in the call to
sil24_host_intr(). This patch replaces the second load by a
reference to the local variable.

This is safe since no side-effects have occurred since the
initial load. It also improves readability since it makes
it clear that the parameter to sil24_host_intr() is the same
value which was just validated.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

--- linux-2.6.22-rc7/drivers/ata/sata_sil24.c.~1~	2007-07-02 21:41:37.000000000 +0200
+++ linux-2.6.22-rc7/drivers/ata/sata_sil24.c	2007-07-02 23:28:57.000000000 +0200
@@ -888,7 +888,7 @@ static irqreturn_t sil24_interrupt(int i
 		if (status & (1 << i)) {
 			struct ata_port *ap = host->ports[i];
 			if (ap && !(ap->flags & ATA_FLAG_DISABLED)) {
-				sil24_host_intr(host->ports[i]);
+				sil24_host_intr(ap);
 				handled++;
 			} else
 				printk(KERN_ERR DRV_NAME
