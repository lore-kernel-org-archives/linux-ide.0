From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] sata_sil24: kill unused local variable idx in sil24_fill_sg()
Date: Mon, 26 Feb 2007 16:11:00 +0900
Message-ID: <20070226071100.GC20322@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.234]:4466 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933781AbXBZHLD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Feb 2007 02:11:03 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1174825nze
        for <linux-ide@vger.kernel.org>; Sun, 25 Feb 2007 23:11:02 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Kill unused local variable idx in sil24_fill_sg().

Spotted by Jeff Garzik.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>

diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index e65e8d5..06413e8 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -647,7 +647,6 @@ static inline void sil24_fill_sg(struct ata_queued_cmd *qc,
 				 struct sil24_sge *sge)
 {
 	struct scatterlist *sg;
-	unsigned int idx = 0;
 
 	ata_for_each_sg(sg, qc) {
 		sge->addr = cpu_to_le64(sg_dma_address(sg));
@@ -656,9 +655,7 @@ static inline void sil24_fill_sg(struct ata_queued_cmd *qc,
 			sge->flags = cpu_to_le32(SGE_TRM);
 		else
 			sge->flags = 0;
-
 		sge++;
-		idx++;
 	}
 }
 
