Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC14BC433EF
	for <linux-ide@archiver.kernel.org>; Fri, 10 Dec 2021 07:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237621AbhLJHdP (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 10 Dec 2021 02:33:15 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:34970 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237586AbhLJHdA (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 10 Dec 2021 02:33:00 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E8D0921136;
        Fri, 10 Dec 2021 07:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639121358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=03eFgcJyE0x+BmPLCh2LgIA2Qs4W4r+Mlykzn2IOE4c=;
        b=jJxtRQ01CIt9a58XdNavIw2adowQpRa0uJblo2bKaPTSy9c1g16hEaGNKf4fjfF0+v78qN
        VbGooID9+qEifvLZD+3mOu+IQp2CLsOJmj/Bm2CeqnPZbHBd//I3BTKrCwK032CBmj6stQ
        REaR/tCH627BHSh/7v0m1c3WgsyuRfA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639121358;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=03eFgcJyE0x+BmPLCh2LgIA2Qs4W4r+Mlykzn2IOE4c=;
        b=QGE8aFnXwPrvZ2XT/S7rIvRtLKpze0KS2qOAEMRG5d/TGB7gRwUTja6XVhKtHSaiT7DIRK
        juKEPuBLpjK56FDw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id E4DB7A3BB8;
        Fri, 10 Dec 2021 07:29:18 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id E25405192067; Fri, 10 Dec 2021 08:29:18 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 35/68] sata_sil: Drop pointless VPRINTK() calls
Date:   Fri, 10 Dec 2021 08:28:32 +0100
Message-Id: <20211210072905.15666-36-hare@suse.de>
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

