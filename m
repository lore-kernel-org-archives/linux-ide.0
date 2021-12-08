Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5F6C433F5
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbhLHQjA (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:39:00 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37754 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237087AbhLHQhB (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:37:01 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 73F741FE36;
        Wed,  8 Dec 2021 16:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GT3lsbE3EWFvqCBxNBQiMMA/bU3F4A0t4qdp3snIgpQ=;
        b=rBfeaGqYm0GlyN6TPcSaEjtPvSZyEnQMCcOPDKe8gaWQvf7QvUDsyOX3fyP8vfusTFNKJd
        /+gTT09eFJF4yQt4Sk1McWpFYQne3La0VUMF5pF7mmU0k0PVtWADDBqmzqfJy/2gTqODKj
        T7q4FRSWh8IVTSBMk3oriD/oR6fpTq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981181;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GT3lsbE3EWFvqCBxNBQiMMA/bU3F4A0t4qdp3snIgpQ=;
        b=l793zP2jPgqxJYR/+VmHzqkE1u53z8jK9Q/8O9RI+2DWE5qCv3XAnzbt0tsAsjjktAaBZh
        xXogLHWefgzM5mBw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 70FC5A3BDA;
        Wed,  8 Dec 2021 16:33:01 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 6DF2D5191FE7; Wed,  8 Dec 2021 17:33:01 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 69/73] pata_octeon_cf: Replace pr_XXX() calls with structured logging
Date:   Wed,  8 Dec 2021 17:32:51 +0100
Message-Id: <20211208163255.114660-70-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211208163255.114660-1-hare@suse.de>
References: <20211208163255.114660-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/pata_octeon_cf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
index de27428920a0..64bb65ef8f02 100644
--- a/drivers/ata/pata_octeon_cf.c
+++ b/drivers/ata/pata_octeon_cf.c
@@ -273,9 +273,9 @@ static void octeon_cf_set_dmamode(struct ata_port *ap, struct ata_device *dev)
 	dma_tim.s.we_n = ns_to_tim_reg(tim_mult, oe_n);
 	dma_tim.s.we_a = ns_to_tim_reg(tim_mult, oe_a);
 
-	pr_debug("ns to ticks (mult %d) of %d is: %d\n", tim_mult, 60,
+	ata_dev_dbg(dev, "ns to ticks (mult %d) of %d is: %d\n", tim_mult, 60,
 		 ns_to_tim_reg(tim_mult, 60));
-	pr_debug("oe_n: %d, oe_a: %d, dmack_s: %d, dmack_h: %d, dmarq: %d, pause: %d\n",
+	ata_dev_dbg(dev, "oe_n: %d, oe_a: %d, dmack_s: %d, dmack_h: %d, dmarq: %d, pause: %d\n",
 		 dma_tim.s.oe_n, dma_tim.s.oe_a, dma_tim.s.dmack_s,
 		 dma_tim.s.dmack_h, dma_tim.s.dmarq, dma_tim.s.pause);
 
-- 
2.29.2

