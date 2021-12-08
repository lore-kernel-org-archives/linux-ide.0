Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A45CC43219
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234676AbhLHQjA (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:39:00 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37756 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237086AbhLHQhB (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:37:01 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 663311FE33;
        Wed,  8 Dec 2021 16:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Aa8Df3oUGMqmo/Ik3QidW/eQMbp+j3Wpk+3t/kcya3o=;
        b=1Mc75yImN3ksRVaj7BpnQb3tznVtfotDjjEC8TVaWAthYsKSHw5V2lqc1Pe3eJpBFe5VyX
        y9/R1hLWl+hitySodzW+5pXDnPihU3wRUJndz2S5tXLNXdSjT9cR/3wD6qGrNLaSUsR5di
        9J2rMq5E1VUoheg1gI4DysSExRvGRsM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981181;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Aa8Df3oUGMqmo/Ik3QidW/eQMbp+j3Wpk+3t/kcya3o=;
        b=VjZoD/3dU6HGGZFDPTnZcEUlofVovuRPorFgcrKSgOqCWggC1EPYQ+9LLfYHIwrsDSTIaU
        658FncBUi/y00aBg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 62AD1A3B94;
        Wed,  8 Dec 2021 16:33:01 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 5F82D5191FE1; Wed,  8 Dec 2021 17:33:01 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 66/73] sata_sx4: convert blank printk() calls
Date:   Wed,  8 Dec 2021 17:32:48 +0100
Message-Id: <20211208163255.114660-67-hare@suse.de>
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
 drivers/ata/sata_sx4.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
index 5d7913644dfc..6ceec59cb291 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -1179,15 +1179,16 @@ static unsigned int pdc20621_prog_dimm_global(struct ata_host *host)
 	/* Turn on for ECC */
 	if (!pdc20621_i2c_read(host, PDC_DIMM0_SPD_DEV_ADDRESS,
 			       PDC_DIMM_SPD_TYPE, &spd0)) {
-		pr_err("Failed in i2c read: device=%#x, subaddr=%#x\n",
-		       PDC_DIMM0_SPD_DEV_ADDRESS, PDC_DIMM_SPD_TYPE);
+		dev_err(host->dev,
+			"Failed in i2c read: device=%#x, subaddr=%#x\n",
+			PDC_DIMM0_SPD_DEV_ADDRESS, PDC_DIMM_SPD_TYPE);
 		return 1;
 	}
 	if (spd0 == 0x02) {
 		data |= (0x01 << 16);
 		writel(data, mmio + PDC_SDRAM_CONTROL);
 		readl(mmio + PDC_SDRAM_CONTROL);
-		printk(KERN_ERR "Local DIMM ECC Enabled\n");
+		dev_err(host->dev, "Local DIMM ECC Enabled\n");
 	}
 
 	/* DIMM Initialization Select/Enable (bit 18/19) */
@@ -1279,7 +1280,7 @@ static unsigned int pdc20621_dimm_init(struct ata_host *host)
 	   and program the DIMM Module Controller.
 	*/
 	if (!(speed = pdc20621_detect_dimm(host))) {
-		printk(KERN_ERR "Detect Local DIMM Fail\n");
+		dev_err(host->dev, "Detect Local DIMM Fail\n");
 		return 1;	/* DIMM error */
 	}
 	dev_dbg(host->dev, "Local DIMM Speed = %d\n", speed);
-- 
2.29.2

