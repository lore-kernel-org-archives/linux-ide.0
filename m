From: Mark Lord <liml@rtr.ca>
Subject: [PATCH] sata_mv: fix timeouts on lower ports of 508x/6081 chips
Date: Fri, 16 Jan 2009 12:03:02 -0500
Message-ID: <4970BDC6.7020201@rtr.ca>
References: <496D04EB.3060803@rtr.ca> <496E53DD.6040408@gmail.com> <496E61E8.5010602@rtr.ca> <496E72D7.2070206@gmail.com> <496EA53F.7000605@rtr.ca> <496F34BF.5010701@ngs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:40561 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757540AbZAPRDF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Jan 2009 12:03:05 -0500
In-Reply-To: <496F34BF.5010701@ngs.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>
Cc: Artem Bokhan <aptem@ngs.ru>, Harri Olin <harri.olin@gmail.com>, Brian Rademacher <rad@radfiles.net>, Eamonn Hamilton <EAMONN.HAMILTON@saic.com>, stable@kernel.org

Fix a longstanding bug for the 8-port Marvell Sata controllers (508x/6081),
where accesses to the upper 4 ports would cause lost-interrupts / timeouts
for the lower 4-ports.  With this patch, the 6081 boards should finally be
reliable enough for mainstream use with Linux.

This patch is for 2.6.29, but should also get reviewed/released
for the -stable branches of 2.6.28, 2.6.27, and 2.6.26.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- linux-2.6.29-rc1-git6/drivers/ata/sata_mv.c	2009-01-16 11:11:16.000000000 -0500
+++ linux/drivers/ata/sata_mv.c	2009-01-16 11:52:17.000000000 -0500
@@ -883,7 +883,7 @@
 		struct mv_host_priv *hpriv = ap->host->private_data;
 		int hardport = mv_hardport_from_port(ap->port_no);
 		void __iomem *hc_mmio = mv_hc_base_from_port(
-					mv_host_base(ap->host), hardport);
+					mv_host_base(ap->host), ap->port_no);
 		u32 hc_irq_cause, ipending;
 
 		/* clear EDMA event indicators, if any */
