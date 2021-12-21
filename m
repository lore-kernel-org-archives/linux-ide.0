Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D83AC433EF
	for <linux-ide@archiver.kernel.org>; Tue, 21 Dec 2021 07:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbhLUHXB (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 21 Dec 2021 02:23:01 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:55890 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbhLUHWr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Dec 2021 02:22:47 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 319991F3C5;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1640071362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0SnrAAwJ24fFi6cxpGFquWBljyfIs92OZxgH6qCowz8=;
        b=QJtA6gVkrTzTQLyENiVSK3T1RZGKyf/JIA/QkzfAeO2slKvO5kNDEY9WHk6umPRLBeojvz
        TZbUavTtJkZ8PQ2b9OFLbuK8mchms+gIpBlXICd/KvbJGKJJd5KhtBWWWTujH3lRtsJ5XR
        EFya5s17xOggUVld6+79EyjrhTrDnYg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1640071362;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0SnrAAwJ24fFi6cxpGFquWBljyfIs92OZxgH6qCowz8=;
        b=D9SSG2qxLlbXH+ZztdjtwUV0JgWYfRJvW+uR3R+5OYiq0iSN9Z5kEEWhB9snbHCH+GMzNQ
        S7JPhTAwzCwHWnAQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 2D5DCA3BA3;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 2B71051923B2; Tue, 21 Dec 2021 08:22:42 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 32/68] sata_mv: Drop pointless VPRINTK() call and convert the remaining one
Date:   Tue, 21 Dec 2021 08:20:55 +0100
Message-Id: <20211221072131.46673-33-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211221072131.46673-1-hare@suse.de>
References: <20211221072131.46673-1-hare@suse.de>
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
index 40a92c89e6d7..7ce1fb635874 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -3716,11 +3716,6 @@ static void mv_port_init(struct ata_ioports *port,  void __iomem *port_mmio)
 
 	/* unmask all non-transient EDMA error interrupts */
 	writelfl(~EDMA_ERR_IRQ_TRANSIENT, port_mmio + EDMA_ERR_IRQ_MASK);
-
-	VPRINTK("EDMA cfg=0x%08x EDMA IRQ err cause/mask=0x%08x/0x%08x\n",
-		readl(port_mmio + EDMA_CFG),
-		readl(port_mmio + EDMA_ERR_IRQ_CAUSE),
-		readl(port_mmio + EDMA_ERR_IRQ_MASK));
 }
 
 static unsigned int mv_in_pcix_mode(struct ata_host *host)
@@ -3965,7 +3960,7 @@ static int mv_init_host(struct ata_host *host)
 	for (hc = 0; hc < n_hc; hc++) {
 		void __iomem *hc_mmio = mv_hc_base(mmio, hc);
 
-		VPRINTK("HC%i: HC config=0x%08x HC IRQ cause "
+		dev_dbg(host->dev, "HC%i: HC config=0x%08x HC IRQ cause "
 			"(before clear)=0x%08x\n", hc,
 			readl(hc_mmio + HC_CFG),
 			readl(hc_mmio + HC_IRQ_CAUSE));
-- 
2.29.2

