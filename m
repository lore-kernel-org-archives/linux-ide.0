Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01524C4332F
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237018AbhLHQgq (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:36:46 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37758 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237017AbhLHQge (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:36:34 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6E6341FE13;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5wV3hf3x8NR/DQPf3a+5ft7miXcVQHomm/O7P0O07bs=;
        b=0lUF//gjDwB2mAIvE/Pi1mNySU48ZfW7K0BNJJg/gC4jrINzMtg4rjLPgUhWc8k89gQwAf
        K2QQBmoc02m8LX00wfO27AOtl/2HlO3bQkwcF72wHwtWf2a56TVtzGReWb6NjBa5wgxcv6
        Gk/Gf8tmXxPX8iXvlzkgZuM5xOk1kTM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981180;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5wV3hf3x8NR/DQPf3a+5ft7miXcVQHomm/O7P0O07bs=;
        b=Glt03nHnRMAoMdm8y27le5xiFCsnBO022H/B7ryHi5iL2IMv2veQtLw99jEZ/Z+txnHz34
        sCau5xUtc8e5/sCw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 6B2BBA3BAC;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 67C445191F8F; Wed,  8 Dec 2021 17:33:00 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 25/73] pdc_adma: Remove DPRINTK call
Date:   Wed,  8 Dec 2021 17:32:07 +0100
Message-Id: <20211208163255.114660-26-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211208163255.114660-1-hare@suse.de>
References: <20211208163255.114660-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The DPRINTK call doesn't print information which isn't already covered
by tracepoints later on.
Remove it.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/pdc_adma.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/ata/pdc_adma.c b/drivers/ata/pdc_adma.c
index 5db55e1e2a61..2c910c4cd4de 100644
--- a/drivers/ata/pdc_adma.c
+++ b/drivers/ata/pdc_adma.c
@@ -475,8 +475,6 @@ static inline unsigned int adma_intr_mmio(struct ata_host *host)
 			u8 status = ata_sff_check_status(ap);
 			if ((status & ATA_BUSY))
 				continue;
-			DPRINTK("ata%u: protocol %d (dev_stat 0x%X)\n",
-				ap->print_id, qc->tf.protocol, status);
 
 			/* complete taskfile transaction */
 			pp->state = adma_state_idle;
-- 
2.29.2

