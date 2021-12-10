Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D6CC433FE
	for <linux-ide@archiver.kernel.org>; Fri, 10 Dec 2021 07:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237619AbhLJHdJ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 10 Dec 2021 02:33:09 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:34982 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237581AbhLJHdA (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 10 Dec 2021 02:33:00 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D860621128;
        Fri, 10 Dec 2021 07:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639121358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rnQ51hkKA+MDS9w2jQaw8pi9usIsNHPERZdQRlIfV9E=;
        b=woGmHttWTv56Wkt4hBroolhMgy2KTPYAg61GhJ1z3+UMXeJmyEwotGEMaoaicU8KM/JbvZ
        uXgNoYS2XmAZXDX61YtalrHnKkJQbMZOk9AToevx1YfxaMs5+E7cijTCL0QTAAC7/Eis6v
        YhUwfwyvctIwl9+OOQvMJItMmTXa/zQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639121358;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rnQ51hkKA+MDS9w2jQaw8pi9usIsNHPERZdQRlIfV9E=;
        b=O6z3HLFKdqRPM73lKk1CqOJzvIOdTCc8AKh5PPGY45aWqVFhUOF8wR8BKt+pQ1zK+xl40Y
        YAtNGRs7m+Ek7uDA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id D5426A3BB0;
        Fri, 10 Dec 2021 07:29:18 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id D2EEA519205D; Fri, 10 Dec 2021 08:29:18 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 30/68] sata_rcar: Drop pointless VPRINTK() calls
Date:   Fri, 10 Dec 2021 08:28:27 +0100
Message-Id: <20211210072905.15666-31-hare@suse.de>
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

