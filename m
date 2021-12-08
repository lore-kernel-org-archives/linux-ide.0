Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BBAC4332F
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236983AbhLHQg5 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:36:57 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37888 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237001AbhLHQgl (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:36:41 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BE9421FE1C;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pk8O0Pga7cVsfugoLOSOLGDrMehfaIPmIeQG0Gu9zMc=;
        b=XK/OrU1nrrkJQ053dNmy6A0+1tqsgO9FjW7kM+4dlx1ACDzjkR9BY16vb7XMklTxO7seO5
        HbszLNttu929y9ZFzMTBaV3O6Wt2m+HhH2r7l5Jp8p5yeTUTI0eXij+khdXWkV/Owd0OrK
        ld3+xomJShv0f06u446mshzWfjhtlZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981180;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pk8O0Pga7cVsfugoLOSOLGDrMehfaIPmIeQG0Gu9zMc=;
        b=x2TDLdLQe34cqOA9/4g4pVIZxes7eFSBgnzNG6L7ad403M8fafwamhLr4u8merBlscUvsp
        KBwGmUAcmA3RjTCA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id BC48EA3BB9;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id B91945191FAB; Wed,  8 Dec 2021 17:33:00 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 39/73] sata_mv: Drop pointless VPRINTK() call and convert the remaining one
Date:   Wed,  8 Dec 2021 17:32:21 +0100
Message-Id: <20211208163255.114660-40-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211208163255.114660-1-hare@suse.de>
References: <20211208163255.114660-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Drop pointless VPRINTK() call and convert the remaining one to dev_dbg().

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/sata_mv.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index e86eddf83704..4f3fa54c8f64 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -3723,11 +3723,6 @@ static void mv_port_init(struct ata_ioports *port,  void __iomem *port_mmio)
 
 	/* unmask all non-transient EDMA error interrupts */
 	writelfl(~EDMA_ERR_IRQ_TRANSIENT, port_mmio + EDMA_ERR_IRQ_MASK);
-
-	VPRINTK("EDMA cfg=0x%08x EDMA IRQ err cause/mask=0x%08x/0x%08x\n",
-		readl(port_mmio + EDMA_CFG),
-		readl(port_mmio + EDMA_ERR_IRQ_CAUSE),
-		readl(port_mmio + EDMA_ERR_IRQ_MASK));
 }
 
 static unsigned int mv_in_pcix_mode(struct ata_host *host)
@@ -3972,7 +3967,7 @@ static int mv_init_host(struct ata_host *host)
 	for (hc = 0; hc < n_hc; hc++) {
 		void __iomem *hc_mmio = mv_hc_base(mmio, hc);
 
-		VPRINTK("HC%i: HC config=0x%08x HC IRQ cause "
+		dev_dbg(host->dev, "HC%i: HC config=0x%08x HC IRQ cause "
 			"(before clear)=0x%08x\n", hc,
 			readl(hc_mmio + HC_CFG),
 			readl(hc_mmio + HC_IRQ_CAUSE));
-- 
2.29.2

