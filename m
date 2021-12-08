Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6487DC433F5
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237025AbhLHQgw (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:36:52 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37746 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236999AbhLHQgk (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:36:40 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B507D1FE1A;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rnQ51hkKA+MDS9w2jQaw8pi9usIsNHPERZdQRlIfV9E=;
        b=EESgaMzY9V6VKZguGwVwCN/KHRhVTPDMLNpS71p32qOipXIMzMH2ZhU3e+nOa0TbpNiv8/
        xKZZ1nV9Cf/Pt0m4jDvEqrzsqv2KQkiJh8JolltZwZYWw863TnXs8m0kkLUjIJJFhzHfDX
        m0aowUXnYS52nWEykjnRDUynyzvRS4M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981180;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rnQ51hkKA+MDS9w2jQaw8pi9usIsNHPERZdQRlIfV9E=;
        b=4rAJvTlKAMI4HxB31XoSiO7snhhhwlzSr7MCpSeIRE9vreM+kLAHYNUhCU5w+AiJkNrGZp
        g2zVeP71UmZYPqDw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id B15A7A3BB7;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id ADB845191FA7; Wed,  8 Dec 2021 17:33:00 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 37/73] sata_rcar: Drop pointless VPRINTK() calls
Date:   Wed,  8 Dec 2021 17:32:19 +0100
Message-Id: <20211208163255.114660-38-hare@suse.de>
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

