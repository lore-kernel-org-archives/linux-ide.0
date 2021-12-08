Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEC2C433EF
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhLHQgo (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:36:44 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:40676 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237014AbhLHQge (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:36:34 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 98C3F21763;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HiZmv/QvahwRXoRBlxUFqBUStxno1ZwdMuCEj4y1jZ4=;
        b=Wb0Kujg5wGuFC4PFEwIF2b4j1OvNrzMj8pcYJEy1d3yzU3EebXHu7N7ljevoJOQ3vS29X0
        IknEyBkA+sKUbPdw4dscxtOkL7El8U2HxEDY4uOXQwF7uxJjx6LW1EwPsujuuZ1YCWqOl4
        SGuIvpgmTK0smcZUdUtJT4pIRAaOrnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981180;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HiZmv/QvahwRXoRBlxUFqBUStxno1ZwdMuCEj4y1jZ4=;
        b=Ibo/BmHvSWlmZ/5dPc5g64ka20IZQCbnB4j6xddWGQg9y2Da7i1zdAp9RQ0+oiFi6lill4
        2T0VHgGsX87HG+AQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 951D9A3BB3;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 919B45191F9D; Wed,  8 Dec 2021 17:33:00 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 32/73] pdc_adma: Drop pointless VPRINTK() calls and convert the remaining ones
Date:   Wed,  8 Dec 2021 17:32:14 +0100
Message-Id: <20211208163255.114660-33-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211208163255.114660-1-hare@suse.de>
References: <20211208163255.114660-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Drop pointless VPRINTK() calls for entering and existing interrupt
routines and convert the remaining calls to dev_dbg().

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/pdc_adma.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/ata/pdc_adma.c b/drivers/ata/pdc_adma.c
index 2c910c4cd4de..5d6f460b2356 100644
--- a/drivers/ata/pdc_adma.c
+++ b/drivers/ata/pdc_adma.c
@@ -284,9 +284,6 @@ static int adma_fill_sg(struct ata_queued_cmd *qc)
 		*(__le32 *)(buf + i) =
 			(pFLAGS & pEND) ? 0 : cpu_to_le32(pp->pkt_dma + i + 4);
 		i += 4;
-
-		VPRINTK("PRD[%u] = (0x%lX, 0x%X)\n", i/4,
-					(unsigned long)addr, len);
 	}
 
 	if (likely(last_buf))
@@ -302,8 +299,6 @@ static enum ata_completion_errors adma_qc_prep(struct ata_queued_cmd *qc)
 	u32 pkt_dma = (u32)pp->pkt_dma;
 	int i = 0;
 
-	VPRINTK("ENTER\n");
-
 	adma_enter_reg_mode(qc->ap);
 	if (qc->tf.protocol != ATA_PROT_DMA)
 		return AC_ERR_OK;
@@ -379,8 +374,6 @@ static inline void adma_packet_start(struct ata_queued_cmd *qc)
 	struct ata_port *ap = qc->ap;
 	void __iomem *chan = ADMA_PORT_REGS(ap);
 
-	VPRINTK("ENTER, ap %p\n", ap);
-
 	/* fire up the ADMA engine */
 	writew(aPIOMD4 | aGO, chan + ADMA_CONTROL);
 }
@@ -502,14 +495,10 @@ static irqreturn_t adma_intr(int irq, void *dev_instance)
 	struct ata_host *host = dev_instance;
 	unsigned int handled = 0;
 
-	VPRINTK("ENTER\n");
-
 	spin_lock(&host->lock);
 	handled  = adma_intr_pkt(host) | adma_intr_mmio(host);
 	spin_unlock(&host->lock);
 
-	VPRINTK("EXIT\n");
-
 	return IRQ_RETVAL(handled);
 }
 
-- 
2.29.2

