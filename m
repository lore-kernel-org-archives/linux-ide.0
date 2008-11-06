From: Mark Salter <msalter@redhat.com>
Subject: [PATCH] pata_sch slave devices
Date: Thu, 06 Nov 2008 08:03:23 -0500
Message-ID: <1225976603.24291.8.camel@deneb.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:52312 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753486AbYKFNDZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 6 Nov 2008 08:03:25 -0500
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id mA6D3PNm005403
	for <linux-ide@vger.kernel.org>; Thu, 6 Nov 2008 08:03:25 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Jeff Garzik <jgarzik@redhat.com>

I posted this last month, but was prompted to do so again in bz#467457

Add capability flag to support slave devices with pata_sch driver.

Signed-off-by: Mark Salter <msalter@redhat.com>
---
diff --git a/drivers/ata/pata_sch.c b/drivers/ata/pata_sch.c
index c8cc027..6aeeeeb 100644
--- a/drivers/ata/pata_sch.c
+++ b/drivers/ata/pata_sch.c
@@ -83,7 +83,7 @@ static struct ata_port_operations sch_pata_ops = {
 };
 
 static struct ata_port_info sch_port_info = {
-	.flags		= 0,
+	.flags		= ATA_FLAG_SLAVE_POSS,
 	.pio_mask	= ATA_PIO4,   /* pio0-4 */
 	.mwdma_mask	= ATA_MWDMA2, /* mwdma0-2 */
 	.udma_mask	= ATA_UDMA5,  /* udma0-5 */



