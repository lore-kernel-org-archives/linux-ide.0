Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62FBC43219
	for <linux-ide@archiver.kernel.org>; Fri, 10 Dec 2021 07:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237562AbhLJHda (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 10 Dec 2021 02:33:30 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:34980 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237633AbhLJHdP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 10 Dec 2021 02:33:15 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 42591212C5;
        Fri, 10 Dec 2021 07:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639121359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Mp8xzMbA3w1HNa28w3f7yS2EgHgcafRb/ojjBBOe4o=;
        b=w0kTacap/Z25e+IPa9RuCHowvBNIIzg9xgD3kJNyjySLunnQYr/1obYeDMMgLiAbO3Yecm
        PzE/v20MCq/gV64T2ShvAfqL68zrHWt8un220IpRRN1STRKV/iEp6oz7a9vF/ZRdbKOMmK
        LPsIBWTmwx2uOBGHc25h4a/89+RyVPc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639121359;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Mp8xzMbA3w1HNa28w3f7yS2EgHgcafRb/ojjBBOe4o=;
        b=p8X6XMkQSNS9B4ve4jtBt6YOZMBlm+rBI1CVwWPYCVmVJzOMNUp8fXEEgBLcc5oGTCHOWp
        Oxs+K9SsyEXFa6Dg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 3E9ECA3BCD;
        Fri, 10 Dec 2021 07:29:19 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 3C0595192093; Fri, 10 Dec 2021 08:29:19 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 57/68] pata_sil680: convert printk() calls
Date:   Fri, 10 Dec 2021 08:28:54 +0100
Message-Id: <20211210072905.15666-58-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211210072905.15666-1-hare@suse.de>
References: <20211210072905.15666-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Convert printk() calls to structured logging.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/pata_sil680.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
index 81238e097fe2..0da58ce20d82 100644
--- a/drivers/ata/pata_sil680.c
+++ b/drivers/ata/pata_sil680.c
@@ -308,17 +308,17 @@ static u8 sil680_init_chip(struct pci_dev *pdev, int *try_mmio)
 
 	switch (tmpbyte & 0x30) {
 	case 0x00:
-		printk(KERN_INFO "sil680: 100MHz clock.\n");
+		dev_info(&pdev->dev, "sil680: 100MHz clock.\n");
 		break;
 	case 0x10:
-		printk(KERN_INFO "sil680: 133MHz clock.\n");
+		dev_info(&pdev->dev, "sil680: 133MHz clock.\n");
 		break;
 	case 0x20:
-		printk(KERN_INFO "sil680: Using PCI clock.\n");
+		dev_info(&pdev->dev, "sil680: Using PCI clock.\n");
 		break;
 	/* This last case is _NOT_ ok */
 	case 0x30:
-		printk(KERN_ERR "sil680: Clock disabled ?\n");
+		dev_err(&pdev->dev, "sil680: Clock disabled ?\n");
 	}
 	return tmpbyte & 0x30;
 }
-- 
2.29.2

