From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: report protocol and full CDB on error
Date: Wed, 28 Nov 2007 23:16:09 +0900
Message-ID: <474D7829.5040303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:52204 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753238AbXK1OQP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Nov 2007 09:16:15 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1219169rvb
        for <linux-ide@vger.kernel.org>; Wed, 28 Nov 2007 06:16:15 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Protocol and CDB allocation size field are important in determining
what went wrong with ATAPI commands.  Report them on failure.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
This one is for #upstream-fixes.  Thanks.

 drivers/ata/libata-eh.c |   42 +++++++++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 0dac69d..e6605f0 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1850,30 +1850,54 @@ static void ata_eh_link_report(struct ata_link *link)
 		  ehc->i.serror & SERR_DEV_XCHG ? "DevExch " : "");
 
 	for (tag = 0; tag < ATA_MAX_QUEUE; tag++) {
-		static const char *dma_str[] = {
-			[DMA_BIDIRECTIONAL]	= "bidi",
-			[DMA_TO_DEVICE]		= "out",
-			[DMA_FROM_DEVICE]	= "in",
-			[DMA_NONE]		= "",
-		};
 		struct ata_queued_cmd *qc = __ata_qc_from_tag(ap, tag);
 		struct ata_taskfile *cmd = &qc->tf, *res = &qc->result_tf;
+		const u8 *cdb = qc->cdb;
+		char data_buf[20] = "";
+		char cdb_buf[70] = "";
 
 		if (!(qc->flags & ATA_QCFLAG_FAILED) ||
 		    qc->dev->link != link || !qc->err_mask)
 			continue;
 
+		if (qc->dma_dir != DMA_NONE) {
+			static const char *dma_str[] = {
+				[DMA_BIDIRECTIONAL]	= "bidi",
+				[DMA_TO_DEVICE]		= "out",
+				[DMA_FROM_DEVICE]	= "in",
+			};
+			static const char *prot_str[] = {
+				[ATA_PROT_PIO]		= "pio",
+				[ATA_PROT_DMA]		= "dma",
+				[ATA_PROT_NCQ]		= "ncq",
+				[ATA_PROT_ATAPI]	= "pio",
+				[ATA_PROT_ATAPI_DMA]	= "dma",
+			};
+
+			snprintf(data_buf, sizeof(data_buf), " %s %u %s",
+				 prot_str[qc->tf.protocol], qc->nbytes,
+				 dma_str[qc->dma_dir]);
+		}
+
+		if (is_atapi_taskfile(&qc->tf))
+			snprintf(cdb_buf, sizeof(cdb_buf),
+				 "cdb %02x %02x %02x %02x %02x %02x %02x %02x  "
+				 "%02x %02x %02x %02x %02x %02x %02x %02x\n         ",
+				 cdb[0], cdb[1], cdb[2], cdb[3],
+				 cdb[4], cdb[5], cdb[6], cdb[7],
+				 cdb[8], cdb[9], cdb[10], cdb[11],
+				 cdb[12], cdb[13], cdb[14], cdb[15]);
+
 		ata_dev_printk(qc->dev, KERN_ERR,
 			"cmd %02x/%02x:%02x:%02x:%02x:%02x/%02x:%02x:%02x:%02x:%02x/%02x "
-			"tag %d cdb 0x%x data %u %s\n         "
+			"tag %d%s\n         %s"
 			"res %02x/%02x:%02x:%02x:%02x:%02x/%02x:%02x:%02x:%02x:%02x/%02x "
 			"Emask 0x%x (%s)%s\n",
 			cmd->command, cmd->feature, cmd->nsect,
 			cmd->lbal, cmd->lbam, cmd->lbah,
 			cmd->hob_feature, cmd->hob_nsect,
 			cmd->hob_lbal, cmd->hob_lbam, cmd->hob_lbah,
-			cmd->device, qc->tag, qc->cdb[0], qc->nbytes,
-			dma_str[qc->dma_dir],
+			cmd->device, qc->tag, data_buf, cdb_buf,
 			res->command, res->feature, res->nsect,
 			res->lbal, res->lbam, res->lbah,
 			res->hob_feature, res->hob_nsect,
