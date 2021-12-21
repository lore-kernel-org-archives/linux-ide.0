Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10543C4321E
	for <linux-ide@archiver.kernel.org>; Tue, 21 Dec 2021 07:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbhLUHXM (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 21 Dec 2021 02:23:12 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52732 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235145AbhLUHWy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Dec 2021 02:22:54 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C142E21997;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1640071362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t3U77zRixbknUWyT3Y4ox9jHewaGOcy+Gkww4xxZZ9s=;
        b=pvfsbzwL9hgDgZqnUYHimlNFvYEPINljpvvVONm+uvXzYJ2TSongbwdKJoUWjvS4FIcXwC
        BIFKqG2kp1TRDFn4MUCjmFpnpGrHiMVW4pe/g1x6+phaIpFE1K9lKSUAVdRQWEz6k6A1JM
        AFhek0B0D62pgAaDnz5kbulJtJ96Bkw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1640071362;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t3U77zRixbknUWyT3Y4ox9jHewaGOcy+Gkww4xxZZ9s=;
        b=YKC1hEN64SCzGHMZNxqdWmdw/xMVE359DoOSAzim9x5dxyyJ3MLvsz3Y57PjZYXZm1mD/7
        Ef/s40hcUYXinlDA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id BC798A3BC0;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id BAA5251923F0; Tue, 21 Dec 2021 08:22:42 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 63/68] sata_gemini: convert pr_err() calls
Date:   Tue, 21 Dec 2021 08:21:26 +0100
Message-Id: <20211221072131.46673-64-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211221072131.46673-1-hare@suse.de>
References: <20211221072131.46673-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Convert pr_err() calls to dev_err()

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/sata_gemini.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_gemini.c b/drivers/ata/sata_gemini.c
index f793564f3d78..440a63de20d0 100644
--- a/drivers/ata/sata_gemini.c
+++ b/drivers/ata/sata_gemini.c
@@ -253,12 +253,12 @@ static int gemini_sata_bridge_init(struct sata_gemini *sg)
 
 	ret = clk_prepare_enable(sg->sata0_pclk);
 	if (ret) {
-		pr_err("failed to enable SATA0 PCLK\n");
+		dev_err(dev, "failed to enable SATA0 PCLK\n");
 		return ret;
 	}
 	ret = clk_prepare_enable(sg->sata1_pclk);
 	if (ret) {
-		pr_err("failed to enable SATA1 PCLK\n");
+		dev_err(dev, "failed to enable SATA1 PCLK\n");
 		clk_disable_unprepare(sg->sata0_pclk);
 		return ret;
 	}
-- 
2.29.2

