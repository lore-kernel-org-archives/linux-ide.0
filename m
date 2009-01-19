From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 01/04] sata_mv: fix 8-port timeouts on 508x/6081 chips
Date: Mon, 19 Jan 2009 18:04:37 -0500
Message-ID: <49750705.7010709@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:43418 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751929AbZASXEi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Jan 2009 18:04:38 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, stable@kernel.org

Fix a longstanding bug for the 8-port Marvell Sata controllers (508x/6081),
where accesses to the upper 4 ports would cause lost-interrupts / timeouts
for the lower 4-ports.  With this patch, the 6081 boards should finally be
reliable enough for mainstream use with Linux.

This patch is for 2.6.29, but should also get reviewed/released
for the -stable branches of 2.6.28, 2.6.27, and 2.6.26.

Signed-off-by: Mark Lord <mlord@pobox.com> 
---

Reposting, as I got no response/acknowledgement on the first attempt.

--- old/drivers/ata/sata_mv.c	2009-01-16 11:11:16.000000000 -0500
+++ linux/drivers/ata/sata_mv.c	2009-01-16 11:52:17.000000000 -0500
@@ -883,7 +883,7 @@
 		struct mv_host_priv *hpriv = ap->host->private_data;
 		int hardport = mv_hardport_from_port(ap->port_no);
 		void __iomem *hc_mmio = mv_hc_base_from_port(
-					mv_host_base(ap->host), hardport);
+					mv_host_base(ap->host), ap->port_no);
 		u32 hc_irq_cause, ipending;
 
 		/* clear EDMA event indicators, if any */
