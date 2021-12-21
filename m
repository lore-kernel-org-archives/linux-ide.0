Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633B8C4332F
	for <linux-ide@archiver.kernel.org>; Tue, 21 Dec 2021 07:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbhLUHXK (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 21 Dec 2021 02:23:10 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:55970 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235139AbhLUHWy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Dec 2021 02:22:54 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9862A1F3D0;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1640071362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UwjPzVIhDx7X60Zkv4I9Mr4oJ0904mll09kgYSkzcV4=;
        b=gAecfMV4hxIc9NSOTAToq2HDMEJltz5BPXJawOapTFOEKSotLDUR4FYSx/6mz0rhdqRRDk
        aMTPlKkM58GhcT4HCLcRhMf+CozF45EbYV3/K66uIyN3mStHjxQ0u/UJ7jPHp5uYIkPU/t
        PWGlENgka7YdhnwD806WeVFOImip250=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1640071362;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UwjPzVIhDx7X60Zkv4I9Mr4oJ0904mll09kgYSkzcV4=;
        b=PqdksOuo+GrQ/M8zQf7Qz8nmxvemWBJ6rpQYI42KMTXNNWM68t1UlQ2d5McruQ+1kY+9F1
        Lz9d/QAAR5ngxeAw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 939E3A3BB8;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 91FF151923DE; Tue, 21 Dec 2021 08:22:42 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 54/68] pata_marvell: convert printk() calls
Date:   Tue, 21 Dec 2021 08:21:17 +0100
Message-Id: <20211221072131.46673-55-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211221072131.46673-1-hare@suse.de>
References: <20211221072131.46673-1-hare@suse.de>
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

