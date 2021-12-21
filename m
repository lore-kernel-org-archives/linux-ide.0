Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9493C433EF
	for <linux-ide@archiver.kernel.org>; Tue, 21 Dec 2021 07:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbhLUHXJ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 21 Dec 2021 02:23:09 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52658 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235124AbhLUHWy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Dec 2021 02:22:54 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CDB5121999;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1640071362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V/spF9TBasnqGOyaxt4hwB537bq1BzBP0MrdRwFVeVY=;
        b=UGESFl5g5F/TCcN6Rv7MkPJQAqvpENK+Ky6gF0bB1LLEKptAJEHwOll/HxV2IvfBq+l10q
        F8VEi3ZkXFbYyhV4M3iNBLuhvXRHaHLlSL0qggo53D/ZadnWEeyb2HkhtdpKd2Qop7vh4q
        lId74XOb15jZJEr5H7nfEgkiI/NRn78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1640071362;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V/spF9TBasnqGOyaxt4hwB537bq1BzBP0MrdRwFVeVY=;
        b=43KwRgK/J9N1OEOnlHtJTOBZIEp1PQZPScAIkV+UVYwgZL/0VX/1bmukTl935rF+jt0beK
        qE3rxzj4RY0cZqDA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id C9241A3BC3;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id C77AA51923F6; Tue, 21 Dec 2021 08:22:42 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 66/68] sata_dwc_460ex: drop DEBUG_NCQ
Date:   Tue, 21 Dec 2021 08:21:29 +0100
Message-Id: <20211221072131.46673-67-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211221072131.46673-1-hare@suse.de>
References: <20211221072131.46673-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Obsolete, and has been converted to tracepoints.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/sata_dwc_460ex.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 55c07c1fa69d..448d88cf1b38 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -20,7 +20,6 @@
 
 #ifdef CONFIG_SATA_DWC_VDEBUG
 #define VERBOSE_DEBUG
-#define DEBUG_NCQ
 #endif
 
 #include <linux/kernel.h>
@@ -734,17 +733,6 @@ static void sata_dwc_dma_xfer_complete(struct ata_port *ap, u32 check_status)
 		return;
 	}
 
-#ifdef DEBUG_NCQ
-	if (tag > 0) {
-		dev_info(ap->dev,
-			 "%s tag=%u cmd=0x%02x dma dir=%s proto=%s dmacr=0x%08x\n",
-			 __func__, qc->hw_tag, qc->tf.command,
-			 get_dma_dir_descript(qc->dma_dir),
-			 get_prot_descript(qc->tf.protocol),
-			 sata_dwc_readl(&hsdev->sata_dwc_regs->dmacr));
-	}
-#endif
-
 	if (ata_is_dma(qc->tf.protocol)) {
 		if (hsdevp->dma_pending[tag] == SATA_DWC_DMA_PENDING_NONE) {
 			dev_err(ap->dev,
-- 
2.29.2

