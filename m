From: Mark Salter <msalter@redhat.com>
Subject: [PATCH] Support slave devices on SCH PATA controller
Date: Wed, 15 Oct 2008 13:42:57 -0400
Message-ID: <1224092577.6065.8.camel@deneb.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:51930 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752650AbYJORm7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Oct 2008 13:42:59 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: alek.du@intel.com
Cc: linux-ide@vger.kernel.org


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


