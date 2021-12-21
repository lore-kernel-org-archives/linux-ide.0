Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF1FC4332F
	for <linux-ide@archiver.kernel.org>; Tue, 21 Dec 2021 07:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhLUHXC (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 21 Dec 2021 02:23:02 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:55956 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235034AbhLUHWr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Dec 2021 02:22:47 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 41DB21F3C6;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1640071362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=03eFgcJyE0x+BmPLCh2LgIA2Qs4W4r+Mlykzn2IOE4c=;
        b=XwEDXRPBUOdtqmLw3tnFPJWJKjwzMUs2JRorOYKWu75B1BZwLGLdgImfFAEC5jt4lZwb9M
        r9SquBfGXVAwu17i5nsLKNCADTSmZjHcrl/Da7N1A1+CpPw32IfkkGX4tKhrP8PB/8iR/2
        hJjjlxIJwznjOt2eSE1RP3+QtJbtswg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1640071362;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=03eFgcJyE0x+BmPLCh2LgIA2Qs4W4r+Mlykzn2IOE4c=;
        b=mHO1Y4BBn5E3b4l2Kko7gfY80uSgpq/ZTWV4c0iqkjR3UBk7Jzi4frU1XEm5yeRMASgmB2
        jrRRT3RUETDZnXDA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 3D9B4A3BA6;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 3BE7B51923B8; Tue, 21 Dec 2021 08:22:42 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 35/68] sata_sil: Drop pointless VPRINTK() calls
Date:   Tue, 21 Dec 2021 08:20:58 +0100
Message-Id: <20211221072131.46673-36-hare@suse.de>
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

