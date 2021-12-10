Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13257C4332F
	for <linux-ide@archiver.kernel.org>; Fri, 10 Dec 2021 07:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237508AbhLJHdC (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 10 Dec 2021 02:33:02 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:34982 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237559AbhLJHcz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 10 Dec 2021 02:32:55 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B29DC21118;
        Fri, 10 Dec 2021 07:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639121358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VtlAyAn9YmcTUt33wVPTsEhwTfN1ElRhv02qacBJorw=;
        b=zAOVKNZuehT2cH5/V4VdCCAKA0hv+yL2tHVGGTNclpoBAQoUCipdrCtajp54R2O1E7VUbi
        1rEKoHbJIC2R+xa7MZ9Pd5bdtp78C2wEKcnkgdsB90IxnaBI8jeSQ/+eexJrUUut/UzlTj
        ylRLKBhcLCwQTmccyFcUzKCvKUulNG4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639121358;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VtlAyAn9YmcTUt33wVPTsEhwTfN1ElRhv02qacBJorw=;
        b=xGD1HzqMw31uOek6Rv4iLuURc4knK6fWNuACHfU9K9Qvy0AiqM+x6B4FL0d632l3aABGJ9
        lbllQ/8R3BVbcnDA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id AEAA2A3BAA;
        Fri, 10 Dec 2021 07:29:18 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id AC24C5192049; Fri, 10 Dec 2021 08:29:18 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 20/68] sata_rcar: replace DPRINTK() with ata_port_dbg()
Date:   Fri, 10 Dec 2021 08:28:17 +0100
Message-Id: <20211210072905.15666-21-hare@suse.de>
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

