From: Hannes Reinecke <hare@suse.de>
Subject: [PATCH 5/6] libata-eh: decode all taskfile protocols
Date: Mon, 20 Jun 2016 13:39:15 +0200
Message-ID: <1466422756-126637-6-git-send-email-hare@suse.de>
References: <1466422756-126637-1-git-send-email-hare@suse.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35420 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754690AbcFTLyM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 20 Jun 2016 07:54:12 -0400
In-Reply-To: <1466422756-126637-1-git-send-email-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Damien Le Moal <damien.lemoal@hgst.com>, linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>

Some taskfile protocol values where missing in ata_eh_link_report().

Signed-off-by: Hannes Reinecke <hare@suse.de>
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
1.8.5.6

