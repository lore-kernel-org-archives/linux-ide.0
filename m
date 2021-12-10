Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB078C4321E
	for <linux-ide@archiver.kernel.org>; Fri, 10 Dec 2021 07:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237584AbhLJHdI (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 10 Dec 2021 02:33:08 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:34986 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237577AbhLJHdA (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 10 Dec 2021 02:33:00 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CF05B21125;
        Fri, 10 Dec 2021 07:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639121358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Oes0C6WbvGaZn9cP0lAWtmTdhlSYjEUp8Fz1FFaypmA=;
        b=pto2eeTAhIEhoPD07KNghT9MKlxmLYt/EvUVpykTqynXvdZUoUe38qpBvYUYrM6Ib3mRcV
        k+qudb1481lvacNjYBBg6rLeX1jC8AsHbcvRpdjIJQEMfJgaCycaBLvKdmnUPKCA7+mTNo
        6MF0pOuuuRD7c5jRInF8KIGsfQA1uOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639121358;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Oes0C6WbvGaZn9cP0lAWtmTdhlSYjEUp8Fz1FFaypmA=;
        b=MVqBXoJ4yjJ13I/R4somg3BpKEoscNKTwXrkLdLRKWJh0rRketH8FI4YZ+VFtXY4hUphoF
        AF5vMoYhNw3qmECA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id CA12BA3BB2;
        Fri, 10 Dec 2021 07:29:18 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id C84875192057; Fri, 10 Dec 2021 08:29:18 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 27/68] pata_via: Drop pointless VPRINTK() calls
Date:   Fri, 10 Dec 2021 08:28:24 +0100
Message-Id: <20211210072905.15666-28-hare@suse.de>
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
 drivers/ata/pata_via.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/ata/pata_via.c b/drivers/ata/pata_via.c
index 475032048984..439ca882f73c 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -414,12 +414,6 @@ static void via_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
 		iowrite8(tf->hob_lbal, ioaddr->lbal_addr);
 		iowrite8(tf->hob_lbam, ioaddr->lbam_addr);
 		iowrite8(tf->hob_lbah, ioaddr->lbah_addr);
-		VPRINTK("hob: feat 0x%X nsect 0x%X, lba 0x%X 0x%X 0x%X\n",
-			tf->hob_feature,
-			tf->hob_nsect,
-			tf->hob_lbal,
-			tf->hob_lbam,
-			tf->hob_lbah);
 	}
 
 	if (is_addr) {
@@ -428,12 +422,6 @@ static void via_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
 		iowrite8(tf->lbal, ioaddr->lbal_addr);
 		iowrite8(tf->lbam, ioaddr->lbam_addr);
 		iowrite8(tf->lbah, ioaddr->lbah_addr);
-		VPRINTK("feat 0x%X nsect 0x%X lba 0x%X 0x%X 0x%X\n",
-			tf->feature,
-			tf->nsect,
-			tf->lbal,
-			tf->lbam,
-			tf->lbah);
 	}
 
 	ata_wait_idle(ap);
-- 
2.29.2

