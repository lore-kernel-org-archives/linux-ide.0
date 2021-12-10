Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87811C43219
	for <linux-ide@archiver.kernel.org>; Fri, 10 Dec 2021 07:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237554AbhLJHdD (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 10 Dec 2021 02:33:03 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:34976 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237547AbhLJHcz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 10 Dec 2021 02:32:55 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A956221115;
        Fri, 10 Dec 2021 07:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639121358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5wV3hf3x8NR/DQPf3a+5ft7miXcVQHomm/O7P0O07bs=;
        b=ZtBdGmuqbjrwEirvlxjyPRCiPwstaehTjsIeSWzYcvjNYRt4QBQQmwppBGCSw1CSLaEpSa
        yTlWsespWuSH1YsKJiNC9VblKzqyHdvvGObnDsJWyPoAFbTdKfWU0EdkUhmFS5vmJe3fPy
        C38ebiMd0ZxkCFEnOn24zHcjHtQYvbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639121358;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5wV3hf3x8NR/DQPf3a+5ft7miXcVQHomm/O7P0O07bs=;
        b=YwJd4qtcPFSfUC4gSLmT6P4Ch27b0ByEDLnj949DxMdMIi05jT9su0gxsqoAlR1uiN6WrM
        QdxD3hgg4YUKgfBg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id A530EA3BA8;
        Fri, 10 Dec 2021 07:29:18 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id A29EA5192045; Fri, 10 Dec 2021 08:29:18 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 18/68] pdc_adma: Remove DPRINTK call
Date:   Fri, 10 Dec 2021 08:28:15 +0100
Message-Id: <20211210072905.15666-19-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211210072905.15666-1-hare@suse.de>
References: <20211210072905.15666-1-hare@suse.de>
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

