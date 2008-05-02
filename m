From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 13/13] sata_mv use hweight16() for bit counting
Date: Fri, 02 May 2008 13:56:47 -0400
Message-ID: <481B55DF.1000208@rtr.ca>
References: <481AAF84.40501@rtr.ca> <481AAFB7.4090708@rtr.ca> <481AAFE0.9090101@rtr.ca> <481AB00A.3000206@rtr.ca> <481AB03A.60808@rtr.ca> <481AB070.9050707@rtr.ca> <481AB0A1.3040009@rtr.ca> <481AB0D2.3070103@rtr.ca> <481AB107.701@rtr.ca> <481AB12A.3030102@rtr.ca> <481AB15D.5020201@rtr.ca> <481AB189.3070705@rtr.ca> <481AB1B4.7050508@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1849 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755820AbYEBR4s (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 May 2008 13:56:48 -0400
In-Reply-To: <481AB1B4.7050508@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, Grant Grundler <grundler@google.com>

Some tidying as suggested by Grant Grundler.

Nuke local bit-counting function from sata_mv in favour of using hweight16().
Also add a short explanation for the 15msec timeout used when waiting for empty/idle.

Signed-off-by: Mark Lord <mlord@pobox.com>
---
This makes 13 patches now, rather than just 12.

--- old/drivers/ata/sata_mv.c	2008-05-01 20:29:40.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2008-05-02 13:53:07.000000000 -0400
@@ -903,6 +903,10 @@
 
 	/*
 	 * Wait for the EDMA engine to finish transactions in progress.
+	 * No idea what a good "timeout" value might be, but measurements
+	 * indicate that it often requires hundreds of microseconds
+	 * with two drives in-use.  So we use the 15msec value above
+	 * as a rough guess at what even more drives might require.
 	 */
 	for (i = 0; i < timeout; ++i) {
 		u32 edma_stat = readl(port_mmio + EDMA_STATUS_OFS);
@@ -1640,17 +1644,6 @@
 	return readl(port_mmio + SATA_TESTCTL_OFS) >> 16;
 }
 
-static int mv_count_pmp_links(unsigned int pmp_map)
-{
-	unsigned int link_count = 0;
-
-	while (pmp_map) {
-		link_count += (pmp_map & 1);
-		pmp_map >>= 1;
-	}
-	return link_count;
-}
-
 static void mv_pmp_eh_prep(struct ata_port *ap, unsigned int pmp_map)
 {
 	struct ata_eh_info *ehi;
@@ -1701,7 +1694,7 @@
 		pp->delayed_eh_pmp_map = new_map;
 		mv_pmp_eh_prep(ap, new_map & ~old_map);
 	}
-	failed_links = mv_count_pmp_links(new_map);
+	failed_links = hweight16(new_map);
 
 	ata_port_printk(ap, KERN_INFO, "%s: pmp_map=%04x qc_map=%04x "
 			"failed_links=%d nr_active_links=%d\n",
