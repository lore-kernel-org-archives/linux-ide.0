Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2561EC433F5
	for <linux-ide@archiver.kernel.org>; Fri, 10 Dec 2021 07:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237644AbhLJHdi (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 10 Dec 2021 02:33:38 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:34978 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237682AbhLJHdZ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 10 Dec 2021 02:33:25 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5A85021637;
        Fri, 10 Dec 2021 07:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639121359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t3U77zRixbknUWyT3Y4ox9jHewaGOcy+Gkww4xxZZ9s=;
        b=nDwOd1tS71jaiBq8ig+f0iudMUv6iMwBeymbVZGqobAN3UMH1LGU/avqB8hLzNmPFfOYEd
        Eh3LrvqU6miw4yBR4fhImG/dNjqyuh7UpOhVkJe8PoPmSpIqt9toNOYhhaKsRxk0kEuQdL
        8pO8cpmCwv7jwa5huFFiZ5dKh9HELCY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639121359;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t3U77zRixbknUWyT3Y4ox9jHewaGOcy+Gkww4xxZZ9s=;
        b=XlKUC3GDLiKhN5nWcUcPErFAAhtDaMbkw5ZMWCNKbVYxWjhYtNR7dWuGRWdxWJO7We7709
        Vq3R6XBy4o9Yi3CA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 54FFAA3BD2;
        Fri, 10 Dec 2021 07:29:19 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 53488519209F; Fri, 10 Dec 2021 08:29:19 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 63/68] sata_gemini: convert pr_err() calls
Date:   Fri, 10 Dec 2021 08:29:00 +0100
Message-Id: <20211210072905.15666-64-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211210072905.15666-1-hare@suse.de>
References: <20211210072905.15666-1-hare@suse.de>
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

