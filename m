Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96C9C433EF
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbhLHQjB (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:39:01 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37752 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237061AbhLHQgx (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:36:53 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6446B1FE32;
        Wed,  8 Dec 2021 16:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nHlH5XdDDEzNvlx34Vrw9e2uA8XGzfuVBRB21IWsXZo=;
        b=vTSR4Ht3eLQnsvFYHHDUdXFFrcUBWC9EHXnbzaLSa46/Bmy2XJ8J2nK/BAau237r5MR1Y9
        WfWc/NsHcZ/z4y9NjuiFKIjqS+iwkzhhLnKSFQs+ZCdj+HHQX/L1y/is7hC9eLQrsTV64k
        5onoh1e0W/Uu513i0+7qFxvLCLtYGA0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981181;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nHlH5XdDDEzNvlx34Vrw9e2uA8XGzfuVBRB21IWsXZo=;
        b=I9KAXvNdR6tl/K/Pst1lD9nbYF4H9Zpq0vc6s4t2A0Qqa9/3ieJdpZryfB99GT+q9xLNfZ
        I5k7e1ew3HIF/0DA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 60E66A3BD7;
        Wed,  8 Dec 2021 16:33:01 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 5B7EB5191FDF; Wed,  8 Dec 2021 17:33:01 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 65/73] pdc_adma: remove disabled debugging messages
Date:   Wed,  8 Dec 2021 17:32:47 +0100
Message-Id: <20211208163255.114660-66-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211208163255.114660-1-hare@suse.de>
References: <20211208163255.114660-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Remove debugging messages for printing out the resulting PRD
as it was permanently disabled anyway.
And convert the remaining printk() statement to structured logging.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/pdc_adma.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/ata/pdc_adma.c b/drivers/ata/pdc_adma.c
index 5d6f460b2356..35b823ac20c9 100644
--- a/drivers/ata/pdc_adma.c
+++ b/drivers/ata/pdc_adma.c
@@ -350,22 +350,6 @@ static enum ata_completion_errors adma_qc_prep(struct ata_queued_cmd *qc)
 
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
 
@@ -534,8 +518,8 @@ static int adma_port_start(struct ata_port *ap)
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

