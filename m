Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0E8C433EF
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237041AbhLHQhE (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:37:04 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37884 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237053AbhLHQgw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:36:52 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 511DF1FE2F;
        Wed,  8 Dec 2021 16:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KAKs9Nnvw38Im+iwfrm5F3uW+rXgnLfV7FASo41Py18=;
        b=WjeLVmL5tC7V1uPZTb30HM9iosddIEqICSx4xD5dMEn7nlZKidslVSaO7U2gIOw24RnaFN
        oWsgOf7DI+lZBN4EBRa7ra88pLfYwjJ0A2yqc5vEyc3dUAvvDCx+tzCFYoW9fC+0xNu/Xj
        w4WnMXlSCZu7W4JQpMW6mNUDt42tJxg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981181;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KAKs9Nnvw38Im+iwfrm5F3uW+rXgnLfV7FASo41Py18=;
        b=wgcpjWItOVEqPeCv/bkNsqMoVP3qtfyxt9uJoH4Gr6XiZTc4nepZhPrOPUb2/ebYKGp+CA
        B3LMxEfoD1BN88Bg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 4ECBDA3BD4;
        Wed,  8 Dec 2021 16:33:01 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 4B2F75191FD9; Wed,  8 Dec 2021 17:33:01 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 62/73] pata_rz1000: convert blank printk() calls
Date:   Wed,  8 Dec 2021 17:32:44 +0100
Message-Id: <20211208163255.114660-63-hare@suse.de>
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
 drivers/ata/pata_rz1000.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_rz1000.c b/drivers/ata/pata_rz1000.c
index 3722a67083fd..8beec884836d 100644
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
+	dev_err(&pdev->dev, "failed to disable read-ahead on chipset..\n");
 	/* Not safe to use so skip */
 	return -ENODEV;
 }
-- 
2.29.2

