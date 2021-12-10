Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D847CC433FE
	for <linux-ide@archiver.kernel.org>; Fri, 10 Dec 2021 07:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbhLJHdo (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 10 Dec 2021 02:33:44 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:34982 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237687AbhLJHdZ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 10 Dec 2021 02:33:25 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6A7072177B;
        Fri, 10 Dec 2021 07:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639121359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Inm63ywFuHs4nmOBAy8Oxnn2+qXNyctqOw0suHNHaY=;
        b=Vk31mbHUYBLs5LMkX/mcGQZJ8WM9d+oTECZAeR1bpLdE3vv4w4vo7J0lkFjKEemcwjJPa4
        EIXwdUsB6bDRBdeyrnIS/u2v0W6yJdoZGKOdwSUyYBAYekSAA2NEh48/XBR2GN8lhZgbRF
        jU6PLOqI9fz7wKQ+PGX9KXUttRo7Pe4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639121359;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Inm63ywFuHs4nmOBAy8Oxnn2+qXNyctqOw0suHNHaY=;
        b=6iGR+HZWBXs9sZpqR8fR2gZzN4udbSqeserWtuncXY2sKrzjMI8sShVoeZG/VRuQ+4S35L
        Q2TngE6nvdo7HNBA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 6581CA3BD6;
        Fri, 10 Dec 2021 07:29:19 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 63A0151920A7; Fri, 10 Dec 2021 08:29:19 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 67/68] sata_dwc_460ex: remove 'checkstatus' argument
Date:   Fri, 10 Dec 2021 08:29:04 +0100
Message-Id: <20211210072905.15666-68-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211210072905.15666-1-hare@suse.de>
References: <20211210072905.15666-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Remove the 'checkstatus' argument from sata_dwc_qc_complete() and
sata_dwc_dma_xfer_complete() as it has no functionality.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/sata_dwc_460ex.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 78618b3efcbc..e1024e062cc5 100644
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
 static void sata_dwc_port_stop(struct ata_port *ap);
 static void sata_dwc_clear_dmacr(struct sata_dwc_device_port *hsdevp, u8 tag);
 
@@ -326,7 +325,7 @@ static void dma_dwc_xfer_done(void *hsdev_instance)
 	}
 
 	if ((hsdevp->dma_interrupt_count % 2) == 0)
-		sata_dwc_dma_xfer_complete(ap, 1);
+		sata_dwc_dma_xfer_complete(ap);
 
 	spin_unlock_irqrestore(&host->lock, flags);
 }
@@ -558,7 +557,7 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
 
 		if (status & ATA_ERR) {
 			dev_dbg(ap->dev, "interrupt ATA_ERR (0x%x)\n", status);
-			sata_dwc_qc_complete(ap, qc, 1);
+			sata_dwc_qc_complete(ap, qc);
 			handled = 1;
 			goto DONE;
 		}
@@ -583,13 +582,13 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
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
 
@@ -649,7 +648,7 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
 		if (status & ATA_ERR) {
 			dev_dbg(ap->dev, "%s ATA_ERR (0x%x)\n", __func__,
 				status);
-			sata_dwc_qc_complete(ap, qc, 1);
+			sata_dwc_qc_complete(ap, qc);
 			handled = 1;
 			goto DONE;
 		}
@@ -664,9 +663,9 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
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
@@ -721,7 +720,7 @@ static void sata_dwc_clear_dmacr(struct sata_dwc_device_port *hsdevp, u8 tag)
 	}
 }
 
-static void sata_dwc_dma_xfer_complete(struct ata_port *ap, u32 check_status)
+static void sata_dwc_dma_xfer_complete(struct ata_port *ap)
 {
 	struct ata_queued_cmd *qc;
 	struct sata_dwc_device_port *hsdevp = HSDEVP_FROM_AP(ap);
@@ -744,15 +743,14 @@ static void sata_dwc_dma_xfer_complete(struct ata_port *ap, u32 check_status)
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
@@ -760,7 +758,6 @@ static int sata_dwc_qc_complete(struct ata_port *ap, struct ata_queued_cmd *qc,
 	struct sata_dwc_device *hsdev = HSDEV_FROM_AP(ap);
 	struct sata_dwc_device_port *hsdevp = HSDEVP_FROM_AP(ap);
 	hsdev->sactive_queued = 0;
-	dev_dbg(ap->dev, "%s checkstatus? %x\n", __func__, check_status);
 
 	if (hsdevp->dma_pending[tag] == SATA_DWC_DMA_PENDING_TX)
 		dev_err(ap->dev, "TX DMA PENDING\n");
-- 
2.29.2

