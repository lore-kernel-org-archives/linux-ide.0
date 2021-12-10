Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FA2C433FE
	for <linux-ide@archiver.kernel.org>; Fri, 10 Dec 2021 07:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237592AbhLJHdb (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 10 Dec 2021 02:33:31 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:35096 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237639AbhLJHdP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 10 Dec 2021 02:33:15 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 52FD5212CC;
        Fri, 10 Dec 2021 07:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639121359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gSqbo4+jE2ofuPWYyHDVb1K94S91dhRhb+mYBEXXfvI=;
        b=PWln67j9ezbimvcJg00TIiu0egUlaBFw3ce5R56yBEisetTbg4hWSQCaUtTKfBUQvg5xrH
        CibMjhMkoD8BHl7f70qEPR7eBu6sSZtV9AxY2UUJZQMYvkpsA+kqEYGEN1nbDvTluH+Cl0
        B0/FdI+rzwv0lrwsgdVcp0NPisYYH/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639121359;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gSqbo4+jE2ofuPWYyHDVb1K94S91dhRhb+mYBEXXfvI=;
        b=DySE25Eg3y3qBHd1KazW/cxxBf7vltHTtDrSogDVVxXElIoefulvFNMz8TWiVxgluoOSHu
        VQH/QkOIuaRuF+CA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 4EDCAA3BD0;
        Fri, 10 Dec 2021 07:29:19 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 4C12B519209B; Fri, 10 Dec 2021 08:29:19 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 61/68] pata_octeon_cf: Replace pr_XXX() calls with structured logging
Date:   Fri, 10 Dec 2021 08:28:58 +0100
Message-Id: <20211210072905.15666-62-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211210072905.15666-1-hare@suse.de>
References: <20211210072905.15666-1-hare@suse.de>
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
index a2e7dcaa87ac..df62e22b49a6 100644
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

