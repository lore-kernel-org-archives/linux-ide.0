From: Jack Williams <jacwil014@gmail.com>
Subject: [PATCH] [BUG] libata: NULL pointer panic in ata_eh_link_report()
Date: Thu, 22 Jan 2015 16:21:54 -0800
Message-ID: <1421972514-2034-1-git-send-email-jacwil014@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35994 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752651AbbAWIWv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Jan 2015 03:22:51 -0500
Received: by mail-pa0-f66.google.com with SMTP id kq14so5283313pab.1
        for <linux-ide@vger.kernel.org>; Fri, 23 Jan 2015 00:22:50 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Jack Williams <jacwil014@gmail.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>

I've been trying to boot the linux-next tree and my system is getting a
kernel panic from an attempt to dereference a NULL pointer inside
ata_eh_link_report(). The following commit introduced the bug.

commit: cbba5b0ee4c6c2fc8b78a21d0900099d480cf2e9

The bug appears when the local variable cdb_len is initialized with
qc->dev->cdb_len without first checking qc->flags for ATA_QCFLAG_FAILED.
For whatever reason, qc->dev is NULL when it runs through my
motherboard's Marvell 91xx Config ATA device.

Signed-off-by: Jack Williams <jacwil014@gmail.com>
---
 drivers/ata/libata-eh.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 7478c8d0c2cb..b09efdd6d125 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2481,16 +2481,18 @@ static void ata_eh_link_report(struct ata_link *link)
 	for (tag = 0; tag < ATA_MAX_QUEUE; tag++) {
 		struct ata_queued_cmd *qc = __ata_qc_from_tag(ap, tag);
 		struct ata_taskfile *cmd = &qc->tf, *res = &qc->result_tf;
 		const u8 *cdb = qc->cdb;
-		size_t cdb_len = qc->dev->cdb_len;
+		size_t cdb_len;
 		char data_buf[20] = "";
 		char cdb_buf[70] = "";
 
 		if (!(qc->flags & ATA_QCFLAG_FAILED) ||
 		    ata_dev_phys_link(qc->dev) != link || !qc->err_mask)
 			continue;
 
+		cdb_len = qc->dev->cdb_len;
+
 		if (qc->dma_dir != DMA_NONE) {
 			static const char *dma_str[] = {
 				[DMA_BIDIRECTIONAL]	= "bidi",
 				[DMA_TO_DEVICE]		= "out",
-- 
2.0.5

