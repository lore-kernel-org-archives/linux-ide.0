From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: improve failed qc reporting
Date: Tue, 14 Nov 2006 22:36:12 +0900
Message-ID: <20061114133612.GC27684@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.200]:23130 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965685AbWKNNgT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Nov 2006 08:36:19 -0500
Received: by nz-out-0102.google.com with SMTP id i11so939916nzi
        for <linux-ide@vger.kernel.org>; Tue, 14 Nov 2006 05:36:19 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Improve failed qc reporting.  The original message didn't include the
actual command nor full error status and it was necessary to
temporarily patch the code to find out exactly which command is
causing problem.  This patch makes EH report full command and result
TFs along with data direction and length.  This change will make bug
reports more useful.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c |   32 +++++++++++++++++++++++++++-----
 1 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 4776488..104836e 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1433,16 +1433,38 @@ static void ata_eh_report(struct ata_por
 	}
 
 	for (tag = 0; tag < ATA_MAX_QUEUE; tag++) {
+		static const char *dma_str[] = {
+			[DMA_BIDIRECTIONAL]	= "bidi",
+			[DMA_TO_DEVICE]		= "out",
+			[DMA_FROM_DEVICE]	= "in",
+			[DMA_NONE]		= "",
+		};
 		struct ata_queued_cmd *qc = __ata_qc_from_tag(ap, tag);
+		struct ata_taskfile *cmd = &qc->tf, *res = &qc->result_tf;
+		unsigned int nbytes;
 
 		if (!(qc->flags & ATA_QCFLAG_FAILED) || !qc->err_mask)
 			continue;
 
-		ata_dev_printk(qc->dev, KERN_ERR, "tag %d cmd 0x%x "
-			       "Emask 0x%x stat 0x%x err 0x%x (%s)\n",
-			       qc->tag, qc->tf.command, qc->err_mask,
-			       qc->result_tf.command, qc->result_tf.feature,
-			       ata_err_string(qc->err_mask));
+		nbytes = qc->nbytes;
+		if (!nbytes)
+			nbytes = qc->nsect << 9;
+
+		ata_dev_printk(qc->dev, KERN_ERR,
+			"cmd %02x/%02x:%02x:%02x:%02x:%02x/%02x:%02x:%02x:%02x:%02x/%02x "
+			"tag %d data %u %s\n         "
+			"res %02x/%02x:%02x:%02x:%02x:%02x/%02x:%02x:%02x:%02x:%02x/%02x "
+			"Emask 0x%x (%s)\n",
+			cmd->command, cmd->feature, cmd->nsect,
+			cmd->lbal, cmd->lbam, cmd->lbah,
+			cmd->hob_feature, cmd->hob_nsect,
+			cmd->hob_lbal, cmd->hob_lbam, cmd->hob_lbah,
+			cmd->device, qc->tag, nbytes, dma_str[qc->dma_dir],
+			res->command, res->feature, res->nsect,
+			res->lbal, res->lbam, res->lbah,
+			res->hob_feature, res->hob_nsect,
+			res->hob_lbal, res->hob_lbam, res->hob_lbah,
+			res->device, qc->err_mask, ata_err_string(qc->err_mask));
 	}
 }
 
-- 
1.4.3.3

