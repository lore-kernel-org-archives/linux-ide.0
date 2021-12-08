Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D0CC4321E
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237007AbhLHQhD (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:37:03 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37888 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237059AbhLHQgx (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:36:53 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5D1A31FE31;
        Wed,  8 Dec 2021 16:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZEHm17/JwRoEu1xeB62DiEZTdRGMzPTrc2dnebs1lkc=;
        b=cGzyMnjEjEadAJFm5rhGms6LB8TwJAqJzkgI6E0FqtfacOYBVo0OCvjOgn+wNaH7PfwK4R
        dpIUT1TyA8cpuh5caAWXJvloZbc3BWq8dObpLc14IlJbZTOCBZHSmZXyaytLJX/G6x4Hlx
        bEF4914O6lp/kpUukR6CRlRK2P4UwCU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981181;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZEHm17/JwRoEu1xeB62DiEZTdRGMzPTrc2dnebs1lkc=;
        b=HuG62D3ifcoo9iCguJ6m1krkjT/8N3r5M1AQrhGME9cJs6ggnWvaLj5yLmrUsD8tf7r3eb
        ThIwikST7xYfz6Dg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 5ABF2A3BD6;
        Wed,  8 Dec 2021 16:33:01 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 564B15191FDD; Wed,  8 Dec 2021 17:33:01 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 64/73] pata_sil680: convert blank printk() calls
Date:   Wed,  8 Dec 2021 17:32:46 +0100
Message-Id: <20211208163255.114660-65-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211208163255.114660-1-hare@suse.de>
References: <20211208163255.114660-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Convert blank printk() calls to structured logging.

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

