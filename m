Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5B6C433F5
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237011AbhLHQhE (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:37:04 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37748 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237057AbhLHQgv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:36:51 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4DBF11FE2E;
        Wed,  8 Dec 2021 16:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SMKza1kXIPmh+V+EcAVpcaDMPH8sMnf15K5lE7kUvfg=;
        b=ZGncu8VFZE8cMEZPbuIig4RnbgGqpnHWzb0IspPH1imJ9XZCPCpRncmzY+bI44ow/Vn7Rf
        QcjoBY2kgzlhNt396z/td1I0HnK0Pzmaeif9v8lgIPo/9gD7cSi34xodAYZdTdHEX9cyrk
        dI6Jngn4VUOAdN9kXmnoO4fV9mySpk0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981181;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SMKza1kXIPmh+V+EcAVpcaDMPH8sMnf15K5lE7kUvfg=;
        b=kCyNC/OhR7UGnc4762uQbTewj1LKo/4NfKwoODcw3SHfWZastfGVfDSMXr/9QUzH+w8jFW
        IfvbgBRd6Yc6d9BA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 489A8A3BD3;
        Wed,  8 Dec 2021 16:33:01 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 452065191FD7; Wed,  8 Dec 2021 17:33:01 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 61/73] pata_marvell: convert blank printk() calls
Date:   Wed,  8 Dec 2021 17:32:43 +0100
Message-Id: <20211208163255.114660-62-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211208163255.114660-1-hare@suse.de>
References: <20211208163255.114660-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Convert the blank printk() call to structured logging and
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

