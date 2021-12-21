Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B63C433EF
	for <linux-ide@archiver.kernel.org>; Tue, 21 Dec 2021 07:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbhLUHXM (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 21 Dec 2021 02:23:12 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52636 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235152AbhLUHWy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Dec 2021 02:22:54 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E13A42199C;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1640071362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ut/ah42UTwb+ziXAFZPzVFlysIjBN5Kvjj2i5p4Lu1A=;
        b=Q7KFF5cHN8xzRoxM4PvRFl6XIQcaxTxJGWBEz+A+Ge8gvWW/SEZjU2A80dpAvEtBgSnGMy
        6tBUIM2+9A76My/p6d9qE9jmsBnfSNX5CEFsWaTOQVKRMC1QxMmlYAWljU0SsybhCRbcIm
        Wq0DQJf5Q5jG7+Py6NcxvxHK6amFzRc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1640071362;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ut/ah42UTwb+ziXAFZPzVFlysIjBN5Kvjj2i5p4Lu1A=;
        b=g9Mo7c9WzbOnD1DUxgLqy23+nuaOOrUh0M9Az23bDT5O4DnCkKI6g1FesrCzj7rMo6SvH0
        gSuRmylQ1hs1qrCA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id CF3E3A3BC4;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id CC73F51923F8; Tue, 21 Dec 2021 08:22:42 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 67/68] sata_dwc_460ex: remove 'check_status' argument
Date:   Tue, 21 Dec 2021 08:21:30 +0100
Message-Id: <20211221072131.46673-68-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211221072131.46673-1-hare@suse.de>
References: <20211221072131.46673-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Remove the 'check_status' argument from sata_dwc_qc_complete() and
sata_dwc_dma_xfer_complete() as it has no functionality.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/sata_dwc_460ex.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 448d88cf1b38..319998dcbe58 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -182,9 +182,8 @@ enum {
  * Prototypes
  */
 static void sata_dwc_bmdma_start_by_tag(struct ata_queued_cmd *qc, u8 tag);
-static int sata_dwc_qc_complete(struct ata_port *ap, struct ata_queued_cmd *qc,
-				u32 check_status);
-static void sata_dwc_dma_xfer_complete(struct ata_port *ap, u32 check_status);
+static int sata_dwc_qc_complete(struct ata_port *ap, struct ata_queued_cmd *qc);
+static void sata_dwc_dma_xfer_complete(struct ata_port *ap);
 static void sata_dwc_clear_dmacr(struct sata_dwc_device_port *hsdevp, u8 tag);
 
 #ifdef CONFIG_SATA_DWC_OLD_DMA
@@ -324,7 +323,7 @@ static void dma_dwc_xfer_done(void *hsdev_instance)
 	}
 
 	if ((hsdevp->dma_interrupt_count % 2) == 0)
-		sata_dwc_dma_xfer_complete(ap, 1);
+		sata_dwc_dma_xfer_complete(ap);
 
 	spin_unlock_irqrestore(&host->lock, flags);
 }
@@ -556,7 +555,7 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
 
 		if (status & ATA_ERR) {
 			dev_dbg(ap->dev, "interrupt ATA_ERR (0x%x)\n", status);
-			sata_dwc_qc_complete(ap, qc, 1);
+			sata_dwc_qc_complete(ap, qc);
 			handled = 1;
 			goto DONE;
 		}
@@ -581,13 +580,13 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
 			}
 
 			if ((hsdevp->dma_interrupt_count % 2) == 0)
-				sata_dwc_dma_xfer_complete(ap, 1);
+				sata_dwc_dma_xfer_complete(ap);
 		} else if (ata_is_pio(qc->tf.protocol)) {
 			ata_sff_hsm_move(ap, qc, status, 0);
 			handled = 1;
 			goto DONE;
 		} else {
-			if (unlikely(sata_dwc_qc_complete(ap, qc, 1)))
+			if (unlikely(sata_dwc_qc_complete(ap, qc)))
 				goto DRVSTILLBUSY;
 		}
 
@@ -647,7 +646,7 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
 		if (status & ATA_ERR) {
 			dev_dbg(ap->dev, "%s ATA_ERR (0x%x)\n", __func__,
 				status);
-			sata_dwc_qc_complete(ap, qc, 1);
+			sata_dwc_qc_complete(ap, qc);
 			handled = 1;
 			goto DONE;
 		}
@@ -662,9 +661,9 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
 				dev_warn(ap->dev, "%s: DMA not pending?\n",
 					__func__);
 			if ((hsdevp->dma_interrupt_count % 2) == 0)
-				sata_dwc_dma_xfer_complete(ap, 1);
+				sata_dwc_dma_xfer_complete(ap);
 		} else {
-			if (unlikely(sata_dwc_qc_complete(ap, qc, 1)))
+			if (unlikely(sata_dwc_qc_complete(ap, qc)))
 				goto STILLBUSY;
 		}
 		continue;
@@ -719,7 +718,7 @@ static void sata_dwc_clear_dmacr(struct sata_dwc_device_port *hsdevp, u8 tag)
 	}
 }
 
-static void sata_dwc_dma_xfer_complete(struct ata_port *ap, u32 check_status)
+static void sata_dwc_dma_xfer_complete(struct ata_port *ap)
 {
 	struct ata_queued_cmd *qc;
 	struct sata_dwc_device_port *hsdevp = HSDEVP_FROM_AP(ap);
@@ -742,15 +741,14 @@ static void sata_dwc_dma_xfer_complete(struct ata_port *ap, u32 check_status)
 		}
 
 		hsdevp->dma_pending[tag] = SATA_DWC_DMA_PENDING_NONE;
-		sata_dwc_qc_complete(ap, qc, check_status);
+		sata_dwc_qc_complete(ap, qc);
 		ap->link.active_tag = ATA_TAG_POISON;
 	} else {
-		sata_dwc_qc_complete(ap, qc, check_status);
+		sata_dwc_qc_complete(ap, qc);
 	}
 }
 
-static int sata_dwc_qc_complete(struct ata_port *ap, struct ata_queued_cmd *qc,
-				u32 check_status)
+static int sata_dwc_qc_complete(struct ata_port *ap, struct ata_queued_cmd *qc)
 {
 	u8 status = 0;
 	u32 mask = 0x0;
@@ -758,7 +756,6 @@ static int sata_dwc_qc_complete(struct ata_port *ap, struct ata_queued_cmd *qc,
 	struct sata_dwc_device *hsdev = HSDEV_FROM_AP(ap);
 	struct sata_dwc_device_port *hsdevp = HSDEVP_FROM_AP(ap);
 	hsdev->sactive_queued = 0;
-	dev_dbg(ap->dev, "%s checkstatus? %x\n", __func__, check_status);
 
 	if (hsdevp->dma_pending[tag] == SATA_DWC_DMA_PENDING_TX)
 		dev_err(ap->dev, "TX DMA PENDING\n");
-- 
2.29.2

