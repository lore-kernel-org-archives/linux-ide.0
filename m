Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B201C433FE
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237045AbhLHQhH (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:37:07 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37724 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237021AbhLHQgu (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:36:50 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3469D1FE2A;
        Wed,  8 Dec 2021 16:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=09RVd+ozn0Tw+uSjvzd6JakwtFZAzGAVlxnvW7qH0JI=;
        b=tQSok8DNKLT13m/UGGeOKhf0NSB07jYVhYTjZS3FudXuMUT4Jo7C8OmPyN9MSSQqvdgkAG
        sHm31zLxL0f5qcrLVCGjdk7Uy1Qdylly+HG0GCCIUmYA9BIX7Reb8X38tp50yvy9MdmsYb
        ootRQ6lgW0OKCZVN8bymK15KY5k5RCE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981181;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=09RVd+ozn0Tw+uSjvzd6JakwtFZAzGAVlxnvW7qH0JI=;
        b=L8AkxQK2+XrklVQMI7+2FAfZSizSx6yhTBCbSeTG56SiRZe3dJ/cpc4vx9P92BrnY24vrk
        JLO9G49CnmeS8fDg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 314CBA3BCD;
        Wed,  8 Dec 2021 16:33:01 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 2E33E5191FCF; Wed,  8 Dec 2021 17:33:01 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 57/73] pata_cs5520: convert blank printk() calls
Date:   Wed,  8 Dec 2021 17:32:39 +0100
Message-Id: <20211208163255.114660-58-hare@suse.de>
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
 drivers/ata/pata_cs5520.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_cs5520.c b/drivers/ata/pata_cs5520.c
index 247c14702624..24ce8665b1f9 100644
--- a/drivers/ata/pata_cs5520.c
+++ b/drivers/ata/pata_cs5520.c
@@ -153,12 +153,12 @@ static int cs5520_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	/* Perform set up for DMA */
 	if (pci_enable_device_io(pdev)) {
-		printk(KERN_ERR DRV_NAME ": unable to configure BAR2.\n");
+		dev_err(&pdev->dev, "unable to configure BAR2.\n");
 		return -ENODEV;
 	}
 
 	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32))) {
-		printk(KERN_ERR DRV_NAME ": unable to configure DMA mask.\n");
+		dev_err(&pdev->dev, "unable to configure DMA mask.\n");
 		return -ENODEV;
 	}
 
-- 
2.29.2

