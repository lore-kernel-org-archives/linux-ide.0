From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 06/10] libata-eh: decode all taskfile protocols
Date: Thu, 14 Jul 2016 09:05:47 +0900
Message-ID: <1468454751-12466-7-git-send-email-hch@lst.de>
References: <1468454751-12466-1-git-send-email-hch@lst.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:55780 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbcGNAGO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Jul 2016 20:06:14 -0400
In-Reply-To: <1468454751-12466-1-git-send-email-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: hare@suse.com, damien.lemoal@hgst.com, linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>

From: Hannes Reinecke <hare@suse.de>

Some taskfile protocol values where missing in ata_eh_link_report().

Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/ata/libata-eh.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 7832e55..5688b86 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2607,9 +2607,12 @@ static void ata_eh_link_report(struct ata_link *link)
 				[DMA_FROM_DEVICE]	= "in",
 			};
 			static const char *prot_str[] = {
+				[ATA_PROT_UNKNOWN]	= "unknown",
+				[ATA_PROT_NODATA]	= "nodata",
 				[ATA_PROT_PIO]		= "pio",
 				[ATA_PROT_DMA]		= "dma",
 				[ATA_PROT_NCQ]		= "ncq",
+				[ATAPI_PROT_NODATA]	= "nodata",
 				[ATAPI_PROT_PIO]	= "pio",
 				[ATAPI_PROT_DMA]	= "dma",
 			};
-- 
2.1.4

