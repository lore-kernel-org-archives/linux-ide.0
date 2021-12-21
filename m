Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75AE7C433F5
	for <linux-ide@archiver.kernel.org>; Tue, 21 Dec 2021 07:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbhLUHXL (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 21 Dec 2021 02:23:11 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52728 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235142AbhLUHWy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Dec 2021 02:22:54 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B351821980;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1640071362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2TcklWt3Kchfbg2eBocqBUFRFhfOPTQA9d8yCjTSBW8=;
        b=XKZPlVUAsrHg4Hfn2+GYIj8/mB1p0BCa78wXW4C3gT47la/Ecu9PDnm63v0FM9jH82uJ2x
        RrixsR6fWCvJjFYC+zEDklACRLte+behP8XE3knqjXXqwzMKhQtyZmamoBTKe/DCtqrqiK
        dhW88QSTJ1ZbCKBv7F9bEX6c3hS6cEk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1640071362;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2TcklWt3Kchfbg2eBocqBUFRFhfOPTQA9d8yCjTSBW8=;
        b=VHVrZpTarFt89wKOe/kPt0U6hiqgRleRhmKAiz1CNjLbl+fCr0hE1XUPiUoQ/ggUUVcMu+
        ithLdGzecmFHkUAg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id AE739A3BBE;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id ACB6451923EA; Tue, 21 Dec 2021 08:22:42 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 60/68] pata_hpt37x: convert pr_XXX() calls
Date:   Tue, 21 Dec 2021 08:21:23 +0100
Message-Id: <20211221072131.46673-61-hare@suse.de>
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
 drivers/ata/pata_hpt37x.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/pata_hpt37x.c b/drivers/ata/pata_hpt37x.c
index f242157bc81b..7abc7e04f656 100644
--- a/drivers/ata/pata_hpt37x.c
+++ b/drivers/ata/pata_hpt37x.c
@@ -14,9 +14,6 @@
  * TODO
  *	Look into engine reset on timeout errors. Should not be	required.
  */
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -231,7 +228,8 @@ static int hpt_dma_blacklisted(const struct ata_device *dev, char *modestr,
 
 	i = match_string(list, -1, model_num);
 	if (i >= 0) {
-		pr_warn("%s is not supported for %s\n", modestr, list[i]);
+		ata_dev_warn(dev, "%s is not supported for %s\n",
+			     modestr, list[i]);
 		return 1;
 	}
 	return 0;
@@ -864,7 +862,8 @@ static int hpt37x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 			chip_table = &hpt372;
 			break;
 		default:
-			pr_err("Unknown HPT366 subtype, please report (%d)\n",
+			dev_err(&dev->dev,
+				"Unknown HPT366 subtype, please report (%d)\n",
 			       rev);
 			return -ENODEV;
 		}
@@ -905,7 +904,8 @@ static int hpt37x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 			*ppi = &info_hpt374_fn1;
 		break;
 	default:
-		pr_err("PCI table is bogus, please report (%d)\n", dev->device);
+		dev_err(&dev->dev, "PCI table is bogus, please report (%d)\n",
+			dev->device);
 		return -ENODEV;
 	}
 	/* Ok so this is a chip we support */
@@ -953,7 +953,7 @@ static int hpt37x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 		u8 sr;
 		u32 total = 0;
 
-		pr_warn("BIOS has not set timing clocks\n");
+		dev_warn(&dev->dev, "BIOS has not set timing clocks\n");
 
 		/* This is the process the HPT371 BIOS is reported to use */
 		for (i = 0; i < 128; i++) {
@@ -1009,7 +1009,7 @@ static int hpt37x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 					       (f_high << 16) | f_low | 0x100);
 		}
 		if (adjust == 8) {
-			pr_err("DPLL did not stabilize!\n");
+			dev_err(&dev->dev, "DPLL did not stabilize!\n");
 			return -ENODEV;
 		}
 		if (dpll == 3)
@@ -1017,7 +1017,7 @@ static int hpt37x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 		else
 			private_data = (void *)hpt37x_timings_50;
 
-		pr_info("bus clock %dMHz, using %dMHz DPLL\n",
+		dev_info(&dev->dev, "bus clock %dMHz, using %dMHz DPLL\n",
 			MHz[clock_slot], MHz[dpll]);
 	} else {
 		private_data = (void *)chip_table->clocks[clock_slot];
@@ -1032,7 +1032,7 @@ static int hpt37x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 		if (clock_slot < 2 && ppi[0] == &info_hpt370a)
 			ppi[0] = &info_hpt370a_33;
 
-		pr_info("%s using %dMHz bus clock\n",
+		dev_info(&dev->dev, "%s using %dMHz bus clock\n",
 			chip_table->name, MHz[clock_slot]);
 	}
 
-- 
2.29.2

