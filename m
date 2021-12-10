Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A4DC433FE
	for <linux-ide@archiver.kernel.org>; Fri, 10 Dec 2021 07:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237578AbhLJHdb (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 10 Dec 2021 02:33:31 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:35090 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237636AbhLJHdP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 10 Dec 2021 02:33:15 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 35D29212C3;
        Fri, 10 Dec 2021 07:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639121359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UwjPzVIhDx7X60Zkv4I9Mr4oJ0904mll09kgYSkzcV4=;
        b=P2w+bhWj9Mjl/TgvSId1G7/FS22+YDEE9QMhpEVkU0PExFwIRN/n0pmuIYP5iQfx8uOqga
        7WyqE1ZJxJuwNjv8pUTvvQflj7kmdbf/CTUBE8tL0idswopaAQUxH8V8HbKU0Kt7JYbmc2
        nQZXkAc71aIeCN4NvNw0wmM8ZMlqQ74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639121359;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UwjPzVIhDx7X60Zkv4I9Mr4oJ0904mll09kgYSkzcV4=;
        b=1/l4LTUTctqAxrdudCxHfs9x3cvoMtSBoirh24K/xPZ2Lc5CJf80PFZxOYh7tYuw90lWoe
        QIShdWB9fBreBqAA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 31C60A3BCA;
        Fri, 10 Dec 2021 07:29:19 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 2FC08519208D; Fri, 10 Dec 2021 08:29:19 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 54/68] pata_marvell: convert printk() calls
Date:   Fri, 10 Dec 2021 08:28:51 +0100
Message-Id: <20211210072905.15666-55-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211210072905.15666-1-hare@suse.de>
References: <20211210072905.15666-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Convert the printk() call to structured logging and
drop the pointless PCI bar debug messages.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/pata_marvell.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/pata_marvell.c b/drivers/ata/pata_marvell.c
index 361597d14c56..0c5a51970fbf 100644
--- a/drivers/ata/pata_marvell.c
+++ b/drivers/ata/pata_marvell.c
@@ -32,7 +32,6 @@
 
 static int marvell_pata_active(struct pci_dev *pdev)
 {
-	int i;
 	u32 devices;
 	void __iomem *barp;
 
@@ -44,11 +43,6 @@ static int marvell_pata_active(struct pci_dev *pdev)
 	if (barp == NULL)
 		return -ENOMEM;
 
-	printk("BAR5:");
-	for(i = 0; i <= 0x0F; i++)
-		printk("%02X:%02X ", i, ioread8(barp + i));
-	printk("\n");
-
 	devices = ioread32(barp + 0x0C);
 	pci_iounmap(pdev, barp);
 
@@ -149,7 +143,8 @@ static int marvell_init_one (struct pci_dev *pdev, const struct pci_device_id *i
 
 #if IS_ENABLED(CONFIG_SATA_AHCI)
 	if (!marvell_pata_active(pdev)) {
-		printk(KERN_INFO DRV_NAME ": PATA port not active, deferring to AHCI driver.\n");
+		dev_info(&pdev->dev,
+			 "PATA port not active, deferring to AHCI driver.\n");
 		return -ENODEV;
 	}
 #endif
-- 
2.29.2

