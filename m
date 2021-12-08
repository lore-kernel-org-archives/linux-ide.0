Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16296C433FE
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbhLHQi7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:38:59 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37896 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237093AbhLHQhB (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:37:01 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 77C351FE37;
        Wed,  8 Dec 2021 16:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oGmXXZVQI5i2WJv5WgD6i9U6gy94TrpEoKACP7sM+ZE=;
        b=0+Ph0Gw7TK7mtGHujVXbqbQ9PoDkZ9jeUAO1MkTCtPFewufVXW7UhqEjMJZ8TN2ThoeC1N
        3nxWmMD1uSGXAvFSN+NBuhz80Zlu9w8t/CvGdrV/vRoqbtwjUlWSNlS1FPq7r7yakUjszq
        qoppq+3JjpX9JhbzKEeViaYhKFxoIaM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981181;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oGmXXZVQI5i2WJv5WgD6i9U6gy94TrpEoKACP7sM+ZE=;
        b=mYZ1WgOFUo2WxqeUT98X57GiBsTVSDJhodp66maMY0SbKmgbG/qEK38LeX62M2s3yGFYvS
        hkZYt3fMbomf5QDQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 75F06A3BDB;
        Wed,  8 Dec 2021 16:33:01 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 72C1C5191FE9; Wed,  8 Dec 2021 17:33:01 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 70/73] pata_hpt3x2n: convert pr_XXX() calls
Date:   Wed,  8 Dec 2021 17:32:52 +0100
Message-Id: <20211208163255.114660-71-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211208163255.114660-1-hare@suse.de>
References: <20211208163255.114660-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Convert pr_XXX() calls to structured logging.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/pata_hpt3x2n.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/pata_hpt3x2n.c b/drivers/ata/pata_hpt3x2n.c
index 48eef338e050..60e7d71328f6 100644
--- a/drivers/ata/pata_hpt3x2n.c
+++ b/drivers/ata/pata_hpt3x2n.c
@@ -16,8 +16,6 @@
  *	Work out best PLL policy
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -420,7 +418,7 @@ static int hpt3x2n_pci_clock(struct pci_dev *pdev)
 		u16 sr;
 		u32 total = 0;
 
-		pr_warn("BIOS clock data not set\n");
+		dev_warn(&pdev->dev, "BIOS clock data not set\n");
 
 		/* This is the process the HPT371 BIOS is reported to use */
 		for (i = 0; i < 128; i++) {
@@ -530,7 +528,8 @@ static int hpt3x2n_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 		ppi[0] = &info_hpt372n;
 		break;
 	default:
-		pr_err("PCI table is bogus, please report (%d)\n", dev->device);
+		dev_err(&dev->dev,"PCI table is bogus, please report (%d)\n",
+			dev->device);
 		return -ENODEV;
 	}
 
@@ -579,11 +578,11 @@ static int hpt3x2n_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 		pci_write_config_dword(dev, 0x5C, (f_high << 16) | f_low);
 	}
 	if (adjust == 8) {
-		pr_err("DPLL did not stabilize!\n");
+		dev_err(&dev->dev, "DPLL did not stabilize!\n");
 		return -ENODEV;
 	}
 
-	pr_info("bus clock %dMHz, using 66MHz DPLL\n", pci_mhz);
+	dev_info(&dev->dev, "bus clock %dMHz, using 66MHz DPLL\n", pci_mhz);
 
 	/*
 	 * Set our private data up. We only need a few flags
-- 
2.29.2

