Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CFAC4167B
	for <linux-ide@archiver.kernel.org>; Tue, 21 Dec 2021 07:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbhLUHWz (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 21 Dec 2021 02:22:55 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:55906 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbhLUHWo (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Dec 2021 02:22:44 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 157411F3C1;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1640071362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K7czETCP4qVqCLkSpiThqIEvOXTiko0JXVfpJ+OT5Sw=;
        b=z3qbfGBB2TdVb+19w6p7Qf8O3f4cbCtFCrOkYVfuMrpWXKRQgVTSbPl57BAkxBBMdyDIyF
        3FLfZB19AFGqbHtTm1Ukt7nu8cnqnaz3Qoq8Oo5WkRWW15zHdjNkZGA3+fvEoMXCKu0gSN
        xFT3dlJuWgRmwMyYAh5XLhpgIdKxwww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1640071362;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K7czETCP4qVqCLkSpiThqIEvOXTiko0JXVfpJ+OT5Sw=;
        b=V4c2vmujOk5bt8VvVmMTDSe18cBPgOKrckTN63cxrQ0DiWBeUpOJsSIM4Vf82aFj9klYmt
        hkk1ayGUff6FVmBA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 10672A3B9D;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 0EA8C51923A4; Tue, 21 Dec 2021 08:22:42 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 25/68] pdc_adma: Drop pointless VPRINTK() calls and remove disabled NCQ debugging
Date:   Tue, 21 Dec 2021 08:20:48 +0100
Message-Id: <20211221072131.46673-26-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211221072131.46673-1-hare@suse.de>
References: <20211221072131.46673-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Drop pointless VPRINTK() calls for entering routines and
setting up sg tables. And while we're at it, remove the
disabled debugging messages.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/pdc_adma.c | 31 ++-----------------------------
 1 file changed, 2 insertions(+), 29 deletions(-)

diff --git a/drivers/ata/pdc_adma.c b/drivers/ata/pdc_adma.c
index 2c910c4cd4de..35b823ac20c9 100644
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
@@ -355,22 +350,6 @@ static enum ata_completion_errors adma_qc_prep(struct ata_queued_cmd *qc)
 
 	i = adma_fill_sg(qc);
 	wmb();	/* flush PRDs and pkt to memory */
-#if 0
-	/* dump out CPB + PRDs for debug */
-	{
-		int j, len = 0;
-		static char obuf[2048];
-		for (j = 0; j < i; ++j) {
-			len += sprintf(obuf+len, "%02x ", buf[j]);
-			if ((j & 7) == 7) {
-				printk("%s\n", obuf);
-				len = 0;
-			}
-		}
-		if (len)
-			printk("%s\n", obuf);
-	}
-#endif
 	return AC_ERR_OK;
 }
 
@@ -379,8 +358,6 @@ static inline void adma_packet_start(struct ata_queued_cmd *qc)
 	struct ata_port *ap = qc->ap;
 	void __iomem *chan = ADMA_PORT_REGS(ap);
 
-	VPRINTK("ENTER, ap %p\n", ap);
-
 	/* fire up the ADMA engine */
 	writew(aPIOMD4 | aGO, chan + ADMA_CONTROL);
 }
@@ -502,14 +479,10 @@ static irqreturn_t adma_intr(int irq, void *dev_instance)
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
 
@@ -545,8 +518,8 @@ static int adma_port_start(struct ata_port *ap)
 		return -ENOMEM;
 	/* paranoia? */
 	if ((pp->pkt_dma & 7) != 0) {
-		printk(KERN_ERR "bad alignment for pp->pkt_dma: %08x\n",
-						(u32)pp->pkt_dma);
+		ata_port_err(ap, "bad alignment for pp->pkt_dma: %08x\n",
+			     (u32)pp->pkt_dma);
 		return -ENOMEM;
 	}
 	ap->private_data = pp;
-- 
2.29.2

