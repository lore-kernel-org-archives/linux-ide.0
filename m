Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CFAC433F5
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237066AbhLHQg6 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:36:58 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37752 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237007AbhLHQgn (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:36:43 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D1A061FE1F;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=03eFgcJyE0x+BmPLCh2LgIA2Qs4W4r+Mlykzn2IOE4c=;
        b=pxJqcjjDg9WbOgSVBf1GlB/UOCHEpmbbhgRO4m7ZtNJ12gxHrIbG0glunjT8MjDDXyLkdt
        3eIfL8Ohz66KsgqEj7uk4TeSZmgD8LpstHtFT9SxEeABSGjnx0oIZFiwEVF4iXdauL155Q
        GW8bdf8AedH8kge8AMW3hOAOd64yP2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981180;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=03eFgcJyE0x+BmPLCh2LgIA2Qs4W4r+Mlykzn2IOE4c=;
        b=km9CM+2Xz4c7lZgKRmN+5MtGOd+6158IhdNFz61l+WgNeBOITB6zz3ML2wv7nWzyb4UUeg
        EaGPDVC49y0mwlBA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id CE756A3BBC;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id C9D9A5191FB1; Wed,  8 Dec 2021 17:33:00 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 42/73] sata_sil: Drop pointless VPRINTK() calls
Date:   Wed,  8 Dec 2021 17:32:24 +0100
Message-Id: <20211208163255.114660-43-hare@suse.de>
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
 drivers/ata/sata_sil.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index 75321f1ceba5..3b989a52879d 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -307,7 +307,6 @@ static void sil_fill_sg(struct ata_queued_cmd *qc)
 
 		prd->addr = cpu_to_le32(addr);
 		prd->flags_len = cpu_to_le32(sg_len);
-		VPRINTK("PRD[%u] = (0x%X, 0x%X)\n", si, addr, sg_len);
 
 		last_prd = prd;
 		prd++;
-- 
2.29.2

