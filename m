Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1ECC43219
	for <linux-ide@archiver.kernel.org>; Tue, 21 Dec 2021 07:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbhLUHXH (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 21 Dec 2021 02:23:07 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52642 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbhLUHWy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Dec 2021 02:22:54 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9BB592192D;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1640071362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0qlf+b9FHXif+j+YiCmdQefsapESgx+M4hDwu/PD7IA=;
        b=xQ76mmVqLPetBXWWHRitssSd6MX4npZk2SEwwofaGcnYKdKPKs+Zvgc4Dop9lFOI57YHoH
        fdVIuESvB8U9PNhJMjvNeQuTVK4u6CngF7rCfLSqvYhlfLz2Va67A5sCBNCD1YDj0Owryj
        la8rOM6E0kTrn0JhqLj+IAOz0RBeu5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1640071362;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0qlf+b9FHXif+j+YiCmdQefsapESgx+M4hDwu/PD7IA=;
        b=op9gwnJhEZmpMCiMxo/oX9YDtFefQwRwVsTa48QSUoLtPwhhuDkBCkm9ogBvDPQ9yk3DtF
        x4t3DrHPOHVfTODQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 978A7A3BB9;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 95E0A51923E0; Tue, 21 Dec 2021 08:22:42 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 55/68] pata_rz1000: convert printk() calls
Date:   Tue, 21 Dec 2021 08:21:18 +0100
Message-Id: <20211221072131.46673-56-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211221072131.46673-1-hare@suse.de>
References: <20211221072131.46673-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Convert printk() calls to structured logging.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/pata_rz1000.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_rz1000.c b/drivers/ata/pata_rz1000.c
index 3722a67083fd..fb00c3e5fd19 100644
--- a/drivers/ata/pata_rz1000.c
+++ b/drivers/ata/pata_rz1000.c
@@ -69,7 +69,7 @@ static int rz1000_fifo_disable(struct pci_dev *pdev)
 	reg &= 0xDFFF;
 	if (pci_write_config_word(pdev, 0x40, reg) != 0)
 		return -1;
-	printk(KERN_INFO DRV_NAME ": disabled chipset readahead.\n");
+	dev_info(&pdev->dev, "disabled chipset readahead.\n");
 	return 0;
 }
 
@@ -97,7 +97,7 @@ static int rz1000_init_one (struct pci_dev *pdev, const struct pci_device_id *en
 	if (rz1000_fifo_disable(pdev) == 0)
 		return ata_pci_sff_init_one(pdev, ppi, &rz1000_sht, NULL, 0);
 
-	printk(KERN_ERR DRV_NAME ": failed to disable read-ahead on chipset..\n");
+	dev_err(&pdev->dev, "failed to disable read-ahead on chipset.\n");
 	/* Not safe to use so skip */
 	return -ENODEV;
 }
-- 
2.29.2

