Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6981C4332F
	for <linux-ide@archiver.kernel.org>; Tue, 21 Dec 2021 07:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbhLUHXA (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 21 Dec 2021 02:23:00 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:55950 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234899AbhLUHWr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Dec 2021 02:22:47 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 230D41F3C3;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1640071362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=blHxTHASdShcDS68QjmW2iURnMqPfvw+I17evoNK+xg=;
        b=ZiVUYeFaiFb/9Qem37xE3IWkLJbLFpHmwnIQTwf8dx/8M1uOR4oZs/4gPo6i35Ihi+9fyc
        MvtllR1R8zvkMug1IwkvJeHuTCl7VaW/ODdP3fTDUKU3EdmlCZnI/pdTU/voYpLqga4jAd
        cEVr8qMPyYQWHJfWc7e211qNC4GYCOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1640071362;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=blHxTHASdShcDS68QjmW2iURnMqPfvw+I17evoNK+xg=;
        b=zJFXZFx30Vu9FrzcUXhvCmz8ZzZ7magsuF80uOFc8NZkj3AYRlzRqk0jJ+fHtvuFRgr3i3
        fqqmtTrEp6XBt7DA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 1EAADA3B83;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 1D42051923AC; Tue, 21 Dec 2021 08:22:42 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 29/68] sata_qstor: Drop pointless VPRINTK() calls
Date:   Tue, 21 Dec 2021 08:20:52 +0100
Message-Id: <20211221072131.46673-30-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211221072131.46673-1-hare@suse.de>
References: <20211221072131.46673-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/sata_qstor.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/ata/sata_qstor.c b/drivers/ata/sata_qstor.c
index 2b4ccdca71c6..db62c07f820f 100644
--- a/drivers/ata/sata_qstor.c
+++ b/drivers/ata/sata_qstor.c
@@ -252,9 +252,6 @@ static unsigned int qs_fill_sg(struct ata_queued_cmd *qc)
 		len = sg_dma_len(sg);
 		*(__le32 *)prd = cpu_to_le32(len);
 		prd += sizeof(u64);
-
-		VPRINTK("PRD[%u] = (0x%llX, 0x%X)\n", si,
-					(unsigned long long)addr, len);
 	}
 
 	return si;
@@ -268,8 +265,6 @@ static enum ata_completion_errors qs_qc_prep(struct ata_queued_cmd *qc)
 	u64 addr;
 	unsigned int nelem;
 
-	VPRINTK("ENTER\n");
-
 	qs_enter_reg_mode(qc->ap);
 	if (qc->tf.protocol != ATA_PROT_DMA)
 		return AC_ERR_OK;
@@ -304,8 +299,6 @@ static inline void qs_packet_start(struct ata_queued_cmd *qc)
 	struct ata_port *ap = qc->ap;
 	u8 __iomem *chan = qs_mmio_base(ap->host) + (ap->port_no * 0x4000);
 
-	VPRINTK("ENTER, ap %p\n", ap);
-
 	writeb(QS_CTR0_CLER, chan + QS_CCT_CTR0);
 	wmb();                             /* flush PRDs and pkt to memory */
 	writel(QS_CCF_RUN_PKT, chan + QS_CCT_CFF);
@@ -435,14 +428,10 @@ static irqreturn_t qs_intr(int irq, void *dev_instance)
 	unsigned int handled = 0;
 	unsigned long flags;
 
-	VPRINTK("ENTER\n");
-
 	spin_lock_irqsave(&host->lock, flags);
 	handled  = qs_intr_pkt(host) | qs_intr_mmio(host);
 	spin_unlock_irqrestore(&host->lock, flags);
 
-	VPRINTK("EXIT\n");
-
 	return IRQ_RETVAL(handled);
 }
 
-- 
2.29.2

