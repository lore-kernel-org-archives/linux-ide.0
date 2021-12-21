Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FB2C4321E
	for <linux-ide@archiver.kernel.org>; Tue, 21 Dec 2021 07:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbhLUHWz (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 21 Dec 2021 02:22:55 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52660 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbhLUHWo (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Dec 2021 02:22:44 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 281DB21901;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1640071362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rnQ51hkKA+MDS9w2jQaw8pi9usIsNHPERZdQRlIfV9E=;
        b=2B1cjXQmvAIiWH2MUUkxeikiKHcUz/LCgS9sMRxLelYgLXv5fwSWDOKwZBmhgLWN7h6+38
        1kGyyh1wsbgJJ/TcQWWZ2vVSlpOCnjwYAFnbE4wAP+fvnVO0hs4QA9tc3zNldiR8c3WoY7
        8jyOgNdDaHiBlnGuIoSrMopJBSYW3O0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1640071362;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rnQ51hkKA+MDS9w2jQaw8pi9usIsNHPERZdQRlIfV9E=;
        b=kIPBPD2tPxu8Qz/WGEhdRnIWWdVB1ShU/10iLtyqDgD6N1bV0qhliL4vgkSd8+im2yxLb/
        Q9kcNGV4OTclw2Dg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 23C6EA3BA1;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 21F1551923AE; Tue, 21 Dec 2021 08:22:42 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 30/68] sata_rcar: Drop pointless VPRINTK() calls
Date:   Tue, 21 Dec 2021 08:20:53 +0100
Message-Id: <20211221072131.46673-31-hare@suse.de>
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
 drivers/ata/sata_rcar.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index 11e68e3854f8..91b39a6aa9f7 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -379,12 +379,6 @@ static void sata_rcar_tf_load(struct ata_port *ap,
 		iowrite32(tf->hob_lbal, ioaddr->lbal_addr);
 		iowrite32(tf->hob_lbam, ioaddr->lbam_addr);
 		iowrite32(tf->hob_lbah, ioaddr->lbah_addr);
-		VPRINTK("hob: feat 0x%X nsect 0x%X, lba 0x%X 0x%X 0x%X\n",
-			tf->hob_feature,
-			tf->hob_nsect,
-			tf->hob_lbal,
-			tf->hob_lbam,
-			tf->hob_lbah);
 	}
 
 	if (is_addr) {
@@ -393,18 +387,10 @@ static void sata_rcar_tf_load(struct ata_port *ap,
 		iowrite32(tf->lbal, ioaddr->lbal_addr);
 		iowrite32(tf->lbam, ioaddr->lbam_addr);
 		iowrite32(tf->lbah, ioaddr->lbah_addr);
-		VPRINTK("feat 0x%X nsect 0x%X lba 0x%X 0x%X 0x%X\n",
-			tf->feature,
-			tf->nsect,
-			tf->lbal,
-			tf->lbam,
-			tf->lbah);
 	}
 
-	if (tf->flags & ATA_TFLAG_DEVICE) {
+	if (tf->flags & ATA_TFLAG_DEVICE)
 		iowrite32(tf->device, ioaddr->device_addr);
-		VPRINTK("device 0x%X\n", tf->device);
-	}
 
 	ata_wait_idle(ap);
 }
@@ -537,7 +523,6 @@ static void sata_rcar_bmdma_fill_sg(struct ata_queued_cmd *qc)
 
 		prd[si].addr = cpu_to_le32(addr);
 		prd[si].flags_len = cpu_to_le32(sg_len);
-		VPRINTK("PRD[%u] = (0x%X, 0x%X)\n", si, addr, sg_len);
 	}
 
 	/* end-of-table flag */
-- 
2.29.2

