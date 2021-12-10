Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0635C433EF
	for <linux-ide@archiver.kernel.org>; Fri, 10 Dec 2021 07:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235135AbhLJHdr (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 10 Dec 2021 02:33:47 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:34986 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237711AbhLJHd1 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 10 Dec 2021 02:33:27 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6775D21763;
        Fri, 10 Dec 2021 07:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639121359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uLKrG7HSGdnX2NHYOGoGgWVeWwHbB7tkdSEuOpqH2Ic=;
        b=z178Nn+sgndcsMi7P6agXAJe3dB/0Y7/jGeBtCiEmAxs52kt8265FTOAAbSHduNKk2+bsL
        cBWxN36FmOx7Os9IYiRnjpE/y2p1GOgnAqfZWFXzD82mt3xUWircK35TymJ3mwpZ1Akq2j
        ZXG9Is8xjNoHpWL6/vatiQf3QiWD1SE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639121359;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uLKrG7HSGdnX2NHYOGoGgWVeWwHbB7tkdSEuOpqH2Ic=;
        b=cBXEZDHB5gURJmsfgG6Qy34r//2OLosLrFcWI0qoXjImz3P9YFbkwRcyFjJUbJk8L2fOsv
        2LhLPax27sHM14BQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 6247BA3BD5;
        Fri, 10 Dec 2021 07:29:19 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 5FDCA51920A5; Fri, 10 Dec 2021 08:29:19 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 66/68] sata_dwc_460ex: drop DEBUG_NCQ
Date:   Fri, 10 Dec 2021 08:29:03 +0100
Message-Id: <20211210072905.15666-67-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211210072905.15666-1-hare@suse.de>
References: <20211210072905.15666-1-hare@suse.de>
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
index 6cdce9d00ed7..78618b3efcbc 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -20,7 +20,6 @@
 
 #ifdef CONFIG_SATA_DWC_VDEBUG
 #define VERBOSE_DEBUG
-#define DEBUG_NCQ
 #endif
 
 #include <linux/kernel.h>
@@ -736,17 +735,6 @@ static void sata_dwc_dma_xfer_complete(struct ata_port *ap, u32 check_status)
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

