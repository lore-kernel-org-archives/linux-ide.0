From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] sata_sil: add controller unplug detection in sil_interrupt()
Date: Mon, 12 Jun 2006 14:18:51 +0900
Message-ID: <20060612051851.GF9166@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:43915 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751333AbWFLFS6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jun 2006 01:18:58 -0400
Received: by py-out-1112.google.com with SMTP id x31so1575855pye
        for <linux-ide@vger.kernel.org>; Sun, 11 Jun 2006 22:18:58 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Short-circuit interrupt handling if BMDMA2 is reported as 0xffffffff
indicating device removal.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

82e7a4a56c55b10bab7fd61a5a3c06131e73786d
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index 00906ab..611bf59 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -416,7 +416,8 @@ static irqreturn_t sil_interrupt(int irq
 		if (unlikely(!ap || ap->flags & ATA_FLAG_DISABLED))
 			continue;
 
-		if (!(bmdma2 & (SIL_DMA_COMPLETE | SIL_DMA_SATA_IRQ)))
+		if (bmdma2 == 0xffffffff ||
+		    !(bmdma2 & (SIL_DMA_COMPLETE | SIL_DMA_SATA_IRQ)))
 			continue;
 
 		sil_host_intr(ap, bmdma2);
-- 
1.3.2

