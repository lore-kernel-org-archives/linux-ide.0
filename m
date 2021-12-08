Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D64C433F5
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237016AbhLHQgq (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:36:46 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37760 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237018AbhLHQge (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:36:34 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7B62F1FE14;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VtlAyAn9YmcTUt33wVPTsEhwTfN1ElRhv02qacBJorw=;
        b=D8lYjzqMeWaZ7mySxQHU1p2PTc0Pl1oiPWuAmVaHvZRdPtVVB9clKTOTEWJWiIqq97LJ4m
        UJ5a1h3zZA0LQk5e3NwJW09TvBv3JjwJ/G+h+Q/Rc1b5hfW/vK3rPI4ao4QULVwLZH8795
        0ANtaTJe2s+jvfBMYxzSCdFqip73ldk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981180;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VtlAyAn9YmcTUt33wVPTsEhwTfN1ElRhv02qacBJorw=;
        b=SDnSLExq1HIT28b0YFjCqaxhc2XCe2tO/chVrintU1Y7vwdRJ+vQJZJRq1Yw54D+7UuicX
        cycvuQz8GxDfMwCg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 77524A3BAE;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 734265191F93; Wed,  8 Dec 2021 17:33:00 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 27/73] sata_rcar: replace DPRINTK() with ata_port_dbg()
Date:   Wed,  8 Dec 2021 17:32:09 +0100
Message-Id: <20211208163255.114660-28-hare@suse.de>
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
 drivers/ata/sata_rcar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index b4994d182eda..11e68e3854f8 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -679,7 +679,7 @@ static void sata_rcar_serr_interrupt(struct ata_port *ap)
 	if (!serror)
 		return;
 
-	DPRINTK("SError @host_intr: 0x%x\n", serror);
+	ata_port_dbg(ap, "SError @host_intr: 0x%x\n", serror);
 
 	/* first, analyze and record host port events */
 	ata_ehi_clear_desc(ehi);
-- 
2.29.2

