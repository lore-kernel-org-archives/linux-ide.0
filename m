Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6BCC4332F
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbhLHQjC (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:39:02 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37750 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237060AbhLHQgx (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:36:53 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5792D1FE30;
        Wed,  8 Dec 2021 16:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1XAiWCLJ9B5zQUXD8uGg8+n7nqkNd2b1lPCv/TVPQGI=;
        b=u0OiIlUtjmletrPLf6N7X33YbnjzvGecyyH4SAeI/sxICVchHEijXN7W4StaiBFBh4S79f
        9R9zcnooHyMZDqXPhXGRLRif/KHaraAVNhCWO2cHQ2Ro/5S1n8je0INHRaMUS6ZMIzIv79
        dj4VSHgRa8blwgjngjhg2JW2Pn9zZxk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981181;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1XAiWCLJ9B5zQUXD8uGg8+n7nqkNd2b1lPCv/TVPQGI=;
        b=YcdYtuuv+OvsAzjHot0OIl1tyZ4+2BIi2zrDWa5U0KQGq4Cjq0XrPMd2a6h3CNR5MCRJP9
        b2BsrQNb0MaqF7BQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 53D76A3BD5;
        Wed,  8 Dec 2021 16:33:01 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 502D45191FDB; Wed,  8 Dec 2021 17:33:01 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 63/73] pata_serverworks: convert blank printk() calls
Date:   Wed,  8 Dec 2021 17:32:45 +0100
Message-Id: <20211208163255.114660-64-hare@suse.de>
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
 drivers/ata/pata_serverworks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_serverworks.c b/drivers/ata/pata_serverworks.c
index b602e303fb54..e410fe44177f 100644
--- a/drivers/ata/pata_serverworks.c
+++ b/drivers/ata/pata_serverworks.c
@@ -286,13 +286,13 @@ static int serverworks_fixup_osb4(struct pci_dev *pdev)
 		pci_read_config_dword(isa_dev, 0x64, &reg);
 		reg &= ~0x00002000; /* disable 600ns interrupt mask */
 		if (!(reg & 0x00004000))
-			printk(KERN_DEBUG DRV_NAME ": UDMA not BIOS enabled.\n");
+			dev_info(&pdev->dev, "UDMA not BIOS enabled.\n");
 		reg |=  0x00004000; /* enable UDMA/33 support */
 		pci_write_config_dword(isa_dev, 0x64, reg);
 		pci_dev_put(isa_dev);
 		return 0;
 	}
-	printk(KERN_WARNING DRV_NAME ": Unable to find bridge.\n");
+	dev_warn(&pdev->dev, "Unable to find bridge.\n");
 	return -ENODEV;
 }
 
-- 
2.29.2

