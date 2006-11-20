From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: print cdb[0] in failed qc report
Date: Mon, 20 Nov 2006 16:05:34 +0900
Message-ID: <20061120070534.GN2184@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:4537 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S933982AbWKTHFq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 20 Nov 2006 02:05:46 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2236864nfa
        for <linux-ide@vger.kernel.org>; Sun, 19 Nov 2006 23:05:45 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Print cdb[0] in failed qc report.

Signed-off-by: Tejun Heo <htejun@gmail.com>

--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1452,14 +1452,15 @@ static void ata_eh_report(struct ata_por
 
 		ata_dev_printk(qc->dev, KERN_ERR,
 			"cmd %02x/%02x:%02x:%02x:%02x:%02x/%02x:%02x:%02x:%02x:%02x/%02x "
-			"tag %d data %u %s\n         "
+			"tag %d cdb 0x%x data %u %s\n         "
 			"res %02x/%02x:%02x:%02x:%02x:%02x/%02x:%02x:%02x:%02x:%02x/%02x "
 			"Emask 0x%x (%s)\n",
 			cmd->command, cmd->feature, cmd->nsect,
 			cmd->lbal, cmd->lbam, cmd->lbah,
 			cmd->hob_feature, cmd->hob_nsect,
 			cmd->hob_lbal, cmd->hob_lbam, cmd->hob_lbah,
-			cmd->device, qc->tag, nbytes, dma_str[qc->dma_dir],
+			cmd->device, qc->tag, qc->cdb[0], nbytes,
+			dma_str[qc->dma_dir],
 			res->command, res->feature, res->nsect,
 			res->lbal, res->lbam, res->lbah,
 			res->hob_feature, res->hob_nsect,
