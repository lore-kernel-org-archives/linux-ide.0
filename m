Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E8AC4332F
	for <linux-ide@archiver.kernel.org>; Tue, 21 Dec 2021 07:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235079AbhLUHXI (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 21 Dec 2021 02:23:08 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52660 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235122AbhLUHWy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Dec 2021 02:22:54 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BBEA521996;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1640071362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9+tU5VdVZUA09r+zopHdzO3lLkXdKcuXT1/ZCa4kd+8=;
        b=oSMQBfB/aZuhVhcJbEMYhHQ5sUruksiY2LBiUpg+McHlysT/nE9oU7gLginUdm5ehWyKsQ
        Q19w0RvUetMpAkwtKY8jnFP+ChmSWIl70Osooy3vxgPX2rrRHrBvs30YUrQRDuyISNq2/M
        6n4dzSdmkN8m5kMBULt7lMF3SjyIkEQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1640071362;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9+tU5VdVZUA09r+zopHdzO3lLkXdKcuXT1/ZCa4kd+8=;
        b=zNphnX7nc9WrJQrVeTCsq7u0JHO2UDGcuXS2Xl0CSVByOb15w7kZ1i5RUclerLZMFqeFTJ
        8L5P9rC9OCGnk1Bw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id B71B6A3BBF;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id B525651923EE; Tue, 21 Dec 2021 08:22:42 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 62/68] pata_hpt3x2n: convert pr_XXX() calls
Date:   Tue, 21 Dec 2021 08:21:25 +0100
Message-Id: <20211221072131.46673-63-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211221072131.46673-1-hare@suse.de>
References: <20211221072131.46673-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Convert pr_XXX() calls to structured logging.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/pata_hpt3x2n.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/pata_hpt3x2n.c b/drivers/ata/pata_hpt3x2n.c
index 48eef338e050..1d9d4eec5b8a 100644
--- a/drivers/ata/pata_hpt3x2n.c
+++ b/drivers/ata/pata_hpt3x2n.c
@@ -15,9 +15,6 @@
  * TODO
  *	Work out best PLL policy
  */
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -420,7 +417,7 @@ static int hpt3x2n_pci_clock(struct pci_dev *pdev)
 		u16 sr;
 		u32 total = 0;
 
-		pr_warn("BIOS clock data not set\n");
+		dev_warn(&pdev->dev, "BIOS clock data not set\n");
 
 		/* This is the process the HPT371 BIOS is reported to use */
 		for (i = 0; i < 128; i++) {
@@ -530,7 +527,8 @@ static int hpt3x2n_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 		ppi[0] = &info_hpt372n;
 		break;
 	default:
-		pr_err("PCI table is bogus, please report (%d)\n", dev->device);
+		dev_err(&dev->dev,"PCI table is bogus, please report (%d)\n",
+			dev->device);
 		return -ENODEV;
 	}
 
@@ -579,11 +577,11 @@ static int hpt3x2n_init_one(struct pci_dev *dev, const struct pci_device_id *id)
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

